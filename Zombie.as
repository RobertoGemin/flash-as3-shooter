package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	
	public class Zombie extends MovieClip {
		private var dx:Number; // speed and direction
		private var lastTime:int; // animation time
		private var zomiehit:Boolean =false; // animation time
		
		public function Zombie( speed:Number, altitude:Number)
		{
			
				this.x = 600; // start to the right
				dx = -speed; // fly right to left
				this.scaleX = 1; // not reverse
			
			this.y = altitude; // vertical position
			
			this.gotoAndStop(Math.floor(Math.random()*5+1));
			// set up animation
			addEventListener(Event.ENTER_FRAME,moveZombies);
			lastTime = getTimer();
		}
	
		
		
		
		
		public function moveZombies(event:Event) 
		{
			// get time passed
				
			var timePassed:int = getTimer()-lastTime;
			lastTime += timePassed;
			
			// move plane
			this.x += dx*timePassed/1000;
			if(x < 150)
			{				
				MovieClip(parent).gethitZombie();		
			}
			
			
		}
		
		// plane hit, show explosion
		public function planeHit() 
		{
			removeEventListener(Event.ENTER_FRAME,moveZombies);
			MovieClip(parent).removeZombies(this);
			gotoAndPlay("explode");
		}
		
		// delete plane from stage and plane list
		public function deletePlane() 
		{
			removeEventListener(Event.ENTER_FRAME,moveZombies);
			MovieClip(parent).removeZombies(this);
			parent.removeChild(this);
			
			
		}
		
	}
}
