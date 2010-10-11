package com.firestartermedia.lib.as3.events
{
	import flash.events.Event;

	public class WebCamEvent extends Event
	{
		public static const NAME:String							= 'WebCamEvent';
		
		public static const CONNECTING:String					= NAME + 'Connecting';
		public static const CONNECTED:String					= NAME + 'Connected';
		public static const CONNECTION_FAILED:String			= NAME + 'ConnectionFailed';
		public static const NO_WEBCAM:String					= NAME + 'NoWebcam';
		public static const RECORDING_STARTED:String			= NAME + 'RecordingStarted';
		public static const RECORDING_STOPPED:String			= NAME + 'RecordingStopped';
		public static const RECORDING_FINISHED:String			= NAME + 'RecordingFinished';
		
		public function WebCamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}
	}
}