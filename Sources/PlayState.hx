package;

import kha.Color;
import kha.math.*;
import n4.NState;
import n4.effects.particles.NSquareParticleEmitter;
import n4.group.NTypedGroup;
import n4.NGame;
import n4.util.NColorUtil;
import sprites.*;

class PlayState extends NState {
	private var _bullets:NTypedGroup<Bullet>;
	private var _turret:Turret;
	public var player(default, null):Player;
	public var emitter(default, null):NSquareParticleEmitter;

	private var _frameCount = 0;
	public var shotTimer:Float = 0.2;

	override public function create() {
		Registry.PS = this;

		bgColor = Color.fromValue(0xFFEEEEEE);

		player = new Player();
		add(player);

		_turret = new Turret(NGame.width / 2 - 10, NGame.height / 2 - 10);
		add(_turret);

		_bullets = new NTypedGroup<Bullet>();
		add(_bullets);

		emitter = new NSquareParticleEmitter(100);
		add(emitter);

		super.create();
	}

	override public function update(dt:Float) {
		super.update(dt);

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

	function turretFire() {
		var bulletSp = 350;
		var dx = (_turret.x + _turret.width / 2) - (player.x + player.width / 2);
		var dy = (_turret.y + _turret.height / 2) - (player.y + player.height / 2);
		var m = -Math.sqrt(dx*dx + dy*dy);
		shoot(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, dx*bulletSp/m, dy*bulletSp/m);
	}

 	function shoot(x:Float, y:Float, dx:Float, dy:Float):Void {
		 var bullet = new Bullet(x, y);
		 bullet.velocity.x = dx;
		 bullet.velocity.y = dy;
		 _bullets.add(bullet);
		 var recoilSpeed = bullet.momentum / _turret.mass;
		 var recoilMotion = new FastVector2(bullet.velocity.x, bullet.velocity.y);
		 recoilMotion.normalize();
		 var recoilVelocity = recoilMotion.mult(-recoilSpeed);
		 _turret.velocity.x += recoilVelocity.x;
		 _turret.velocity.y += recoilVelocity.y;
		 if (_turret.x > NGame.width) _turret.x = _turret.x % NGame.width;
		 if (_turret.y > NGame.height) _turret.y = _turret.y % NGame.height;
		 if (_turret.x < 0) _turret.x += NGame.width;
		 if (_turret.y < 0) _turret.y += NGame.height;
		 for (i in 0...19) {
			 emitter.emit(x, y, 6,
					NSquareParticleEmitter.velocitySpread(45, dx / 4, dy / 4),
					NColorUtil.randCol(0.5, 0.5, 0.5), 0.6);
		 }
	 }
}