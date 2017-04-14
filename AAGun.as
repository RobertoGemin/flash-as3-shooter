package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	
	public class AAGun extends MovieClip {
		static const speed:Number = 150.0;
		private var lastTime:int; // animation time
		
		public function AAGun() {
			// initial location of gun
			this.x = 110;
			this.y = 185;
			this.rotation = 0;
			
			// movement
			addEventListener(Event.ENTER_FRAME,moveGun);
		}

		public function moveGun(event:Event) {
			// get time difference
			var timePassed:int = getTimer()-lastTime;
			lastTime += timePassed;
			
			// current position
			var newRotation = this.rotation;
			
			// move to the left
			if (MovieClip(parent).leftArrow) {
				newRotation -= speed*timePassed/1000;
				
				
			}
			
			// move to the right
			if (MovieClip(parent).rightArrow) {
				newRotation += speed*timePassed/1000;
			}
			// check boundaries
			if (newRotation < -10) newRotation = -10;
			if (newRotation > 50) newRotation = 50;
			
			// reposition
			this.rotation = newRotation;
		}
		
		// remove from screen and remove events
		public function deleteGun() {
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,moveGun);
		}
	}
}