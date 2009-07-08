/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
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