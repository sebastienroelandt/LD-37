package lib.sro.core;

import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Transformation
{

	public static function rotateRad(target:Sprite, pivot:Point, angle:Float, ?initialCoord:Point = null) 
	{
		//Move to translation point
		var matrix:Matrix = new Matrix();
		if (initialCoord == null) {
			initialCoord = new Point(200, 200);
		}
		
		
		matrix.tx -= pivot.x;
		matrix.ty -= pivot.y;

		//Calculate 
		var sin = Math.sin(angle);
		var cos = Math.cos(angle);
		var a = matrix.a;
		var b = matrix.b;
		var c = matrix.c;
		var d = matrix.d;
		var tx = matrix.tx;
		var ty = matrix.ty;
		matrix.a = a*cos - b*sin;
		matrix.b = a*sin + b*cos;
		matrix.c = c*cos - d*sin;
		matrix.d = c*sin + d*cos;
		matrix.tx = tx*cos - ty*sin;
		matrix.ty = tx*sin + ty*cos;

		//Restore the translation
		matrix.tx += pivot.x + initialCoord.x;
		matrix.ty += pivot.y + initialCoord.y;

		target.transform.matrix = matrix;	

	}
	
	public static function rotateDegree(target:Sprite, pivot:Point, angle:Float, ?initialCoord:Point = null) 
	{
		rotateRad(target, pivot, angle * Math.PI / 180, initialCoord);
	}
	
}