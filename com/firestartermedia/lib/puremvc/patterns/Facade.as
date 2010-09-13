/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.puremvc.patterns
{
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;

	public class Facade extends org.puremvc.as3.patterns.facade.Facade
	{
		protected var faultEvent:String;
		protected var resizeEvent:String;
		protected var startupEvent:String;
		protected var trackEvent:String;
		
		public function Facade(startupEvent:String, faultEvent:String, resizeEvent:String, trackEvent:String)
		{
			this.faultEvent		= faultEvent;
			this.resizeEvent	= resizeEvent;
			this.startupEvent	= startupEvent;
			this.trackEvent		= trackEvent;
		}
		
		public function startup(stage:Object):void
		{
			sendNotification( startupEvent, stage );
		}
		
		public function sendResize(height:Number, width:Number):void
		{
			sendNotification( resizeEvent, { width: width, height: height } );
		}
		
		public function registerCommands(commands:Array, target:Class):void
		{
			for each ( var command:String in commands )
			{
				registerCommand( command, target );
			}
		}
		
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			if ( notificationName !== faultEvent && notificationName !== resizeEvent && notificationName !== trackEvent )
			{
				sendNotification( trackEvent, { name: notificationName, body: body } );
			}
			
			notifyObservers( new Notification( notificationName, body, type ) );
		}
	}
}