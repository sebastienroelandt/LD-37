package ld.ui.player;

import ld.effect.FollowMouseEffect;
import ld.ui.screen.PlayScreen;
import ld.ui.weapon.IWeapon;
import ld.ui.weapon.Weapon;
import lib.sro.entity.Entity;
import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import openfl.filters.GlowFilter;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import lib.sro.input.Keys;
import lib.sro.input.Mouse;
import lib.sro.core.Transformation;
import lib.sro.core.Bresenham;
import ld.ui.ennemies.Monster;
import lib.sro.sound.SoundManager;
import lib.sro.core.GameController;

/**
 * ...
 * @author Sebastien roelandt
 */
class Player extends Entity
{
	public var playerRotation	: Float;
	public var weapon			: IWeapon;
	public var isIdle			: Bool;
	public var life 			: Float;
	public var maxLife 			: Float;
	private var currentHurt		: Bool;
	private var timeHurt 		: Float;
	private var isAlive			: Bool;
	private var playscreen		: PlayScreen;

	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI=null) 
	{
		deltaUp = 5;
		deltaDown = 5;
		deltaLeft = 5;
		deltaRight = 5;
		playerRotation = 0;
		isIdle = true;
		isAlive = true;
		
		life = 1500;
		maxLife = 1500;
		
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
		this.change("idle");
		speed = 0.02;
		centerx = 16;
		centery = 16;
		type = "player";
		
		weapon = new Weapon();
		
		new FollowMouseEffect(this, 10000);
	}
	
	public override function update(delta:Float) {
		super.update(delta);
		
		updateDirection();
		
		if (Keys.isDown(Keyboard.UP) || Keys.isDown(Keyboard.W) || Keys.isDown(Keyboard.Z)) {
			dy -= speed;
			direction = EntityDirection.Up;
		} 
		if (Keys.isDown(Keyboard.DOWN) || Keys.isDown(Keyboard.S)) {
			dy += speed;
			direction = EntityDirection.Down;
		} 
		if (Keys.isDown(Keyboard.LEFT) || Keys.isDown(Keyboard.A) || Keys.isDown(Keyboard.Q)) {
			dx -= speed;
			direction = EntityDirection.Left;
		}
		if (Keys.isDown(Keyboard.RIGHT) || Keys.isDown(Keyboard.D)) {
			dx += speed;
			direction = EntityDirection.Right;
		}
		
		xr+=dx;
		dx *= frictX;
		
		yr+=dy;
		dy *= frictY;
		
		if (dy < 0.001 && dx < 0.001 && dy > -0.001 && dx > -0.001) {
			if (!isIdle) {
				//On passe de mouvement à stop
				this.change("idle");
				isIdle = true;
			}
		} else {
			if (isIdle) {
				//On passe de stop a mouvement
				this.change("move");
				isIdle = false;
			}
		}
		
		if (autoCollisionCheck) {
			checkBoxCollision();
			checkGridCollision();
		}
		
		updateEntityPosition();
		
		updateWeapon();
		
		updateHurt(delta);
	}
	
	public function updateDirection() {
		playerRotation = Bresenham.getAngle(Std.int(this.x + 16), 
			Std.int(this.y + 16), 
			Std.int(this.x + 16), 
			Std.int(this.y), 
			Std.int(Mouse.getXYwithDelta().x), 
			Std.int(Mouse.getXYwithDelta().y));
	}
	
	public function updateWeapon() {
		if (Mouse.isBeginClick() && weapon != null && Mouse.getXYwithDelta().y > 0) {
			weapon.shoot(this.x + 16 - 2, this.y + 16 - 2, Mouse.getXYwithDelta().x, Mouse.getXYwithDelta().y);
		}
	}
	
	override public function onInteraction(with :Entity) {
		var monster = cast(with, Monster);
		life -= monster.attackPower;
		if (!currentHurt) {
			SoundManager.getInstance().play(GameController.assets.getSound("hero_hurt"));
			if (life <= 0) {
				this.visible = false;
				isAlive = false;
				if (playscreen != null) {
					playscreen.onPlayerDeath();
				}
			} else {
				currentHurt = true;
				timeHurt = 150;
				this.filters = [new GlowFilter(0xFFFFFF, 1, 64, 64, 2, 1, true)];
				var mouvement = monster.getMouvement(0.15);
				this.dx -= mouvement.x;
				this.dy -= mouvement.y;
			}
		}
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
	
	public function setScreen(playscreen:PlayScreen) {
		this.playscreen = playscreen;
	}
	
}