package ld.ui.ennemies;

import ld.ui.ennemies.MonstersGenerator.Level;
import lib.sro.ui.BasicUI;
import lib.sro.ui.AnimatedSprite;
import lib.sro.ui.TiledMapUI;
import ld.ui.ennemies.Monster;
import lib.sro.core.GameController;
import openfl.geom.Point;
import lib.sro.sound.SoundManager;

/**
 * ...
 * @author Sebastien roelandt
 */
enum Level {
	Easy;
	Medium;
	Hard;
	Insane;
}
 
class MonstersGenerator extends BasicUI
{
	private static var ME 			: MonstersGenerator;
	private var timeNextWave		: Float;
	private var apparitionElement 	: Array <{typeMonster:MonsterType, apparitionAnimation:AnimatedSprite}>;
	private var map					: TiledMapUI;
	public var currentLevel			: Level;
	public var waveCount			: Int;
	
	private function new() 
	{
		super();
		
		this.currentLevel = Level.Easy;
		this.map = null;
		timeNextWave = 5000;
		waveCount = 0;
		
		apparitionElement = new Array();
	}	
	
	public function setMap(map:TiledMapUI) {
		this.map = map;
	}
	
	public static function getInstance(?isNew:Bool = false):MonstersGenerator {
		if (ME == null || isNew) {
			ME = new MonstersGenerator();
		}
		return ME;
	}
	
	private function getNewAnimation(x:Float, y:Float, type:String):AnimatedSprite {
		var newAnimation = new AnimatedSprite(GameController.assets.getStatedAnimationData(type));
		newAnimation.x = x;
		newAnimation.y = y;
		this.add(newAnimation);
		return newAnimation;
	}
	
	override public function update(delta:Float) {
		super.update(delta);
		timeNextWave -= delta;
		if (timeNextWave < 0) {
			var i:Int;
			for (i in 0...apparitionElement.length) {
				var element = apparitionElement[i];
				var newMonster = new Monster(element.apparitionAnimation.x, element.apparitionAnimation.y, element.typeMonster);
				if (map != null) {
					newMonster.addCollideTo(map);
				}
				MonstersManager.getInstance().addMonster(newMonster);
			}
			clearApparitionArray();
			updateDifficulty();
			prepareNewWave();
		}
	}
	
	private function updateDifficulty() {
		waveCount ++;
		if (waveCount == 20) {
			currentLevel = Insane;
			SoundManager.getInstance().play(GameController.assets.getSound("level_up"));
		} else if (waveCount == 12) {
			currentLevel = Hard;
			SoundManager.getInstance().play(GameController.assets.getSound("level_up"));
		} else if (waveCount == 6) {
			currentLevel = Medium;
			SoundManager.getInstance().play(GameController.assets.getSound("level_up"));
		} 
	}
	
	private function clearApparitionArray() {
		var i:Int; 
		for (i in 0...apparitionElement.length) {
			var element = apparitionElement[i];
			element.apparitionAnimation.visible = false;
			this.remove(element.apparitionAnimation);
		}
		apparitionElement = new Array();
	}
	
	private function prepareNewWave() {
		var point = new Point(0, 0);
		switch (currentLevel) {
			case Easy:
				switch (Std.random(2)) {
					case 0:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 4000;
					case 1:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						timeNextWave = 4000;
					default :
				}
			case Medium:
				switch (Std.random(4)) {
					case 0:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 4000;
					case 1:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						timeNextWave = 4000;
					case 2:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						timeNextWave = 4000;
					case 3:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						timeNextWave = 4000;
					default :
				}
			case Hard:
				switch (Std.random(4)) {
					case 0:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 4000;
					case 1:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 8000;
					case 2:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						timeNextWave = 6000;
					case 3:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 6000;
					default :
				}
			case Insane:
				switch (Std.random(4)) {
					case 0:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 3500;
					case 1:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						timeNextWave = 5000;
					case 2:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 5000;
					case 3:
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Normal, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_normal_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Tank, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_tank_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						point = getRandomCoord();
						apparitionElement.push( { typeMonster:MonsterType.Fast, apparitionAnimation:getNewAnimation(point.x, point.y, "apparition_fast_monster") });
						timeNextWave = 5500;
					default :
				}
			default:
		}
	}
	
	private function getRandomCoord():Point {
		return new Point(Std.random(620) + 70, Std.random(380) + 85);
	}
	
	public function addMonster(monster:Monster) {
		monster.addCollideTo(map);
		MonstersManager.getInstance().addMonster(monster);
	}
}