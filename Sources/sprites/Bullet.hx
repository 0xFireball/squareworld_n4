package sprites;

import kha.Color;
import n4.effects.particles.NSquareParticleEmitter;
import n4.entities.NSprite;
import n4.NGame;
import n4.util.NColorUtil;

class Bullet extends NSprite {
	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		mass = 1.5;
		makeGraphic(8, 8, Color.fromValue(0xFF000000));
	}

	public override function update(dt:Float) {
		Registry.PS.emitter
			.emit(x, y, 3, NSquareParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0.7, 0, 0),
				0.3
			);
		super.update(dt);
	}
}