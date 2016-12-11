package lib.sro.engine;

import lib.sro.engine.CollisionBox;

/**
 * @author Sebastien roelandt
 */
enum CollisionType {
	Box;
	Grid;
}
 
interface CollisionReader 
{
	public function pointHasCollision (x:Float, y:Float):Bool;
	public function boxHasCollision (box:CollisionBox, ?offsetX:Float = 0, ?offsetY:Float = 0):Bool;
	public function getHeigth():Float;
	public function getWidth():Float;
	public function getType():CollisionType;
}