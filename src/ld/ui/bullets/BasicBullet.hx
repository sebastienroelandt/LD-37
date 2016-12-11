package ld.ui.bullets;

import lib.sro.ui.AnimatedSprite;
import lib.sro.data.StatedAnimationData;
import ld.ui.ennemies.MonstersManager;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicBullet extends AnimatedSprite 
{
	private var lastPosition 	: Point;
	private var move 			: Point;
	private var isEnd 			: Bool;
	private var bulletPower		: Float;
	
	public function new(statedAnimationData:StatedAnimationData, x:Float, y:Float, move:Point) 
	{
		super(statedAnimationData);
		this.move = move;
		this.lastPosition = new Point(x, y);
		this.x = x;
		this.y = y;
		this.bulletPower = 100;
	}
	
	override public function update(delta:Float) {
		if (!isEnd) {
			
			if (isOutOfArena()) {
				end();
			} else {
				updatePosition();
				var monstersManager = MonstersManager.getInstance();
				var i:Int;
				for (i in 0...monstersManager.getNbMonsters()) {
					var monster = monstersManager.getMonster(i);
					if (monster != null && monster.isHurt(lastPosition, new Point(x,y),bulletPower)) {
						end();
					}
				}
			}
		}
		super.update(delta);
	}
	
	public function updatePosition() {
		this.lastPosition = new Point(x, y);
		
		this.x += this.move.x;
		this.y += this.move.y;
	}
	
	public function end() {
		isEnd = true;
		BulletsManager.getInstance().removeBullet(this);
	}
	
	public function isOutOfArena():Bool {
		return x < 1*16 || x > (50 - 3) * 16 || y < 3*16 || y > (38 - 3) * 16;
	}
}