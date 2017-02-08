package sprites;

import kha.Color;
import n4.entities.NSprite;

class Bullet extends NSprite {
	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		makeGraphic(8, 8, Color.fromValue(0xFF000000));
	}
}