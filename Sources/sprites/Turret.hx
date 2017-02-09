package sprites;

import kha.Color;
import n4.entities.NSprite;

class Turret extends NSprite {
	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		mass = 220;
		makeGraphic(20, 20, Color.fromValue(0xFF444444));
	}
}