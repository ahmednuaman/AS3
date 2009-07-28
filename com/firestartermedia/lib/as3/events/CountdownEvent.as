package com.firestartermedia.lib.as3.events
{
	import flash.events.Event;

	public class CountdownEvent extends Event
	{
		public static const NAME:String							= 'CountdownEvent';
		
		public static const TIME:String							= NAME + 'Time';
		
		public var data:Object;
		
		public function CountdownEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
			
			this.data = data;
		}
		
	}
}