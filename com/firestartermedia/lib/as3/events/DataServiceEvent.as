/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.events
{
	import flash.events.Event;

	public class DataServiceEvent extends Event
	{
		public static const NAME:String							= 'GDataServiceEvent';

		public static const LOADING:String						= NAME + 'Loading';
		public static const LOADED:String						= NAME + 'Loaded';
		public static const READY:String						= NAME + 'Ready';
		
		public var data:Object;
		
		public function DataServiceEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		
			this.data = data;
		}
	}
}