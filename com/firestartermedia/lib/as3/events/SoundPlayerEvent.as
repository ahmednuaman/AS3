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
	
	public class SoundPlayerEvent extends Event
	{
		public static const NAME:String							= 'SoundPlayerEvent';
		
		public static const BUFFERING:String					= NAME + 'Buffering';
		public static const LOADING:String						= NAME + 'Loading';
		public static const LOADED:String						= NAME + 'Loaded';
		public static const ID3_READY:String					= NAME + 'ID3Ready';
		public static const STARTED:String						= NAME + 'Started';
		public static const PLAYING:String						= NAME + 'Playing';
		public static const PAUSED:String						= NAME + 'Paused';
		public static const CUE_POINT:String					= NAME + 'CuePoint';
		public static const HALF_WAY:String						= NAME + 'HalfWay';
		public static const ENDED:String						= NAME + 'Ended';
		public static const ERROR:String						= NAME + 'Error';
		public static const SOUND_CHANGED:String				= NAME + 'SoundChanged';
		public static const FAILED:String						= NAME + 'Failed';
		
		public var data:Object;
		
		public function SoundPlayerEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
			
			this.data = data;
		}
	}
}