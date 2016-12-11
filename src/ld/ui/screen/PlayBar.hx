package ld.ui.screen;

import ld.ui.ennemies.MonstersManager;
import ld.ui.ennemies.MonstersGenerator;
import lib.sro.ui.BasicUI;
import lib.sro.ui.ToggleButtonUI;
import lib.sro.core.GameController;
import openfl.display.Sprite;
import openfl.text.TextField;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class PlayBar extends BasicUI
{	
	private var lifeBar 		: Sprite;
	private var currentLife		: Float;
	
	public var scoreText		: TextField;
	private var levelText		: TextField;
	private var labelScore		: String;
	private var labelLevel		: String;
	private var time 			: Float;
	
	public function new() 
	{
		super();
		
		time = 0;
		
		var soundButton = new SoundToggleButtonUI(10,28,GameController.assets.getBitmap("soundActive"), 
            GameController.assets.getBitmap("soundMute"));
		this.add(soundButton);
		
		lifeBar = new Sprite();
		this.addChild(lifeBar);
		
		scoreText = Text.createText("fonts/AAAA.TTF", 32);
		scoreText.x = 500;
		scoreText.y = 15;
		labelScore = "Score: ";
		scoreText.text = labelScore + "000000";
		this.addChild(scoreText);
		
		levelText = Text.createText("fonts/AAAA.TTF", 16);
		levelText.x = 500;
		levelText.y = 55;
		labelLevel = "Difficulty: ";
		levelText.text = labelLevel + "Eadsqsy";
		this.addChild(levelText);
	}
	
	public override function update(delta:Float) {
		var monsterManager = MonstersManager.getInstance();
		var player = monsterManager.target;
		if (player != null && currentLife != player.life) {
			currentLife = player.life;
			var maxLife = player.maxLife;
			this.removeChild(lifeBar);
			lifeBar = new Sprite();		
			lifeBar.graphics.beginFill(0x000000);
			lifeBar.graphics.drawRect(70, 30, 400, 30);
			lifeBar.graphics.endFill();
			lifeBar.graphics.beginFill(0xFF0000);
			if (currentLife > 0) {
				lifeBar.graphics.drawRect(73, 33, 394 * currentLife / maxLife, 24);
			}
			
			lifeBar.graphics.endFill();
			this.addChild(lifeBar);
		}
		if (player != null) {
			time += delta; 
			var score = getScore();
			scoreText.text = labelScore + score;
		}
		
		levelText.text = labelLevel + MonstersGenerator.getInstance().currentLevel;
		
		super.update(delta);
	}
	
	public function getScore():Float {
		return (time - time % 1000) / 100 
				+ MonstersManager.getInstance().fastMonsterKill * 50
				+ MonstersManager.getInstance().normalMonsterKill * 150
				+ MonstersManager.getInstance().tankMonsterKill * 500;
	}
}