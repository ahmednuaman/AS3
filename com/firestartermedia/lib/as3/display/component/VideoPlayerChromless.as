/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.component
{
	import com.firestartermedia.lib.as3.events.VideoPlayerEvent;
	import com.firestartermedia.lib.as3.utils.ArrayUtil;
	import com.firestartermedia.lib.as3.utils.NumberUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.setTimeout;

	public class VideoPlayerChromless extends Sprite
	{
		public var bufferTime:Number							= 2;
		
		private var cuePoints:Array								= [ ];
		private var lastFiredCuePoint:Number					= 0;
		private var metaData:Object								= { };
		private var video:Video									= new Video();
		
		private var isLoading:Boolean;
		private var isOverHalfWay:Boolean;
		private var isPlaying:Boolean;
		private var rawHeight:Number;
		private var rawWidth:Number;
		private var stream:NetStream;
		private var videoHeight:Number;
		private var videoWidth:Number;
		
		public function VideoPlayerChromless()
		{
			var connection:NetConnection = new NetConnection();
			
			connection.addEventListener( NetStatusEvent.NET_STATUS, handleNetStatus );
			
			connection.connect( null );
			
			stream = new NetStream( connection );
			
			stream.bufferTime = 5;
			stream.client = { onMetaData: handleOnMetaData };
			
			stream.addEventListener( NetStatusEvent.NET_STATUS, handleNetStatus );
			
			video.smoothing = true;
			
			video.attachNetStream( stream );
			
			addChild( video );
		}
		
		public function play(url:String):void
		{
			stream.bufferTime = bufferTime;
			
			stream.close();
						
			stream.play( url );
			
			isLoading = true;
			
			isOverHalfWay = false;
			
			isPlaying = false;
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		public function seekTo(seconds:Number):void
		{
			stream.seek( seconds );
		}
		
		public function setVolume(volume:Number):void
		{
			var sound:SoundTransform = new SoundTransform( volume );
			
			stream.soundTransform = sound;
		}
		
		private function handleEnterFrame(e:Event):void
		{
			if ( isLoading )
			{
				checkLoadingStatus();
			}
			
			if ( cuePoints.length > 0 )
			{
				checkForCuePoints();
			}
		}
		
		private function checkLoadingStatus():void
		{
			var progress:Object = loadingProgress;
			
			if ( progress.total === 1 )
			{
				isLoading = false;
				
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.LOADED ) );
			}
			else
			{
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.LOADING, progress ) );
			}
		}
		
		private function checkForCuePoints():void
		{
			var time:Number = playingTime.current;
			var checkTime:Number = Math.floor( time );
			var test:Number = ArrayUtil.search( cuePoints, checkTime );
			var cuePoint:Number;
			
			if ( test > -1 )
			{
				cuePoint = cuePoints[ test ];
				
				if ( cuePoint > lastFiredCuePoint )
				{
					dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.CUE_POINT, { point: cuePoint, halfway: false, finished: false } ) );
					
					lastFiredCuePoint = cuePoint;
				}
				
			}
			
			if ( !isOverHalfWay && ( time / 2 ) > playingTime.total )
			{
				isOverHalfWay = true;
				
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.HALF_WAY, { point: checkTime, halfway: true, finished: false } ) );
			}
		}
		
		public function addCuePoint(seconds:Number):void
		{
			cuePoints.push( seconds );
		}
		
		public function pause():void
		{
			stream.pause();
			
			isPlaying = false;
			
			dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.PAUSED ) );
		}
		
		public function resume():void
		{
			stream.resume();
			
			isPlaying = true;
			
			dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.PLAYING ) );
		}
		
		private function handleNetStatus(e:NetStatusEvent):void
		{
			var code:String = e.info.code;
			
			switch ( code )
			{
				case 'NetStream.Play.Start':
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.BUFFERING ) );
				
				break;
				
				case 'NetStream.Buffer.Full':
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.STARTED ) );
				
				//resume();
				
				break;
				
				case 'NetStream.Play.Stop':
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.ENDED, { point: playingTime.total, halfway: false, finished: true } ) );
				
				break;
				
				case 'NetStream.Seek.InvalidTime':
				//dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.BUFFERING ) );
				
				break;
				
				case 'NetStream.Seek.Notify':
				dispatchEvent( new VideoPlayerEvent( VideoPlayerEvent.BUFFERING ) );
				
				break;
			}
		}
		
		private function handleOnMetaData(info:Object):void
		{
			metaData = info;
		}
		
		public function resize(width:Number=0, height:Number=0):void
		{
			rawHeight = height;
			rawWidth = width;
			
			video.visible = false;
			
			if ( !metaData.hasOwnProperty( 'height') && !metaData.hasOwnProperty( 'width' ) )
			{
				setTimeout( resize, 200, width, height );
			}
			else
			{
				doResize( width, height );
			}
		}
		
		private function doResize(width:Number, height:Number):void
		{
			var targetHeight:Number = ( height > 0 ? height : videoHeight );
			var targetWidth:Number = targetHeight * ( metaData.width / metaData.height );
			
			if ( targetWidth > width )
			{
				targetWidth = ( width > 0 ? width : videoWidth );
				targetHeight = targetWidth * ( metaData.height / metaData.width );
			}
			
			videoHeight = targetHeight;
			videoWidth = targetWidth;
			
			video.height = targetHeight;
			video.width = targetWidth;
			video.visible = true;
			video.x = ( width / 2 ) - ( targetWidth / 2 );
			video.y = ( height / 2 ) - ( targetHeight / 2 );
		}
		
		public function get loadingProgress():Object
		{
			var progress:Object = { };
			
			progress.total = stream.bytesLoaded / stream.bytesTotal;
			progress.bytesLoaded = stream.bytesLoaded;
			progress.bytesTotal = stream.bytesTotal;
			
			return progress;
		}
		
		public function get playingTime():Object
		{
			var time:Object = { };
			
			time.current = stream.time;
			time.total = metaData.duration;
			time.formatted = NumberUtil.toTimeString( Math.round( stream.time ) ) + ' / ' + NumberUtil.toTimeString( Math.round( metaData.duration ) );
		
			return time;
		}
	}
}