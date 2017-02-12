package;

import n4.NGame;

class Main {
	public static function main() {
		NGame.init("shapes2", 
		// #if sys_html5
		// 	0, 0,
		// #else
		// 	1024, 768,
		// #end
		1024, 768,
			PlayState, 60);
	}
}
