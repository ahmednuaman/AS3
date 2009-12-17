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
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class Proxy extends org.puremvc.as3.patterns.proxy.Proxy
	{
		public static const NAME:String							= 'Proxy';
		
		public function Proxy(name:String=null, data:Object=null)
		{
			super( name, data );
			
			trackEvent( 'Registered ' + name );
		}
		
		public function trackEvent(event:String):void
		{
			sendNotification( 'ApplicationFacadeTrack', event );
		}
	}
}