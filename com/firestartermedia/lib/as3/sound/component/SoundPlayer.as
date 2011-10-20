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
	import com.firestartermedia.lib.as3.utils.NumberUtil;
	
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
		public var autoPlay:Boolean								= false;
		public var bufferTime:Number							= 2;
		public var loop:Boolean									= false;
		
		private var context:SoundLoaderContext					= new SoundLoaderContext();
		private var currentPosition:Number						= 0;
		private var cuePoints:Array								= [ ];
		private var isPlaying:Boolean							= false;
		private var lastFiredCuePoint:Number					= 0;
		
		private var channel:SoundChannel;
		private var sound:Sound;
		
		public function SoundPlayer(t:String=null, autoPlay:Boolean=false)
		{
			super( this );
			
			this.autoPlay	= autoPlay;
			
			if ( t )
			{
				play( t );
			}
		}
		
		private function handleSoundProgress(e:ProgressEvent):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.LOADING, loadingProgress ) );
		}
		
		private function handleSoundFault(e:*):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.ERROR, e ) );
		}
		
		private function handleSoundDataReady(e:Event):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.ID3_READY, sound.id3 ) );
		}
		
		private function handleSoundComplete(e:Event):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.LOADED ) );
			
			if ( autoPlay )
			{
				resume();
			}
		}
		
		private function handleSoundOpen(e:Event):void
		{
			if ( !autoPlay )
			{
				pause();
			}
		}
		
		public function play(url:String):void
		{
			var request:URLRequest 	= new URLRequest( url );
			
			context.bufferTime 		= bufferTime;
			
			currentPosition			= 0;
			
			/*if ( channel )
			{
				channel.stop();
				
				channel 			= null;
			}
			
			if ( sound )
			{
				sound.close();
			}*/
			
			stop();
			
			sound 	= new Sound();
			
			sound.addEventListener( ProgressEvent.PROGRESS, 	handleSoundProgress );
			sound.addEventListener( IOErrorEvent.IO_ERROR,		handleSoundFault );
			sound.addEventListener( Event.ID3,					handleSoundDataReady );
			sound.addEventListener( Event.COMPLETE,				handleSoundComplete );
			sound.addEventListener( Event.OPEN,					handleSoundOpen );
			
			sound.load( request, context );
			
			channel	= sound.play( currentPosition, loop ? -1 : 0 );
		}
		
		public function stop():void
		{
			if ( channel )
			{
				dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.STOPPED ) );
				
				channel.stop();
				
				if ( sound.isBuffering )
				{
					try
					{
						sound.close();
					}
					catch (e:*) {}
				}
				
				isPlaying 	= false;
				
				channel		= null;
			}
			/*else
			{
				throw new Error( 'There\'s nothing to stop!' );
			}*/
		}
		
		public function resume():void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.PLAYING ) );
			
			if ( channel )
			{
				channel.stop();
			}
			
			channel	= sound.play( currentPosition );
			
			channel.addEventListener( Event.SOUND_COMPLETE, handleFinished );
			
			isPlaying = true;
		}
		
		public function pause():void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.PAUSED ) );
			
			if ( channel )
			{
				currentPosition = channel.position;
				
				channel.stop();
				
				isPlaying = false;
			}
			/*else
			{
				throw new Error( 'There\'s nothing to pause!' );
			}*/
		}
		
		public function mute():void
		{
			var t:SoundTransform		= new SoundTransform( 0, 0 );
			
			if ( channel )
			{
				dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.MUTED ) );
				
				channel.soundTransform	= t;
			}
			/*else
			{
				throw new Error( 'There\'s nothing to mute!' );
			}*/
		}
		
		public function unmute():void
		{
			var t:SoundTransform		= new SoundTransform( 1, 0 );
			
			if ( channel )
			{
				dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.UNMUTED ) );
				
				channel.soundTransform	= t;
			}
			/*else
			{
				throw new Error( 'There\'s nothing to unmute!' );
			}*/
		}
		
		public function seek(seconds:Number, play:Boolean=true):void
		{
			if ( sound )
			{
				dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.SEEKED ) );
				
				channel.stop();
				
				channel	= sound.play( seconds );
				
				channel.addEventListener( Event.SOUND_COMPLETE, handleFinished );
				
				if ( !play )
				{
					pause();
				}
			}
			/*else
			{
				throw new Error( 'There\'s nothing to seek!' );
			}*/
		}
		
		private function handleFinished(e:Event):void
		{
			dispatchEvent( new SoundPlayerEvent( SoundPlayerEvent.ENDED ) );
			
			/*if ( loop )
			{
				channel	= sound.play( 0 );
			}*/
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
			
			time.current		= channel ? channel.position / 1000 : 0;
			time.total			= sound.length / 1000;
			time.formatted		= NumberUtil.toTimeString( Math.round( time.current ) ) + ' / ' + NumberUtil.toTimeString( Math.round( time.total ) );
		
			return time;
		}
	}
}