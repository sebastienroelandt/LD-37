package ld.ui.screen;

import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.TiledMapUI;
import ld.ui.player.Player;
import ld.ui.ennemies.MonstersManager;
import ld.ui.ennemies.MonstersGenerator;
import ld.ui.bullets.BulletsManager;
import lib.sro.core.GameController;
import lib.sro.input.Mouse;
import lib.sro.input.Keys;
import openfl.display.Sprite;
import lib.sro.engine.CollisionBox;
import lib.sro.sound.MusicManager;
import lib.sro.core.Text;
import openfl.geom.Point;
import openfl.text.TextField;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Sebastien roelandt
 */
class PlayScreen extends Screen
{
	private var rect 		: Sprite;
	private var playlayer 	:DrawableLayer;
	private var endLayer 	:DrawableLayer;
	private var playbar 	:PlayBar;
	private var screenController : ScreenController;
	private var scoreText		: TextField;
	
	public function new(screenController:ScreenController) {
		super();
		
		this.screenController = screenController;
		MusicManager.getInstance().start(GameController.assets.getSound("music"));
		
		playbar = new PlayBar();
		this.add(playbar);
		
		playlayer = new DrawableLayer();
		playlayer.y = 80;
		Mouse.setVerticalDelta( -80);
		
		var map:TiledMapUI = new TiledMapUI(GameController.assets.getTileset("arena_tileset"), 
			[[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2],
			[8,29,29,29,29,29,25,25,25,29,29,29,29,29,29,29,29,25,25,29,29,29,29,29,29,29,29,29,29,25,29,29,29,29,29,25,29,29,29,29,29,25,25,29,29,29,29,10],
			[8,37,37,37,37,37,37,33,33,33,37,37,37,37,37,37,33,33,37,37,37,37,37,37,37,37,37,37,33,33,37,37,37,37,37,33,37,37,37,33,37,33,37,37,37,37,37,10],
			[8,42,42,42,42,42,42,42,41,42,42,42,42,42,42,42,41,41,42,42,42,42,42,42,42,42,42,42,41,42,42,42,42,42,42,41,42,42,42,41,41,41,42,42,42,42,42,10],
			[8,7,7,7,7,6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,6,6,6,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,7,6,7,7,6,7,7,4,4,4,4,4,4,4,4,4,10],
			[8,7,6,6,7,7,15,7,7,7,7,7,20,7,7,6,6,7,7,7,7,7,7,7,6,7,7,7,6,7,7,7,6,7,7,6,6,7,4,4,4,4,4,4,4,4,4,10],
			[8,7,6,7,7,7,7,7,7,6,6,7,19,7,7,7,7,7,7,7,6,6,7,7,6,7,15,7,7,7,7,7,7,7,7,6,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,6,6,7,6,6,7,7,7,19,7,7,7,7,7,15,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,7,6,6,7,6,6,7,7,19,7,7,6,6,7,7,6,7,7,7,7,7,6,7,7,7,7,6,7,7,7,7,7,7,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,15,7,6,6,6,7,7,7,19,6,6,6,7,6,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,15,7,6,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,7,7,7,7,7,7,7,7,19,6,7,7,7,6,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,7,7,7,7,7,7,7,7,19,7,7,7,7,7,7,7,7,14,6,7,7,7,7,7,7,7,14,7,7,6,7,7,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,16,17,17,17,17,17,17,17,17,18,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,6,7,7,7,7,7,7,7,6,6,4,4,4,4,4,4,4,4,4,10],
			[8,7,7,7,7,14,7,7,6,6,7,7,6,7,14,7,7,14,7,7,7,7,7,7,6,7,7,7,7,7,7,7,7,6,7,7,6,6,7,7,7,7,7,7,7,7,7,10],
			[8,7,7,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,7,7,7,7,7,7,14,7,6,7,7,7,6,6,6,7,7,6,6,7,7,7,10],
			[8,7,7,7,14,7,7,6,7,7,7,7,15,7,7,7,7,7,7,14,7,6,7,7,7,7,7,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,6,6,7,7,10],
			[8,7,7,7,7,7,7,7,6,7,7,7,7,6,7,7,7,7,7,7,7,6,6,7,7,7,6,7,7,7,7,7,6,7,7,7,7,7,7,6,6,7,7,7,7,7,7,10],
			[8,7,7,7,7,7,7,7,7,6,6,7,7,6,6,7,7,7,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,7,6,6,6,7,7,7,7,7,7,7,7,10],
			[8,7,4,7,7,7,7,7,7,7,7,7,7,7,7,7,6,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,10],
			[8,7,4,4,7,14,7,7,7,7,7,7,7,7,7,7,7,6,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,14,7,7,7,7,7,7,7,7,7,7,7,10],
			[8,7,4,4,7,7,7,7,6,7,7,7,7,7,6,7,7,7,7,7,7,7,14,6,6,6,7,7,7,7,7,7,14,7,7,6,7,7,6,6,7,7,7,7,7,14,7,10],
			[8,7,4,4,7,7,7,7,6,7,7,7,14,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,15,7,7,7,7,7,7,6,6,6,7,7,7,7,7,10],
			[8,7,4,4,7,7,7,7,7,7,15,7,7,7,7,7,7,7,7,7,7,6,7,7,7,7,7,7,7,6,7,7,7,7,15,6,6,7,7,7,7,7,7,7,7,7,7,10],
			[8,7,4,4,7,7,6,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,10],
			[8,7,4,4,4,7,6,7,6,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,6,7,7,6,6,15,7,7,7,7,7,7,7,7,7,10],
			[8,7,4,4,4,7,7,7,6,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,6,7,7,7,7,6,6,7,7,7,7,7,7,15,6,7,7,7,7,7,7,7,7,10],
			[8,7,7,4,4,7,7,7,6,6,7,7,7,7,6,6,7,7,7,7,6,7,7,7,7,14,7,7,7,7,7,7,7,7,15,7,7,7,7,7,14,7,7,7,7,14,7,10],
			[8,7,7,4,4,7,7,7,7,6,6,7,7,7,7,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,7,7,10],
			[8,7,7,4,4,4,7,7,7,7,6,7,7,7,7,7,7,7,7,7,15,6,7,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,10],
			[8,7,7,7,4,4,7,7,7,6,7,7,7,7,7,7,7,7,15,7,7,6,6,7,7,7,7,7,14,7,7,7,7,7,7,7,6,6,7,7,7,7,6,6,7,7,7,10],
			[8,7,7,7,4,4,7,7,7,6,7,7,7,7,7,7,7,7,7,6,7,7,6,7,7,6,7,7,7,7,7,7,7,7,6,6,7,7,7,7,7,7,7,6,7,7,7,10],
			[8,7,7,7,7,4,7,7,7,6,7,6,6,6,7,7,7,7,7,6,7,7,7,7,7,7,7,7,7,7,7,7,7,6,7,6,6,6,6,6,6,6,6,7,7,7,7,10],
			[8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,10],
			[8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,10],
			[8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10],
			[28,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,30],
			[36,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,38],
			[44,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,46]], [8,9,10,42,41]);
		
		playlayer.add(map);
		
		var HImage = GameController.assets.getBitmap("HImage");
		HImage.x = 50;
		HImage.y = 70;
		HImage.alpha = 0.8;
		playlayer.addChild(HImage);
		
		var player = new Player(GameController.assets.getStatedAnimationData("player"), null);
		player.addCollideTo(map);
		player.setPosition(200, 200); 
		player.setScreen(this);
		playlayer.add(player);
		
		var monstersManager = MonstersManager.getInstance(true);
		monstersManager.target = player;
		playlayer.add(monstersManager);
		
		rect = new Sprite();
		playlayer.addChild(rect);
		
		var bulletsManager = BulletsManager.getInstance(true);
		playlayer.add(bulletsManager);
		
		var monsterGenerator = MonstersGenerator.getInstance(true);
		monsterGenerator.setMap(map);
		playlayer.add(monsterGenerator);
		
		endLayer = new DrawableLayer();
		scoreText = Text.createText("fonts/AAAA.TTF", 32);
		scoreText.x = 250;
		scoreText.y = 250;
		scoreText.text = "Game Over ! \nScore: " + playbar.getScore();
		endLayer.addChild(scoreText);
		var endButton = new EndButton(250, 360, 		
			GameController.assets.getBitmap("defaultEnd"), 
			GameController.assets.getBitmap("hoverEnd"), 
			GameController.assets.getBitmap("clickEnd"));
		endButton.setScreen(this);
		endLayer.add(endButton);
		
		this.add(playlayer);
	}
	
	public function onPlayerDeath() {
		scoreText.text = "Game Over ! \nScore: " + playbar.getScore();
		remove(playlayer);
		remove(playbar);
		this.add(endLayer);
	}
	
	public function goToMenu() {
		screenController.addScreen(new MenuScreen(screenController));
		screenController.addScreen(new PlayScreen(screenController));
		screenController.nextScreen();
	}
}