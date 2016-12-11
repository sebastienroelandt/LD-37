package lib.sro.engine;

import lib.sro.ui.BasicUI;
import lime.math.Rectangle;
import lib.sro.engine.CollisionReader;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionGrid extends BasicUI implements CollisionReader
{
	public static var debugMode:Bool = false;
	
	private var tileHeigth:Float;
	private var tileWidth:Float;
	
	private var xTiles:Int;
	private var yTiles:Int;
	
	private var grid:Array<Array<Bool>>;
	
	public function new (tileHeigth:Float, tileWidth:Float, xTiles:Int, yTiles:Int, ?grid:Array<Array<Bool>>) 
	{
		super();
		
		this.tileHeigth = tileHeigth;
		this.tileWidth = tileWidth;
		this.xTiles = xTiles;
		this.yTiles = yTiles;
		
		if (grid != null) {
			this.grid = grid;
		} else {
			this.grid = new Array();
			for (y in 0...xTiles) {
				var line = new Array();
				for (x in 0...yTiles) {
					line[x] = false;
				}
				this.grid[y] = line;
			}
		}
	}
	
	override public function update(delta:Float)
	{
		this.visible = debugMode;
	}
	
	public function setCollision (x:Int, y:Int, ?value:Bool = true) 
	{
		if (xTiles > x && yTiles > y) {
			this.grid[y][x] = value;
			
			this.graphics.beginFill(0xe08f16, 0.5);
			this.graphics.drawRect(x * tileWidth, y * tileHeigth, tileWidth, tileHeigth);
			this.graphics.endFill();
		}
	}
	
	public function pointHasCollision (x:Float, y:Float):Bool {
		var toReturn:Bool = false;
		if (xTiles > x && yTiles > y && y >= 0 && x >= 0) {
			toReturn = grid[Std.int(y)][Std.int(x)];
		}
		return toReturn;
	}
	
	public function boxHasCollision (box:CollisionBox, ?offsetX:Float = 0, ?offsetY:Float = 0):Bool {
		//TODO
		return false;
	}
	
	public function getHeigth():Float {
		return tileHeigth;
	}
	
	public function getWidth():Float {
		return tileWidth;
	}
	
	public function getType():CollisionType {
		return CollisionType.Grid;
	}
}