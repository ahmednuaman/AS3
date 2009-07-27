/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.puremvc.display
{
	import com.firestartermedia.lib.puremvc.events.SpriteEvent;
	
	import flash.display.Sprite;

	public class Sprite extends flash.display.Sprite
	{
		public var display:Boolean								= true;
		public var registered:Boolean							= false;	
		public var ready:Boolean								= false;
		public var tweenResize:Boolean							= false;
		
		public function sendEvent(eventName:String, body:Object=null):void
		{
			dispatchEvent( new SpriteEvent( eventName, body, true ) );
		}
		
		public function sendReady(eventName:String):void
		{
			ready = true;
			
			sendEvent( eventName );
		}
		
		public function handleReset():void
		{
			ready = false;
		}
		
		public function handleResize(e:Object):void
		{
			
		}
	}
}