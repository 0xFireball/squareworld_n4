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

	private var _player:Player;
	private var _bullets:NTypedGroup<Bullet>;
	private var _turret:Turret;
	private var _emitter:NSquareParticleEmitter;

	private var _frameCount = 0;
	public var shotTimer:Float = 0.2;

	override public function create() {
		Registry.PS = this;

		bgColor = Color.fromValue(0xFFEEEEEE);

		_player = new Player();
		add(_player);

		_turret = new Turret(NGame.width / 2 - 10, NGame.height / 2 - 10);
		add(_turret);

		_bullets = new NTypedGroup<Bullet>();
		add(_bullets);

		_emitter = new NSquareParticleEmitter();
		add(_emitter);

		super.create();
	}

	override public function update(dt:Float) {
		super.update(dt);

		if ((shotTimer -= dt) <= 0) {
			turretFire();
			shotTimer = 0.2;
		}

		// shooting particles
		// ++_frameCount;
		// if (_frameCount % 12 == 0) {
		// 	for (i in 0...20) {
		// 		_emitter.emit(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, 6,
		// 			_emitter.velocitySpread(45),
		// 			NColorUtil.randCol(0.5, 0.5, 0.5), 0.6);
		// 	}
		// }
	}

	function turretFire() {
		var bulletSp = 350;
		var dx = (_turret.x + _turret.width / 2) - (_player.x + _player.width / 2);
		var dy = (_turret.y + _turret.height / 2) - (_player.y + _player.height / 2);
		var m = -Math.sqrt(dx*dx + dy*dy);
		shoot(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, dx*bulletSp/m, dy*bulletSp/m);
	}

 	function shoot(x:Float, y:Float, dx:Float, dy:Float):Void {
		 for (i in 0...19) {
			 _emitter.emit(x, y, 6,
					_emitter.velocitySpread(45, dx/4, dy/4),
					NColorUtil.randCol(0.5, 0.5, 0.5), 0.6);
		 }
	 }
}