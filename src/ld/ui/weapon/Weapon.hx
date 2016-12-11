package ld.ui.weapon;

import ld.ui.bullets.BasicBullet;
import ld.ui.bullets.BulletsManager;
import lib.sro.core.GameController;
/**
 * ...
 * @author Sebastien roelandt
 */
class Weapon implements IWeapon
{
	var strenght : Float;
	
	public function new() 
	{
		strenght = 10;
	}
	
	public function shoot(Px:Float, Py:Float, Mx:Float, My:Float) {
		
		var newBullet = getNewBullet(Px, Py, Mx, My);
		BulletsManager.getInstance().addBullet(newBullet);
		newBullet.x = Px;
		newBullet.y = Py;
	}
	
	public function getNewBullet(Px:Float, Py:Float, Mx:Float, My:Float):BasicBullet {
		return new BasicBullet(
			GameController.assets.getStatedAnimationData("bullet"),
			Px, 
			Py,
			WeaponUtils.getMouvement(strenght, Px, Py, Mx, My));
	}
	
}