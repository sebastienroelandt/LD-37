package lib.sro.layers;

import openfl.geom.Point;
import openfl.text.TextField;
import lib.sro.core.Text;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.input.Mouse;
import lib.sro.input.Keys;
import lib.sro.DefaultConstant;
import openfl.Lib;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import lib.sro.ui.AnimatedSprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class DebugLayer extends DrawableLayer
{
	var topLeftText1:TextField;
	var topLeftText2:TextField;
	var topLeftText3:TextField;
	var isDisplay:Bool;
	var lastTimer:Float;
	var animatedSprite:AnimatedSprite;
	
	public function new() 
	{
		super();
		
		topLeftText1 = Text.createText("fonts/AAAA.TTF");
		topLeftText1.width = 100;
		topLeftText1.text = "SIZE\nFPS\nVERSION\nMOUSE\nKEY";
		topLeftText2 = Text.createText("fonts/AAAA.TTF");
		topLeftText2.width = 10;
		topLeftText2.x = 100;
		topLeftText2.text = ":\n:\n:\n:\n:";
		topLeftText3 = Text.createText("fonts/AAAA.TTF");
		topLeftText3.width = 400;
		topLeftText3.height = 300;
		topLeftText3.x = 110;
		
		isDisplay = false;
		
		this.addChild(topLeftText1);
		this.addChild(topLeftText2);
		this.addChild(topLeftText3);
	}
	
	public override function update(delta:Float) {	
		if (Keys.isClick(Keyboard.F1)) {
			isDisplay = !isDisplay;
		}

		if (isDisplay) {
			var output:String = "";
			
			var currentStage = Lib.current.stage;
			output += currentStage.stageWidth + "x" + currentStage.stageHeight + "\n";
			
			var screenController = ScreenController.ME;
			var time = Lib.getTimer();
			var diff = currentStage.frameRate / (time - lastTimer) * 1000;
			output += Math.round(diff * 10 / 10) + " 	/ " + currentStage.frameRate + "\n";
			
			output += DefaultConstant.LIBVERSION + " || GAME - v" + DefaultConstant.GAMEVERSION + "\n";
			
			var point:Point = Mouse.getXY() ;
			output += "X-" + point.x + " || Y-" + point.y + " || " + Mouse.isBeginClick() + " || " + Mouse.isEndClick() + " || " + Mouse.isDown() + "\n";
			
			output += "DOWN - " + Keys.downCodes.toString() + "\n";
			output += "CLICK - " + Keys.click.toString();
			
			
			topLeftText3.text = output;
			topLeftText1.visible = topLeftText2.visible = topLeftText3.visible = true;
			lastTimer = time;
		} else {
			topLeftText1.visible = topLeftText2.visible = topLeftText3.visible = false;
		}
	}

}