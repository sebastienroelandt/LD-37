package lib.sro.ui;

import lib.sro.engine.CollisionReader.CollisionType;
import lib.sro.ui.BasicUI;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import lib.sro.engine.*;

/**
 * ...
 * @author Sebastien roelandt
 */
class TiledMapUI extends BasicUI implements CollisionReader
{
	private var collisionGrid:CollisionGrid;	
	
	public function new(tileset:Array<BitmapData>,	values:Array<Array<Int>>, ?collisionId:Array<Int> = null) 
	{
		super();
		if (collisionId == null) {
			collisionId = new Array();
		}
		
		var tileHeigth:Float = tileset[0].height;
		var tileWidth:Float = tileset[0].width;
		var xmax = values[0].length;
		var ymax = values.length;
		
		this.collisionGrid = new CollisionGrid(tileset[0].height, tileset[0].width, xmax, ymax);
			
		
		for (j in 0...values.length) {
			var line = values[j];
			for (i in 0...line.length) {
				var tileBitmapData = tileset[line[i]];
				
				var child = new BasicUI();
				child.addChild(new Bitmap(tileBitmapData));
				child.x = i * tileWidth;
				child.y = j * tileHeigth;
				add(child);
				
				//Collision
				if (collisionId.indexOf(line[i]) != -1) {
					collisionGrid.setCollision(i, j);
				}
			}
		}
		
		add(collisionGrid);
	}
	
	public function pointHasCollision (x:Float, y:Float):Bool 
	{
		return collisionGrid.pointHasCollision(x, y);
	}
	
	public function boxHasCollision (box:CollisionBox, ?offsetX:Float = 0, ?offsetY:Float = 0):Bool
	{
		return collisionGrid.boxHasCollision(box, offsetX, offsetY);
	}
	
	public function getHeigth():Float {
		return collisionGrid.getHeigth();
	}
	
	public function getWidth():Float {
		return collisionGrid.getWidth();
	}
	
	public function getType():CollisionType {
		return collisionGrid.getType();
	}
}