package sprites;

import kha.Color;
import kha.input.Keyboard;
import kha.Key;
import n4.entities.NSprite;

class Player extends NSprite {

	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		makeGraphic(20, 20, Color.Red);
		velocity.x = 300;
		acceleration.x = -140;
	}
}