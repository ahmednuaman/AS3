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
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Sprite extends flash.display.Sprite
	{
		public static const NAME:String							= 'Sprite';
		
		public var display:Boolean								= true;
		public var registered:Boolean							= false;	
		public var ready:Boolean								= false;
		public var tweenResize:Boolean							= false;
		
		protected var readyEvent:String;
		protected var resetEvent:String;
		protected var stageHeight:Number;
		protected var stageWidth:Number;
		
		public function Sprite(readyEvent:String='SpriteReady', resetEvent:String='SpriteReset')
		{
			registered = true;
		}
		
		public function addChildren(...children):void
		{
			for each ( var child:DisplayObject in children )
			{
				addChild( child );
			}
		}
		
		public function removeChildren(...children):void
		{
			if ( children )
			{
				for each ( var child:DisplayObject in children )
				{
					removeChild( child );
				}
			}
			else
			{
				for ( var i:Number = 0; i < numChildren; i++ )
				{
					removeChildAt( i );
				}
			}
		}
		
		public function sendEvent(eventName:String, body:Object=null):void
		{
			dispatchEvent( new SpriteEvent( eventName, body, true ) );
		}
		
		public function sendReady(eventName:String=null):void
		{
			if ( !ready )
			{
				ready = true;
			
				sendEvent( ( eventName ||= readyEvent ) );
			}
		}
		
		public function handleReset():void
		{
			ready = false;
			
			sendEvent( resetEvent );
		}
		
		public function handleResize(e:Object=null):void
		{
			
		}
		
		/* public function addBetterEventListener(type:String):void
		{
			
		} */
	}
}