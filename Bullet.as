﻿package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	
	public class Bullet extends MovieClip {
		private var dx,dy:Number; // speed
		private var lastTime:int;
		
		public function Bullet(x,y:Number, rot: Number, speed: Number) {
			// set start position
			var initialMove:Number = 35.0;
			this.x = x + initialMove*Math.cos(2*Math.PI*rot/360);
			this.y = y + initialMove*Math.sin(2*Math.PI*rot/360);
			this.rotation = rot;
			
			// get speed
			dx = speed*Math.cos(2*Math.PI*rot/360);
			dy = speed*Math.sin(2*Math.PI*rot/360);
			
			// set up animation
			lastTime = getTimer();
			addEventListener(Event.ENTER_FRAME,moveBullet);
		}
		
		public function moveBullet(event:Event) {
			// get time passed
			var timePassed:int = getTimer()-lastTime;
			lastTime += timePassed;
			
			// move bullet
			this.x += dx*timePassed/1000;
			this.y += dy*timePassed/1000;
			
			// bullet past top of screen
			if (this.x > 900) {
				deleteBullet();
			}
			
		}

		// delete bullet from stage and plane list
		public function deleteBullet() {
			MovieClip(parent).removeBullet(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,moveBullet);
		}

	}
}