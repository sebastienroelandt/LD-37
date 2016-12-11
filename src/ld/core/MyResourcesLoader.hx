package ld.core;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import lib.sro.data.StatedAnimationData;
import lib.sro.core.ResourcesLoader;
import lib.sro.core.ResourcesStorage;


/**
 * ...
 * @author Sebastien roelandt
 */
class MyResourcesLoader
{
	public static function load(rs:ResourcesStorage) {
		
		var arenaImage = Assets.getBitmapData("img/arena_ld37_3.png");
		var arenaImageSplited = ResourcesLoader.splitToBitmapData(arenaImage, 0, 0, 16, 16, 8, 6);
		rs.addTileset("arena_tileset", arenaImageSplited);
		
		var player = new StatedAnimationData("player"); 
		var playerTileset = Assets.getBitmapData("img/player.png"); 
		player.addLinearFrames("move", ResourcesLoader.splitToBitmap(playerTileset, 0, 0, 32, 32, 4, 2),100); 
		player.setLoop("move", true); 
		player.addLinearFrames("idle", ResourcesLoader.splitToBitmap(playerTileset, 64, 0, 32, 32, 1, 1),100); 
		player.setLoop("idle", true); 
		rs.addStatedAnimationData("player", player); 
		
		var fastMonster = new StatedAnimationData("fast_monster"); 
		var fastMonsterTileset = Assets.getBitmapData("img/fast_monster.png"); 
		fastMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(fastMonsterTileset, 0, 0, 24, 24, 4, 1),100);
		fastMonster.setLoop("move", true); 
		rs.addStatedAnimationData("fast_monster", fastMonster); 		
		
		var normalMonster = new StatedAnimationData("normal_monster"); 
		var normalMonsterTileset = Assets.getBitmapData("img/normal_monster.png"); 
		normalMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(normalMonsterTileset, 0, 0, 48, 48, 4, 1),100);
		normalMonster.setLoop("move", true); 
		rs.addStatedAnimationData("normal_monster", normalMonster); 
		
		var tankMonster = new StatedAnimationData("tank_monster"); 
		var tankMonsterTileset = Assets.getBitmapData("img/tank_monster.png"); 
		tankMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(tankMonsterTileset, 0, 0, 96, 96, 4, 1),100);
		tankMonster.setLoop("move", true); 
		rs.addStatedAnimationData("tank_monster", tankMonster); 
		
		
		var apparitionFastMonster = new StatedAnimationData("apparition_fast_monster"); 
		var apparitionFastMonsterTileset = Assets.getBitmapData("img/apparition_fast_monster.png"); 
		apparitionFastMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(apparitionFastMonsterTileset, 0, 0, 24, 24, 4, 2),100);
		apparitionFastMonster.setLoop("move", true); 
		rs.addStatedAnimationData("apparition_fast_monster", apparitionFastMonster); 
		
		var apparitionNormalMonster = new StatedAnimationData("apparition_normal_monster"); 
		var apparitionNormalMonsterTileset = Assets.getBitmapData("img/apparition_normal_monster.png"); 
		apparitionNormalMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(apparitionNormalMonsterTileset, 0, 0, 48, 48, 4, 2),100);
		apparitionNormalMonster.setLoop("move", true); 
		rs.addStatedAnimationData("apparition_normal_monster", apparitionNormalMonster); 
		
		var apparitionTankMonster = new StatedAnimationData("apparition_tank_monster"); 
		var apparitionTankMonsterTileset = Assets.getBitmapData("img/apparition_tank_monster.png"); 
		apparitionTankMonster.addLinearFrames("move", ResourcesLoader.splitToBitmap(apparitionTankMonsterTileset, 0, 0, 96, 96, 4, 2),100);
		apparitionTankMonster.setLoop("move", true); 
		rs.addStatedAnimationData("apparition_tank_monster", apparitionTankMonster); 
		
		var bullet = new StatedAnimationData("bullet"); 
		var bulletTileset = Assets.getBitmapData("img/bullet.png"); 
		bullet.addLinearFrames("move", ResourcesLoader.splitToBitmap(bulletTileset, 0, 0, 8, 8, 4, 1),100); 
		bullet.setLoop("move", true); 
		rs.addStatedAnimationData("bullet", bullet); 
		
		var buttonBitmapData:BitmapData = Assets.getBitmapData("img/button.png"); 
		var buttons = ResourcesLoader.splitToBitmap(buttonBitmapData, 0, 0, 64, 50, 1, 3); 
		rs.addBitmap("defaultButton", buttons[0]); 
		rs.addBitmap("hoverButton", buttons[1]); 
		rs.addBitmap("clickButton", buttons[2]); 
		
		var toggleButtonBitmapData:BitmapData = Assets.getBitmapData("img/sound.png"); 
		var toggleButtons = ResourcesLoader.splitToBitmap(toggleButtonBitmapData, 0, 0, 32, 32, 2, 1); 
		rs.addBitmap("soundActive", toggleButtons[0]); 
		rs.addBitmap("soundMute", toggleButtons[1]); 
		
		var HImageBitmapData:BitmapData = Assets.getBitmapData("img/H_image.png"); 
		var HImage = ResourcesLoader.splitToBitmap(HImageBitmapData, 0, 0, 113, 109, 1, 1); 
		rs.addBitmap("HImage", HImage[0]); 
		
		var flecheBitmapData:BitmapData = Assets.getBitmapData("img/fleche.png"); 
		var fleche = ResourcesLoader.splitToBitmap(flecheBitmapData, 0, 0, 200, 200, 1, 1); 
		rs.addBitmap("fleche", fleche[0]);  
		
		var sourisBitmapData:BitmapData = Assets.getBitmapData("img/Mouse.png"); 
		var souris = ResourcesLoader.splitToBitmap(sourisBitmapData, 0, 0, 200, 200, 1, 1); 
		rs.addBitmap("mouse", souris[0]);  
		
		var monsterMenuBitmapData:BitmapData = Assets.getBitmapData("img/monster_menu.png"); 
		var monsterMenu = ResourcesLoader.splitToBitmap(monsterMenuBitmapData, 0, 0, 600, 600, 1, 1); 
		rs.addBitmap("monster_menu", monsterMenu[0]); 
		
		var endBitmapData:BitmapData = Assets.getBitmapData("img/end.png"); 
		var endMenu = ResourcesLoader.splitToBitmap(endBitmapData, 0, 0, 180, 50, 1, 3); 
		rs.addBitmap("defaultEnd", endMenu[0]); 
		rs.addBitmap("hoverEnd", endMenu[1]); 
		rs.addBitmap("clickEnd", endMenu[2]); 
		
		rs.addSound("get", Assets.getSound("audio/get.wav")); 
		rs.addSound("monster_hurt", Assets.getSound("audio/hurt.wav")); 
		rs.addSound("hero_hurt", Assets.getSound("audio/hurt_me.wav")); 
		rs.addSound("level_up", Assets.getSound("audio/level_up.wav")); 
		rs.addSound("music", Assets.getSound("audio/music.wav")); 
	}
	
}