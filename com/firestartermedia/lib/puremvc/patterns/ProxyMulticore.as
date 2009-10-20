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
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ProxyMulticore extends Proxy
	{
		protected var declare:Boolean							= true;
		
		private var name:String;
		
		public function ProxyMulticore(name:String=null, data:Object=null)
		{
			super( name, data );
			
			this.name = name;
		}
		
		public function trackEvent(event:String):void
		{
			sendNotification( 'ApplicationFacadeTrack', event );
		}
		
		override public function initializeNotifier(key:String):void
		{
			super.initializeNotifier( key );
			
			if ( declare )
			{
				trackEvent( 'Registered ' + name );
			}
		}
	}
}