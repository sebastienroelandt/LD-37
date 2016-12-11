package ld.ui.screen;

import lib.sro.ui.ToggleButtonUI;
import lib.sro.core.GameController;
import lib.sro.sound.MusicManager;
import lib.sro.sound.SoundManager;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class SoundToggleButtonUI extends ToggleButtonUI
{
	private var isActive : Bool;
	
	public function new(x:Float, y:Float, leftBitmap:Bitmap, rightBitmap:Bitmap, 
		?leftActiveBitmap:Bitmap = null, ?rightActiveBitmap:Bitmap = null, ?delta:Float = 0) 
	{
		isActive = SoundManager.getInstance().isActive;
		super(x, y, leftBitmap, rightBitmap, leftActiveBitmap, rightActiveBitmap, delta);
		if (!isActive) {
			inverseStates();
			MusicManager.getInstance().stop();
		}
	}
	
	override public function onClick() {
		if (isActive) {
			MusicManager.getInstance().stop();
			SoundManager.getInstance().stop();
			isActive = false;
		} else {
			MusicManager.getInstance().start(GameController.assets.getSound("music"));
			SoundManager.getInstance().start();
			isActive = true;
		}
	}
	
}