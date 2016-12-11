package lib.sro.ui;

import openfl.display.Sprite;
import Sys;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicUI extends Sprite
{
	private var _parent:BasicUI;
	private var _childs:List<BasicUI>;
	
	public var pause:Bool;

	public function new(?parent:BasicUI = null) 
	{
		super();
		this._parent = parent;
		this._childs = new List<BasicUI>();
		this.pause = false;
	}
	
	public function add(child:BasicUI) {
		this.addChild(child);
		_childs.add(child);
	}
	
	public function remove(child:BasicUI) {
		_childs.remove(child);
	}
	
	public function removeAll() {
		_childs = new List<BasicUI>();
	}
	
	public function updateAll(delta:Float) {
		if (!pause) {
			for (child in _childs) {
				child.updateAll(delta);
			}
			update(delta);
		}
	}
	
	public function update(delta:Float) {
		// update actions
	}
	
	public function setPause(pause:Bool) {
		if (this.pause != pause) {
			for (child in _childs) {
				child.setPause(pause);
			}
			this.pause = pause;
		}
	}
	
}