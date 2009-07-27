package com.firestartermedia.lib.as3.display.component
{
	import flash.display.Sprite;

	public class Countdown extends Sprite
	{
		private var targetDate:Date
		
		public function Countdown(targetDate:Date)
		{
			this.targetDate = targetDate;
			
			init();
		}
		
		private function init():void
		{
			
		}
	}
}