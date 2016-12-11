package ld.ui.ennemies;

import ld.ui.player.Player;
import lib.sro.ui.BasicUI;
import lib.sro.input.Keys;
import lib.sro.entity.Entity;
import openfl.ui.Keyboard;
import ld.ui.ennemies.Monster;

/**
 * ...
 * @author Sebastien roelandt
 */
class MonstersManager extends BasicUI
{
	private var monsters			: Array<Monster>;
	private static var ME 			: MonstersManager;
	public var target 				: Player;
	public var fastMonsterKill		: Float;
	public var normalMonsterKill	: Float;
	public var tankMonsterKill		: Float;


	private function new() {
		monsters = new Array();
		fastMonsterKill = 0;
		normalMonsterKill = 0;
		tankMonsterKill = 0;
		super();
	}
	
	public static function getInstance(?isNew:Bool = false):MonstersManager {
		if (ME == null || isNew) {
			ME = new MonstersManager();
		}
		return ME;
	}
	
	public function getNbMonsters():Int {
		return monsters.length;
	}
	
	public function getMonster(i:Int):Monster {
		if (monsters.length > i) {
			return monsters[i];
		}
		return null;
	}
	
	public function addMonster(monster:Monster) {
		monsters.push(monster);
		this.add(monster);
	}
	
	public function removeMonster(monster:Monster) {
		this.remove(monster);
	}
	
	override public function update(delta:Float) {/*
		if (Keys.isClick(Keyboard.A)) {
			addMonster(new Monster(300, 300, MonsterType.Fast));
		}
		if (Keys.isClick(Keyboard.Z)) {
			addMonster(new Monster(300, 300, MonsterType.Normal));
		}
		if (Keys.isClick(Keyboard.E)) {
			addMonster(new Monster(300, 300, MonsterType.Tank));
		}*/
	}
	
	public function getAllAliveEntity():Array<Entity> {
		var allEntity :Array<Entity> = new Array();
		var i:Int;
		for (i in 0...monsters.length) {
			var monster = getMonster(i);
			if (monster.isAlive) {
				allEntity.push(monster);
			}
		}
		if (allEntity.length == 0) {
			return allEntity;
		}
		allEntity.push(target);
		return allEntity;
	}
	
	public function onMonsterDeath(monster:Monster) {
		switch (monster.monsterType) {
			case Fast :
				fastMonsterKill ++;
			case Normal :
				normalMonsterKill ++;
			case Tank :
				tankMonsterKill ++;
			default :
				
		}
	}
}