package;

import sprites.Player;
import n4.NState;

class PlayState extends NState {

	private var _player:Player;

	override public function create() {
		_player = new Player();
		add(_player);

		super.create();
	}
}