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
	import com.adobe.utils.ArrayUtil;
	import com.firestartermedia.lib.puremvc.display.Sprite;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class Mediator extends org.puremvc.as3.patterns.mediator.Mediator
	{
		protected var notificationInterests:Array				= [ ];
		protected var notificationHandlers:Dictionary			= new Dictionary();
		
		protected var view:Sprite;
		
		public function Mediator(name:String=null, viewComponent:Object=null)
		{
			super( name, viewComponent );
			
			view					= viewComponent as Sprite;
			
			declareNotificationInterest( 'ApplicationFacadeResize', handleResize );
			
			trackEvent( 'Created ' + mediatorName );
		}
		
		override public function onRegister():void
		{
			trackEvent( 'Registered ' + mediatorName );
		}
		
		override public function onRemove():void
		{
			trackEvent( 'Removed ' + mediatorName );
			
			onReset();
		}
		
		private function onReset():void
		{
			if ( view.hasOwnProperty( 'handleReset' ) )
			{
				trackEvent( 'Reset ' + mediatorName );
				
				view.handleReset();
			}
		}
		
		public function trackEvent(event:String):void
		{
			sendNotification( 'ApplicationFacadeTrack', event );
		}
				
		public function sendEvent(event:*):void
		{
			sendNotification( event.type, event.data );
		}
		
		public function declareNotificationInterest(notificationName:String, func:Function):void
		{			
			notificationInterests.push( notificationName );
			
			notificationInterests	= ArrayUtil.createUniqueCopy( notificationInterests );
			
			notificationHandlers[ notificationName ] = func;
		}
		
		override public function listNotificationInterests():Array
		{
			return notificationInterests;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			notificationHandlers[ notification.getName() ].apply( null, [ notification ] );
		}
		
		public function handleReset(n:INotification):void
		{
			onReset();
		}
		
		public function handleResize(n:INotification):void
		{
			if ( view.hasOwnProperty( 'handleResize' ) )
			{
				view.handleResize( n.getBody() );
			}
		}
	}
}