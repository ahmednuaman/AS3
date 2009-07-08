package com.firestartermedia.lib.as3.events
{
	import flash.events.Event;

	public class LoaderProgressEvent extends Event
	{
		public static const NAME:String							= 'LoaderProgressEvent';

		public static const SHOW:String							= NAME + 'Show';
		public static const UPDATE:String						= NAME + 'Update';
		public static const COMPLETE:String						= NAME + 'Complete';
		public static const HIDE:String							= NAME + 'Hide';
		
		public var data:Object;
		
		public function LoaderProgressEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
			
			this.data = data;
		}
	}
}