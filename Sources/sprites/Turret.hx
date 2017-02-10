package sprites;

import kha.Color;
import n4.entities.NSprite;

class Turret extends NSprite {
	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		mass = 180;
		angularVelocity = Math.PI / 2;
		makeGraphic(30, 30, Color.fromValue(0xFF444444));
	}
}