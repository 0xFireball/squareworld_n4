package sprites;

import kha.Color;
import kha.input.KeyCode;
import n4.entities.NSprite;
import n4.math.NPoint;
import n4.NG;

class Player extends NSprite {

	public var speed:Float = 50;

	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		makeGraphic(20, 20, Color.Blue);
		drag = new NPoint(280, 280);
		maxVelocity = new NPoint(120, 120);
	}

	private function movement() {
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = NG.keys.pressed([KeyCode.Up, KeyCode.W]);
		down = NG.keys.pressed([KeyCode.Down, KeyCode.S]);
		left = NG.keys.pressed([KeyCode.Left, KeyCode.A]);
		right = NG.keys.pressed([KeyCode.Right, KeyCode.D]);

		if (up || down || left || right)
		{
			// Cancel double directions
			if (up && down)
				up = down = false;
			if (left && right)
				left = right = false;
			var mA = 0; // movement angle
			if (left || right || up || down)
			{
				if (up)
				{
					mA = -90;
					if (left)
					{
						mA -= 45;
					}
					if (right)
					{
						mA += 45;
					}
				}
				else if (down)
				{
					mA = 90;
					if (left)
					{
						mA += 45;
					}
					if (right)
					{
						mA -= 45;
					}
				}
				else if (left)
				{
					mA = 180;
				}
				else if (right)
				{
					mA = 0;
				}
			}
			var movementVel = new NPoint(speed, 0);
			velocity.addPoint(movementVel.rotate(new NPoint(0, 0), mA));
		}
	}

	override public function update(dt:Float) {
		movement();

		super.update(dt);
	}
}