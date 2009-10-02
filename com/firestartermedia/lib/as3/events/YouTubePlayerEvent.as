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

	public class YouTubePlayerEvent extends Event
	{
		public static const NAME:String							= 'YouTubePlayerEvent';
		
		public static const CONNECTED:String					= NAME + 'Connected';
		public static const READY:String						= NAME + 'Ready';
		public static const STATE_CHANGED:String				= NAME + 'StateChange';
		public static const ERROR:String						= NAME + 'Error';
		public static const PLAYING:String						= NAME + 'Playing';
		public static const ENDED:String						= NAME + 'Ended';
		public static const PAUSED:String						= NAME + 'Paused';
		public static const QUEUED:String						= NAME + 'Queued';
		public static const BUFFERING:String					= NAME + 'Buffering';
		public static const NOT_STARTED:String					= NAME + 'NotStarted';
		
		public function YouTubePlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}
	}
}