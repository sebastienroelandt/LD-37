package lib.sro.engine;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import lib.sro.ui.BasicUI;
import lib.sro.engine.CollisionReader;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionBox extends BasicUI implements CollisionReader
{
	public static var debugMode:Bool = false;

	public var box:Rectangle;
	
	public function new(x1:Float, y1:Float, x2:Float, y2:Float)	
	{
		super();
		box = new Rectangle(x1, y1, x2 - x1, y2 - y1);
		this.graphics.beginFill(0xFF0000, 0.5);
		this.graphics.drawRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		this.graphics.endFill();
	}
	
	override public function update(delta:Float) {
		this.visible = debugMode;
	}
	
	public function moveTo(xy:Point) {
		this.x = xy.x;
		this.y = xy.y;
	}
	
	public function getHeigth():Float {
		return box.height;
	}
	
	public function getWidth():Float {
		return box.width;
	}
		
	public function pointHasCollision (x:Float, y:Float):Bool {
		return x > box.x && y > box.y && x <= box.x + box.width && y <= box.y + box.height;
	}
	
	public function boxHasCollision (box:CollisionBox, ?offsetX:Float = 0, ?offsetY:Float = 0):Bool {
		if(pointHasCollision(box.x + offsetX, box.y + offsetY)
			|| pointHasCollision(box.x + box.width + offsetX, box.y + offsetY)
			|| pointHasCollision(box.x + offsetX, box.y + box.height + offsetY)
			|| pointHasCollision(box.x + box.width + offsetX, box.y + box.height + offsetY)
			|| inversePointHasCollision(this.box.x - offsetX, this.box.y - offsetY, box)
			|| inversePointHasCollision(this.box.x + this.box.width - offsetX, this.box.y - offsetY, box)
			|| inversePointHasCollision(this.box.x - offsetX, this.box.y + this.box.height - offsetY, box)
			|| inversePointHasCollision(this.box.x + this.box.width - offsetX, this.box.y + this.box.height - offsetY, box)) {
				return true;
			}
		return false;			
	}
	
	private function inversePointHasCollision (x:Float, y:Float, box:CollisionBox) {
		return x > box.x && y > box.y && x <= box.x + box.width && y <= box.y + box.height;
	}
	
	public function getType():CollisionType {
		return CollisionType.Box;
	}
}