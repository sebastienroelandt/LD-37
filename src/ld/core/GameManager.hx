package ld.core;

import ld.ui.player.Player;
import ld.ui.ennemies.MonstersManager;
import ld.ui.bullets.BulletsManager;
import lib.sro.core.GameController;
import lib.sro.core.ResourcesStorage;
import lib.sro.engine.CollisionBox;
import lib.sro.entity.Entity;
import lib.sro.screen.Screen;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.TiledMapUI;
import lib.sro.core.Bresenham;
import openfl.display.Sprite;
import ld.ui.screen.MenuScreen;
import ld.ui.screen.PlayScreen;
import ld.ui.screen.SplashScreen;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	public function new()
	{
		var assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		GameController.assets = assets;
		
		super();
		
		this.addScreen(new SplashScreen(this));
		this.addScreen(new MenuScreen(this));
		this.addScreen(new PlayScreen(this));
		
		start();
	}
	
	
	
	public override function update() {
		super.update();
	}
}