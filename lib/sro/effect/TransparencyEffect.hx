package lib.sro.effect;

import lib.sro.effect.Effect;
import lib.sro.core.Bezier;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class TransparencyEffect extends Effect
{
	private var transparency: Float;
	
	public function new(on:Sprite, time:Float, ?bezierType:BezierType, ?listener:EffectListener) 
	{
		super(on, time, bezierType, listener);
		transparency = 0;
	}
	
	override public function update(value:Float, diff:Float) {
		transparency = value;
		
		on.alpha = transparency;
	}
	
}