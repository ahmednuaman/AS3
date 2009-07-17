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
	import com.firestartermedia.lib.puremvc.events.CanvasEvent;
	
	import mx.containers.Canvas;

	public class Canvas extends mx.containers.Canvas
	{
		public var registered:Boolean							= false;	
		public var ready:Boolean								= false;
		
		public function sendEvent(eventName:String, body:Object=null):void
		{
			dispatchEvent( new CanvasEvent( eventName, body, true ) );
		}
		
		public function sendReady(eventName:String):void
		{
			ready = true;
			
			sendEvent( eventName );
		}
	}
}