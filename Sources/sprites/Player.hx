package sprites;

import kha.Color;
import kha.input.Keyboard;
import kha.Key;
import n4.entities.NSprite;
import n4.math.NPoint;
import n4.NGame;

class Player extends NSprite {

	public var speed:Float = 50;

	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		makeGraphic(20, 20, Color.Blue);
		drag = new NPoint(280, 280);
		maxVelocity = new NPoint(120, 120);
	}

	private function movement() {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;

		_up = NGame.keys.getKey("UP");
		_down = NGame.keys.getKey("DOWN");
		_left = NGame.keys.getKey("LEFT");
		_right = NGame.keys.getKey("RIGHT");

		// Cancel double directions
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		if (_left || _right || _up || _down)
		{
			if (_up)
			{
				velocity.y -= speed;
			}
			if (_down)
			{
				velocity.y += speed;
			}
			if (_left)
			{
				velocity.x -= speed;
			}
			if (_right)
			{
				velocity.x += speed;
			}
		}
	}

	override public function update(dt:Float) {
		movement();

		super.update(dt);
	} 
}