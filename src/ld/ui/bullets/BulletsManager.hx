package ld.ui.bullets;

import lib.sro.ui.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
class BulletsManager extends BasicUI
{
	private var bullets			: Array<BasicBullet>;
	private static var ME 		: BulletsManager;

	private function new() {
		bullets = new Array();
		super();
	}
	
	public static function getInstance(?isNew:Bool = false):BulletsManager {
		if (ME == null || isNew) {
			ME = new BulletsManager();
		}
		return ME;
	}
	
	public function getNbBullets():Int {
		return bullets.length;
	}
	
	public function getBullet(i:Int) {
		if (bullets.length > i) {
			return bullets[i];
		}
		return null;
	}
	
	public function addBullet(bullet:BasicBullet) {
		bullets.push(bullet);
		this.add(bullet);
	}
	
	public function removeBullet(bullet:BasicBullet) {
		bullet.visible = false;
		this.remove(bullet);
	}
	
	public override function update(delta:Float) {
		super.update(delta);
	}
}