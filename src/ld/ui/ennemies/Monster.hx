package ld.ui.ennemies;

import openfl.filters.GlowFilter;
import openfl.geom.Point;
import lib.sro.entity.Entity;
import lib.sro.core.GameController;
import lib.sro.data.StatedAnimationData;
import ld.effect.FollowTargetEffect;
import lib.sro.input.Mouse;
import lib.sro.core.Transformation;
import lib.sro.core.Bresenham;
import lib.sro.engine.CollisionBox;
import lib.sro.core.Bresenham;
import openfl.geom.Point;
import ld.ui.ennemies.MonstersManager;
import ld.ui.weapon.WeaponUtils;
import lib.sro.sound.SoundManager;

/**
 * @author Sebastien roelandt
 */
enum MonsterType {
	Fast;
	Tank;
	Normal;
}
 
class Monster extends Entity
{
	public var monsterType 	: MonsterType;
	private var maxLife 		: Float;
	private var life 			: Float;
	//private var speed			: Float;
	public var isAlive 			: Bool;
	
	public var monsterRotation 	: Float; 
	
	public var absoluteX		: Float;
	public var absoluteY		: Float;
	
	private var currentHurt		: Bool;
	private var timeHurt 		: Float;
	public var attackPower		: Float;
	private var timeForBaby 	: Float;
	
	//public var collisionBox 	: CollisionBox;
		
	public function new(x:Float, y:Float, monsterType:MonsterType) {
		var statedAnimationData : StatedAnimationData;
		statedAnimationData = null;
		
		attackPower = 0;
		monsterRotation = 0;
		isAlive = true;
		this.monsterType = monsterType;
		
		switch(monsterType) {
			case Fast		: 
				maxLife = 200;
				life = 200;
				attackPower = 50;
				statedAnimationData = GameController.assets.getStatedAnimationData("fast_monster");
				timeForBaby = -1;
			case Tank 		:
				maxLife = 1600;
				life = 1600;
				attackPower = 500;
				statedAnimationData = GameController.assets.getStatedAnimationData("tank_monster");
				timeForBaby = getNewTimeForBaby();
			case Normal		: 
				maxLife = 400;
				life = 400;
				attackPower = 150;
				statedAnimationData = GameController.assets.getStatedAnimationData("normal_monster");
				timeForBaby = -1;
			default			: 
		}
		
		super(statedAnimationData);
		
		switch(monsterType) {
			case Fast		: 
				speed = 0.015;
				centerx = 12;
				centery = 12;
				force = 1;
				type = "fast_monster";
			case Tank 		:
				speed = 0.0015;
				centerx = 48;
				centery = 48;
				radius -= 2;
				force = 0.1;
				type = "tank_monster";
			case Normal		: 
				speed = 0.008;
				centerx = 24;
				centery = 24;
				force = 0.7;
				type = "normal_monster";
			default			: 
				maxLife = 200;
		}

		absoluteX = x;
		absoluteY = y;
		setPosition(x, y);
		dx = dy = 0;
		
		new FollowTargetEffect(this, 10000);
	}
	
	override public function update(delta:Float) {
		super.update(delta);
		
		if(isAlive) {
			updateDirection();
			
			updatePosition();
			
			xr+=dx;
			dx *= frictX;
			
			yr+=dy;
			dy *= frictY;
			
			updateMyPositionDueToInteraction();
			
			checkGridCollision();
			
			updateEntityPosition();
			
			updateHurt(delta);
			
			if (type == "tank_monster") {
				generateBaby(delta);
			}
		}
	}
	
	public function updateDirection() {
		monsterRotation = Bresenham.getAngle(
			Std.int(this.absoluteX + centerx), 
			Std.int(this.absoluteY + centery), 
			Std.int(this.absoluteX + centerx), 
			Std.int(this.absoluteY), 
			Std.int(MonstersManager.getInstance().target.x - 8), 
			Std.int(MonstersManager.getInstance().target.y - 8));
	}
	
	public function updatePosition() {
		var mouvement = getMouvement(speed);
		dx += mouvement.x;
		dy += mouvement.y;
		this.absoluteX = xx;
		this.absoluteY = yy;
	}
	
	public function getMouvement(speed:Float):Point {
		return WeaponUtils.getMouvement(
			speed, 
			this.x + centerx*2,
			this.y + centery*2,
			MonstersManager.getInstance().target.x + 8,
			MonstersManager.getInstance().target.y + 8);
	}
	
	public function isHurt(bulletBegin:Point, bulletEnd:Point, bulletPower:Float):Bool {
		var isHurt = false;
		var pts = Bresenham.getLine(Std.int(bulletBegin.x), Std.int(bulletBegin.y), Std.int(bulletEnd.x), Std.int(bulletEnd.y));
		var i : Int;
		for (i in 0...pts.length) {
			var pt = pts[i];
			if (isAlive && getCollisionBox().pointHasCollision(pt.x, pt.y)) {
				setBulletTouch(bulletPower);
				isHurt = true;
				break;
			}
		}

		return isHurt;
	}
	
	public function getCollisionBox():CollisionBox {
		return new CollisionBox(
			this.absoluteX + collisionBox.x + centerx,
			this.absoluteY + collisionBox.y + centery,
			this.absoluteX + collisionBox.x + collisionBox.width + centerx,
			this.absoluteY + collisionBox.y + collisionBox.width + centery);
	}
	
	public function updateMyPositionDueToInteraction() {
		var allEntity = MonstersManager.getInstance().getAllAliveEntity();
		super.updatePositionDueToInteraction(allEntity);
	}
	
	override public function getCenterPoint():Point {
		return new Point(this.absoluteX + centerx*2, this.absoluteY + centery*2);
	}
	
	public function updateHurt(delta:Float) {
		if (currentHurt) {
			timeHurt -= delta;
			if (timeHurt < 0) {
				this.filters = [];
				currentHurt = false;
			}
		}
	}
	
	public function setBulletTouch(bulletPower:Float) {
		life -= bulletPower;
		SoundManager.getInstance().play(GameController.assets.getSound("monster_hurt"));
		if (life < 0) {
			this.visible = false;
			isAlive = false;
			MonstersManager.getInstance().onMonsterDeath(this);
		} else {
			currentHurt = true;
			timeHurt = 150;
			this.filters = [new GlowFilter(0xFFFFFF, 1, 64, 64, 2, 1, true)];
		}
	}
	
	private function generateBaby(delta:Float) {
		timeForBaby -= delta;
		if (timeForBaby < 0) {
			timeForBaby = getNewTimeForBaby();
			var monster = new Monster(x - 30, y -30, MonsterType.Fast);
			MonstersGenerator.getInstance().addMonster(monster);
		}
	}
	
	private function getNewTimeForBaby() :Float {
		return Std.random (6000) + 2000;
	}
}