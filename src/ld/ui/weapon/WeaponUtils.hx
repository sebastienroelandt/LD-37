package ld.ui.weapon;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class WeaponUtils
{
	public static function getMouvement(stenght:Float, Px:Float, Py:Float, Mx:Float, My:Float):Point {
			
		var X = Mx - Px;
		var Y = My - Py;
		var M = Math.sqrt(X * X + Y * Y);		
		var x = stenght * X / M;
		var y = stenght * Y / M;
		return new Point(x, y);
	}
	
}