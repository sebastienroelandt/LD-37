package ld.effect;

import lib.sro.effect.Effect;
import lib.sro.effect.EffectListener;
import openfl.display.Sprite;
import lib.sro.core.Transformation;
import lib.sro.core.Bezier;
import openfl.geom.Point;
import ld.ui.ennemies.Monster;

/**
 * ...
 * @author Sebastien roelandt
 */
class FollowTargetEffect extends Effect
{
	var monster:Monster;
	
	public function new(on:Monster, time:Float, ?bezierType:BezierType, ?applyTo:EffectListener=null) 
	{
		super(on, time, bezierType, applyTo);
		loop = true;
		monster = on;
	}
	
	override public function update(value:Float, diff:Float) {
		Transformation.rotateDegree(on, new Point(monster.centerx, monster.centery), monster.monsterRotation, new Point(monster.absoluteX + monster.centerx, monster.absoluteY + monster.centery));
	}
}