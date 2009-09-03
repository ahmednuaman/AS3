package com.firestartermedia.lib.as3.events
{
	import flash.events.Event;

	public class TremorMediaWrapperEvent extends Event
	{
		public static const NAME:String							= 'TremorMediaWrapperEvent';
		
		public static const LOADING:String						= NAME + 'Loading';
		public static const READY:String						= NAME + 'Ready';
		public static const PAUSE_CONTENT:String				= NAME + 'PauseContent';
		public static const RESUME_CONTENT:String				= NAME + 'ResumeContent';
		public static const DISPLAYED_BANNER:String				= NAME + 'DisplayedBanner';
		
		public var data:Object;
		
		public function TremorMediaWrapperEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}
	}
}