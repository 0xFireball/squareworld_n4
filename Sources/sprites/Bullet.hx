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
		var hitRangeF = 1.5;
		if (Math.abs(Registry.PS.player.x - this.x) < Registry.PS.player.width / hitRangeF && Math.abs(Registry.PS.player.y - this.y) < Registry.PS.player.height / hitRangeF) {
			// hit player
			Registry.PS.player.x = (Math.random() * 0.8 + 0.1) * NGame.width;
			Registry.PS.player.y = (Math.random() * 0.8 + 0.1) * NGame.height;
			for (i in 0...15) {
				Registry.PS.emitter
					.emit(x, y, 9, NSquareParticleEmitter.velocitySpread(100, 
							Registry.PS.player.velocity.x / 2,
							Registry.PS.player.velocity.y / 2),
						NColorUtil.randCol(0.3, 0.3, 0.3),
						0.8
					);
			}
			for (i in 0...9) {
				Registry.PS.emitter
					.emit(x, y, 9, NSquareParticleEmitter.velocitySpread(75, 
							Registry.PS.player.velocity.x / 2,
							Registry.PS.player.velocity.y / 2),
						NColorUtil.randCol(1, 0.1, 0),
						0.8
					);
			}
		}
		Registry.PS.emitter
			.emit(x, y, 3, NSquareParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0.7, 0, 0),
				0.3
			);
		super.update(dt);
	}
}