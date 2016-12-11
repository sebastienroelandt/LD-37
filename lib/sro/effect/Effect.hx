package lib.sro.effect;

import lib.sro.core.Bezier;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;

/**
 * ...
 * @author Sebastien roelandt
 */
class Effect 
{
	private var bezier:Bezier;
	
	private var lastBezierValue:Float;
	private var beginTime:Float;
	private var time:Float;
	
	private var applyTo:EffectListener;
	private var on:Sprite;
	
	private var pause:Bool;
	private var loop:Bool;
	
	public function new(on:Sprite, time:Float, ?bezierType:BezierType, ?applyTo:EffectListener = null) {
		on.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.on = on;
		this.applyTo = applyTo;
		this.beginTime = Lib.getTimer();
		this.lastBezierValue = 0;
		this.bezier = new Bezier(bezierType);
		this.pause = false;
		this.loop = false;
		this.time = time;
	}
	
	private function onEnterFrame(e:Event) {
		var currentTime = Lib.getTimer();
		
		var bezierValue = bezier.getValue((currentTime - beginTime)/time);
		if (bezierValue == - 1.00) {
			if (loop) {
				beginTime = currentTime;
				bezierValue = lastBezierValue = 0;
			} else {
				finish();
				return;
			}
		}
		update(bezierValue, bezierValue - lastBezierValue);
		lastBezierValue = bezierValue;
	}
	
	private function update(value:Float, diff:Float) {
		throw "update function of Effect must be overrited !";
	}
	
	private function finish() {
		on.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		if (applyTo != null) {
			applyTo.finish();
		}
	}
	
	public function setPause(p:Bool) {
		if (p != pause) {
			if (p) {
				// begin pause
			} else {
				// end pause
			}
		}
	}
	
	public function setLoop(p:Bool) {
		if (p != pause) {
			loop = p;
		}
	}
}