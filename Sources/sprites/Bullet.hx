package sprites;

import kha.Color;
import n4.effects.particles.NSquareParticleEmitter;
import n4.entities.NSprite;
import n4.util.NColorUtil;

class Bullet extends NSprite {
	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		makeGraphic(8, 8, Color.fromValue(0xFF000000));
	}

	public override function update(dt:Float) {
		// for (i in 0...9) {
		// 	Registry.PS.emitter
		// 		.emit(x, y, 9, NSquareParticleEmitter.velocitySpread(75, 
		// 				Registry.PS.player.velocity.x / 2,
		// 				Registry.PS.player.velocity.y / 2),
		// 			NColorUtil.randCol(1, 0.1, 0),
		// 			0.8
		// 		);
		// }
		Registry.PS.emitter
			.emit(x, y, 3, NSquareParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0.7, 0, 0),
				0.3
			);
		super.update(dt);
	}
}