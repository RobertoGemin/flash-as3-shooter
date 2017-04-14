package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.text.TextField;
	
	public class DieZombie extends MovieClip {
		private var aagun:AAGun;
		private var aagunbase:AAGunBase;
		private var zombies:Array;
		private var bullets:Array;
		public var leftArrow, rightArrow:Boolean;
		private var nextPlanezombies:Timer;
		private var shotsLeft:int;
		private var shotsHit:int;
		private var timeLeft:int;
		private var live:int;
		private var checkHit:Boolean;
		private var survived:Boolean= false
		private var bulletIsShot:Boolean = true;
		private var timer:Timer;
		
		public function startZombie() {
			// init score
			shotsLeft = 6;
			shotsHit = 0;
			showGameScore();
			
			// create gun
			aagun = new AAGun();
			addChild(aagun);
			aagunbase = new AAGunBase();
			addChild(aagunbase);
			aagunbase.x = aagun.x;
			aagunbase.y = aagun.y;
			
			// create object arrays
			zombies = new Array();
			bullets = new Array();
			
			// listen for keyboard
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			
			// look for collisions
			addEventListener(Event.ENTER_FRAME,checkForHits);

			// start planes flying
			setNextzombies();
			timer =new Timer(1000, 21);
			timer.addEventListener(TimerEvent.TIMER, countdown);
			timer.start(); 



			
			
		}
		
		function countdown(event:TimerEvent) 
		{
		showTime.text = String("Time Left: "+timeLeft);
		timeLeft = 20 - timer.currentCount;
		if (timeLeft < 1 )
		{
			timer.stop();
			survived =true;
		}
		
		}
		//speed respawn Zombie
		public function setNextzombies() {
			
			nextPlanezombies = new Timer(1000+Math.random()*1000,1);
			nextPlanezombies.addEventListener(TimerEvent.TIMER_COMPLETE,newZombies);
			nextPlanezombies.start();
			
		}
		
		public function newZombies(event:TimerEvent) 
		{
				
			
			var altitude:Number = Math.random()*50+280;
			var speed:Number = Math.random()*50+30;
			var p:Zombie = new Zombie(speed,altitude);
			addChild(p);
			zombies.push(p);
			//create new zombie to timer
			setNextzombies();
		}
		
		
		public function gethitZombie() {
			checkHit = true;
		}
		
		// check for collisions
		public function checkForHits(event:Event) {
			
			//trace(Airplane.checkZombieFunction()); 
			for(var bulletNum:int=bullets.length-1;bulletNum>=0;bulletNum--){ 
				for (var airplaneNum:int=zombies.length-1;airplaneNum>=0;airplaneNum--) {
					if (bullets[bulletNum].hitTestObject(zombies[airplaneNum])) {
						zombies[airplaneNum].planeHit();
						//bullets[bulletNum].deleteBullet();
						shotsHit++;
						showGameScore();
						break;
					}
				}
			}
			
			if (checkHit == true)
			{
				
				//if ((shotsLeft == 0) && (bullets.length == 0)) {
				endGame();
			trace("end game")
			}
			else if (survived == true)
			{
				endGameyouWin();
			
			}
		}
		
		// key pressed
		public function keyDownFunction(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;
			} else if (event.keyCode == 32) {
				if(bulletIsShot == true)
				{
				aagun.animation.gotoAndPlay(2)
				//aagun.animation.gotoAndPlay(2);
				fireBullet();
				bulletIsShot = false;
				}
			}
		}
		
		// key lifted
		public function keyUpFunction(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
				rightArrow = false;
			}
			else if (event.keyCode == 32)
			{
				bulletIsShot= true;
			}
		}

		// new bullet created
		public function fireBullet() {
			if (shotsLeft <= 0) return;
			var b:Bullet = new Bullet(aagun.x,aagun.y,aagun.rotation,300);
			addChild(b);
			bullets.push(b);
			//shotcount
			shotsLeft--;
			showGameScore();
		}
		
		public function showGameScore() {
			showScore.text = String("Score: "+shotsHit);
			showShots.text = String("Shots Left: "+shotsLeft);
			showTime.text = String("Time Left: "+timeLeft);
		}
		
		// take a plane from the array
		public function removeZombies(plane:Zombie) {
			for(var i in zombies) {
				if (zombies[i] == plane) {
					zombies.splice(i,1);
					break;
				}
			}
		}
		
		// take a bullet from the array
		public function removeBullet(bullet:Bullet) {
			for(var i in bullets) {
				if (bullets[i] == bullet) {
					bullets.splice(i,1);
					break;
				}
			}
		}
		
		// game is over, clear movie clips
		public function endGameyouWin() {
			shotsLeft = 6;
			shotsHit = 0;
			timer.stop();
			
			// remove planes
			for(var i:int=zombies.length-1;i>=0;i--) {
				zombies[i].deletePlane();
			}
			zombies = null;
			
			for(var a:int=bullets.length-1;a>=0;a--) {
				bullets[a].deleteBullet();
			}
			
			bullets = null;
			aagun.deleteGun();
			aagun = null;
			removeChild(aagunbase);
			aagunbase = null;
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			removeEventListener(Event.ENTER_FRAME,checkForHits);
			
			nextPlanezombies.stop();
			nextPlanezombies = null;
			
			gotoAndStop("youWin");
		}

	
		
		
		
		// game is over, clear movie clips
		public function endGame() {
			shotsLeft = 6;
			shotsHit = 0;
			timer.stop();
			checkHit = false;
		  survived = false
		  bulletIsShot= true;
			
		
			// remove planes
			for(var i:int=zombies.length-1;i>=0;i--) {
				zombies[i].deletePlane();
			}
			zombies = null;
			
			for(var a:int=bullets.length-1;a>=0;a--) {
				bullets[a].deleteBullet();
			}
			
			bullets = null;
			aagun.deleteGun();
			aagun = null;
			removeChild(aagunbase);
			aagunbase = null;
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			removeEventListener(Event.ENTER_FRAME,checkForHits);
			
			nextPlanezombies.stop();
			nextPlanezombies = null;
			
			gotoAndStop("gameover");
		}

	}
}
