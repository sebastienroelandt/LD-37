package lib.sro.effect;

import lib.sro.effect.Effect;
import lib.sro.core.Transformation;
import lib.sro.core.Bezier;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class RotationEffect extends Effect
{
	private var rotation: Float;
	
	public function new(on:Sprite, time:Float, ?bezierType:BezierType, ?applyTo:EffectListener = null) 
	{
		super(on, time, bezierType, applyTo);
		rotation = 0;
	}
	
	override public function update(value:Float, diff:Float) {
		rotation = value * 360;
		
		Transformation.rotateDegree(on, new Point(24, 24), rotation);
	}
	
}