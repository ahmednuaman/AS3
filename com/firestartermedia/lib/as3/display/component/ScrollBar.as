package com.firestartermedia.lib.as3.display.component
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ScrollBar extends Sprite
	{
		public var bar:DisplayObject;
		public var buttonDown:DisplayObject;
		public var buttonUp:DisplayObject;
		public var mask:DisplayObject;
		public var target:DisplayObject;
		
		public function ScrollBar(target:DisplayObject, mask:DisplayObject, bar:DisplayObject, buttonUp:DisplayObject, buttonDown:DisplayObject)
		{
			this.target = target;
			this.bar = bar;
			this.buttonUp = buttonUp;
			this.buttonDown = buttonDown;
			
			init();
		}
		
		private function init():void
		{
			
		}
	}
}