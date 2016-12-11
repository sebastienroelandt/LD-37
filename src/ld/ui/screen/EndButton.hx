package ld.ui.screen;

import lib.sro.ui.ButtonUI;
import openfl.display.Bitmap;
import lib.sro.screen.Screen;
import lib.sro.sound.SoundManager;
import lib.sro.core.GameController;

/**
 * ...
 * @author Sebastien roelandt
 */
class EndButton extends ButtonUI
{
	private var parentScreen: PlayScreen;
	
	public function new(x:Float, y:Float, defaultBitmap:Bitmap, ?hoverBitmap:Bitmap, ?pressBitmap:Bitmap) 
	{
		super(x, y, defaultBitmap, hoverBitmap, pressBitmap);
	}
	
	override public function onClick() {
		parentScreen.goToMenu();
	}
	
	public function setScreen(screen:PlayScreen) {
		this.parentScreen = screen;
	}
	
	override public function onNewState() {
		if (currentState == ButtonState.Hover) {
			SoundManager.getInstance().play(GameController.assets.getSound("level_up"));
		}
	}
	
}