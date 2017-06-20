package;

import n4.NGame;

class Main {
	public static function main() {
		NGame.syncDrawUpdate = true;
		NGame.init("squareworld_n4", 
		#if sys_html5
			0, 0,
		#else
			1024, 768,
		#end
			PlayState, 60);
	}
}
