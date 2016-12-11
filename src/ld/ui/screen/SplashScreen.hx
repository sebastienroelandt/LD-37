package ld.ui.screen;

import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.layers.DrawableLayer;
import lib.sro.core.GameController;
import lib.sro.core.Text;
import lib.sro.ui.TextAnimation;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Sebastien roelandt
 */
class SplashScreen extends Screen
{
	private var time 				: Float;
	private var screenController 	: ScreenController;
	private var isStarted 			: Bool;
	private var animatedText 		: TextAnimation;

	public function new(screenController:ScreenController) {
		super();
		time = 7000;
		this.screenController = screenController;
		isStarted = false;
		
		var layer = new DrawableLayer();
		
		var text1 = Text.createText("fonts/AAAA.TTF", 32);
		text1.x = 260;
		text1.y = 100;
		text1.text = "Created by:";
		layer.addChild(text1);
		
		var text2 = Text.createText("fonts/AAAA.TTF", 32);
		text2.x = 200;
		text2.y = 150;
		text2.text = "Sebastien Roelandt";
		layer.addChild(text2);
		
		var text3 = Text.createText("fonts/AAAA.TTF", 32);
		text3.x = 300;
		text3.y = 230;
		text3.text = "During:";
		layer.addChild(text3);
		
		var text4 = Text.createText("fonts/AAAA.TTF", 32);
		text4.x = 230;
		text4.y = 280;
		text4.text = "Ludum Dare 37";
		layer.addChild(text4);
				
		//animatedText = new TextAnimation("Only two days...", Text.createText("fonts/AAAA.TTF"));
		animatedText = new TextAnimation("A video game development challenge \nDuring two days...", Text.createText("fonts/AAAA.TTF"));
		animatedText.x = 50;
		animatedText.y = 350;
		animatedText.width = 1000;
		animatedText.height = 200;
		animatedText.start();
		layer.add(animatedText);
		
		this.add(layer);
	}
	
	override public function update(delta:Float) {
		super.update(delta);
		time -= delta;
		if (time < 400 && !isStarted) { // 
			animatedText.start();
		}
		if (time <= 0) {
			screenController.nextScreen();
		}
	}
}