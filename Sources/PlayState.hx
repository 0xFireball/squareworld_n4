package;

import kha.Color;
import n4.NState;
import n4.group.NTypedGroup;
import n4.NGame;
import sprites.*;

class PlayState extends NState {

	private var _player:Player;
	private var _bullets:NTypedGroup<Bullet>;
	private var _turret:Turret;

	override public function create() {
		bgColor = Color.fromValue(0xFFEEEEEE);

		_player = new Player();
		add(_player);

		_turret = new Turret(NGame.width / 2 - 10, NGame.height / 2 - 10);
		add(_turret);

		_bullets = new NTypedGroup<Bullet>();
		add(_bullets);

		super.create();
	}
}