package;

import kha.Color;
import n4.NState;
import n4.effects.particles.NParticleEmitter;
import n4.group.NTypedGroup;
import n4.math.*;
import n4.*;
import n4.util.NColorUtil;
import sprites.*;

class PlayState extends NState {
	private var _bullets:NTypedGroup<Bullet>;
	private var _turret:Turret;
	public var player(default, null):Player;
	public var emitter(default, null):NParticleEmitter;

	private var _frameCount = 0;
	public var shotTimer:Float = 0.2;

	override public function create() {
		Registry.PS = this;

		bgColor = Color.fromValue(0xFFEEEEEE);

		player = new Player(Math.random() * NGame.width, Math.random() * NGame.height);
		add(player);

		_turret = new Turret(NGame.width / 2 - 10, NGame.height / 2 - 10);
		add(_turret);

		_bullets = new NTypedGroup<Bullet>();
		add(_bullets);

		emitter = new NParticleEmitter(240);
		add(emitter);

		super.create();
	}

	override public function update(dt:Float) {
		super.update(dt);

		NG.overlap(_bullets, player, bulletHitPlayer);

		if (player.x < 0) player.x = 0;
		if (player.x > NGame.width - player.width) player.x = NGame.width - player.width;
		if (player.y < 0) player.y = 0;
		if (player.y > NGame.height - player.height) player.y = NGame.height - player.height;

		_bullets.forEachActive(function (bullet) {
			if (bullet.x < 0 || bullet.x > NGame.width || bullet.y < 0 || bullet.y > NGame.height) {
				bullet.destroy();
			}
		});

		if ((shotTimer -= dt) <= 0) {
			turretFire();
			shotTimer = 0.2;
		}
	}

	static function bulletHitPlayer(b:Bullet, p:Player) {
		// hit player
		p.x = (Math.random() * 0.8 + 0.1) * NGame.width;
		p.y = (Math.random() * 0.8 + 0.1) * NGame.height;
		for (i in 0...15) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(100, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(0.3, 0.3, 0.3),
					0.8
				);
		}
		for (i in 0...9) {
			Registry.PS.emitter
				.emitSquare(b.x, b.y, 9, NParticleEmitter.velocitySpread(75, 
						p.velocity.x / 2,
						p.velocity.y / 2),
					NColorUtil.randCol(1, 0.1, 0),
					0.8
				);
		}
	}

	function turretFire() {
		var bulletSp = 350;
		// var fancy = player.velocity.toVector().length > 0;
		var fancy = true;
		if (!fancy) {
			var dx = (_turret.x + _turret.width / 2) - (player.x + player.width / 2);
			var dy = (_turret.y + _turret.height / 2) - (player.y + player.height / 2);
			var m = -Math.sqrt(dx*dx + dy*dy);
			shoot(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, dx*bulletSp/m, dy*bulletSp/m);
		} else {
			var px:Float = _turret.x - player.x;
			var py:Float = _turret.y - player.y;
			var vx:Float = player.velocity.x;
			var vy:Float = player.velocity.y;
			var m:Float = Math.sqrt(vx * vx + vy * vy);
			var sin = m == 0 ? 0 : vy / m;
			var cos = m == 0 ? 1 : vx / m;
			var rot = function (x:Float, y:Float) {
				return [x * cos + y * sin, y * cos - x * sin];
			}
			var vr1 = rot(vx, vy);
			vx = vr1[0];
			vy = vr1[1];
			var vr2 = rot(px, py);
			px = vr2[0];
			py = vr2[1];

			py = -py;
			var adf2 = 2 * vx * px / py;
			var df = 1 + (px * px) / (py * py);

			// calculate the result
			var disc = adf2 * adf2 + 4 * df * (bulletSp * bulletSp - vx * vx);
			if (disc < 0) return;
			disc = Math.sqrt(disc);
			df *= 2;
			sin = -sin; // invert rot

			var c1 = (adf2 + disc) / df;
			var b1 = vx - c1 * px / py;
			var t1 = py / c1;
			var res1 = rot(b1, c1);
			var c2 = (adf2 - disc) / df;
			var b2 = vx - c2 * px / py;
			var t2 = py / c2;
			var res2 = rot(b2, c2);

			var ret = [];
			if (t1 < 0) ret = res2;
  			else if (t2 < 0) ret = res1;
  			else ret = t1 < t2 ? res1 : res2;
			
			shoot(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, ret[0], ret[1]);
		}
	}

 	function shoot(x:Float, y:Float, dx:Float, dy:Float):Void {
		 var bullet = new Bullet(x, y);
		 bullet.velocity.x = dx;
		 bullet.velocity.y = dy;
		 _bullets.add(bullet);
		 var recoilVelocity = bullet.momentum.toVector().scale(-1 / _turret.mass);
		 _turret.velocity.x += recoilVelocity.x;
		 _turret.velocity.y += recoilVelocity.y;
		 if (_turret.x > NGame.width) _turret.x = _turret.x % NGame.width;
		 if (_turret.y > NGame.height) _turret.y = _turret.y % NGame.height;
		 if (_turret.x < 0) _turret.x += NGame.width;
		 if (_turret.y < 0) _turret.y += NGame.height;
		 for (i in 0...19) {
			 emitter.emitSquare(x, y, 6,
					NParticleEmitter.velocitySpread(45, dx / 4, dy / 4),
					NColorUtil.randCol(0.5, 0.5, 0.5), 0.6);
		 }
	 }
}