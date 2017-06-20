package sprites;

import kha.Color;
import n4.effects.particles.NParticleEmitter;
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
			.emitSquare(x, y, 3, NParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0.7, 0, 0),
				0.3
			);

		// if (x > Registry.PS.player.x
		// 	&& x < Registry.PS.player.x + Registry.PS.player.width
		// 	&& y > Registry.PS.player.y
		// 	&& y < Registry.PS.player.y + Registry.PS.player.height)
		// {
			
		// }

		super.update(dt);
	}
}