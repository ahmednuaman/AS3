/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.sound.component
{
	import com.firestartermedia.lib.as3.events.SoundPlayerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class SoundPlayer extends EventDispatcher implements IEventDispatcher
	{
		public var autoPlay:Boolean								= true;
		public var bufferTime:Number							= 2;
		
		private var context:SoundLoaderContext					= new SoundLoaderContext();
		private var currentPosition:Number						= 0;
		private var cuePoints:Array								= [ ];
		private var isPlaying:Boolean							= false;
		private var lastFiredCuePoint:Number					= 0;
		
		private var channel:SoundChannel;
		private var sound:Sound;
		
		public function SoundPlayer()
		{
			super( this );
			
			sound.addEventListener( ProgressEvent.PROGRESS, 	handleSoundProgress );
			sound.addEventListener( IOErrorEvent.IO_ERROR,		handleSoundFault );
			sound.addEventListener( Event.ID3,					handleSoundDataReady );
			sound.addEventListener( Event.COMPLETE,				handleSoundComplete );
		}
		
		private function handleSoundProgress(e:ProgressEvent):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.LOADING, loadingProgress ) );
		}
		
		private function handleSoundFault(e:*):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.FAILED ) );
		}
		
		private function handleSoundDataReady(e:Event):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.ID3_READY, sound.id3 ) );
		}
		
		private function handleSoundComplete(e:Event):void
		{
			if ( autoPlay )
			{
				resume();
			}
		}
		
		public function play(url:String):void
		{
			var request:URLRequest 	= new URLRequest( url );
			
			context.bufferTime 		= 2;
			
			currentPosition			= 0;
			
			if ( channel )
			{
				channel 			= null;
			}
			
			if ( sound )
			{
				sound.close();
			}
			
			sound 	= new Sound();
			
			sound.load( request, context );
			
			channel	= sound.play();
		}
		
		public function resume():void
		{
			if ( !channel )
			{
				channel = sound.play();
			}
			
			sound.play( currentPosition );
			
			isPlaying = true;
		}
		
		public function pause():void
		{
			if ( channel )
			{
				currentPosition = channel.position;
				
				channel.stop();
				
				isPlaying = false;
			}
			else
			{
				throw new Error( 'There\'s nothing to pause!' );
			}
		}
		
		public function mute():void
		{
			var t:SoundTransform		= new SoundTransform( 0, 0 );
			
			if ( channel )
			{
				channel.soundTransform	= t;
			}
			else
			{
				throw new Error( 'There\'s nothing to mute!' );
			}
		}
		
		public function get loadingProgress():Object
		{
			var progress:Object 	= { };
			
			progress.total 			= sound.bytesLoaded / sound.bytesTotal;
			progress.bytesLoaded 	= sound.bytesLoaded;
			progress.bytesTotal 	= sound.bytesTotal;
			
			return progress;
		}
		
		public function get playingTime():Object
		{
			var time:Object 	= { };
			
			time.current		= channel.position / 1000;
			time.total			= sound.length / 1000;
			time.formatted		= NumberUtil.toTimeString( Math.round( time.current ) ) + ' / ' + NumberUtil.toTimeString( Math.round( time.total ) );
		
			return time;
		}
	}
}