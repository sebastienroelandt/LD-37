package ld.effect;

import lib.sro.effect.Effect;
import lib.sro.effect.EffectListener;
import openfl.display.Sprite;
import lib.sro.core.Transformation;
import lib.sro.core.Bezier;
import openfl.geom.Point;
import ld.ui.player.Player;

/**
 * ...
 * @author Sebastien roelandt
 */
class FollowMouseEffect extends Effect
{
	var player:Player;
	
	public function new(on:Player, time:Float, ?bezierType:BezierType, ?applyTo:EffectListener=null) 
	{
		super(on, time, bezierType, applyTo);
		loop = true;
		player = on;
	}
	
	override public function update(value:Float, diff:Float) {
		Transformation.rotateDegree(on, new Point(16, 16), player.playerRotation, new Point(player.x, player.y));
	}
}