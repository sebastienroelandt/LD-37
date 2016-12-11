package ld.ui.screen;

import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class MenuScreen extends Screen
{
	private var screenController : ScreenController;
	
	public function new(screenController:ScreenController) {
		super();
		this.screenController = screenController;
		
		var layer = new DrawableLayer();
		
		var monster = GameController.assets.getBitmap("monster_menu");
		monster.x = 0;
		monster.y = 0;
		layer.addChild(monster);
		
		var mouse = GameController.assets.getBitmap("mouse");
		mouse.x = 525;
		mouse.y = 300;
		layer.addChild(mouse);
		
		var mouseText = Text.createText("fonts/AAAA.TTF", 16, 0xC8B782);
		mouseText.x = 700;
		mouseText.y = 420;
		mouseText.text = "Target";
		layer.addChild(mouseText);
		
		var mouseText2 = Text.createText("fonts/AAAA.TTF", 16, 0xC8B782);
		mouseText2.x = 520;
		mouseText2.y = 350;
		mouseText2.text = "Shoot";
		layer.addChild(mouseText2);
			
		var fleche = GameController.assets.getBitmap("fleche");
		fleche.x = 525;
		fleche.y = 495;
		layer.addChild(fleche);
		
		var flecheText = Text.createText("fonts/AAAA.TTF", 16, 0xC8B782);
		flecheText.x = 640;
		flecheText.y = 515;
		flecheText.text = "Move";
		layer.addChild(flecheText);
		
		var title = Text.createText("fonts/AAAA.TTF", 32);
		title.x = 200;
		title.y = 120;
		title.text = "Extreme Bug Fixer";
		layer.addChild(title);
		
		var button = new MenuButton(325, 420, GameController.assets.getBitmap("defaultButton"), 
		GameController.assets.getBitmap("hoverButton"), 
		GameController.assets.getBitmap("clickButton")); 
		button.setScreen(this);
		layer.add(button); 
		
		this.add(layer);
	}
	
	public function start() {
		screenController.nextScreen();
	}
}