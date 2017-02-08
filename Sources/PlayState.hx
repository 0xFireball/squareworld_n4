package;

import kha.Color;
import n4.NState;
import sprites.Player;

class PlayState extends NState {

	private var _player:Player;

	override public function create() {
		bgColor = Color.fromValue(0xAAEEEEEE);

		_player = new Player();
		add(_player);

		super.create();
	}
}