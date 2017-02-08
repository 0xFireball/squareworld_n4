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

	override public function create() {
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

		++_frameCount;
		if (_frameCount % 12 == 0) {
			for (i in 0...20) {
				_emitter.emit(_turret.x + _turret.width / 2, _turret.y + _turret.height / 2, 6,
					_emitter.velocitySpread(45),
					NColorUtil.randCol(0.5, 0.5, 0.5), 0.6);
			}
		}
	}
}