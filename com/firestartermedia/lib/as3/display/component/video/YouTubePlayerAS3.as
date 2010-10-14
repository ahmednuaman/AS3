/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.component.video
{
	import com.firestartermedia.lib.as3.events.YouTubePlayerEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;

	public class YouTubePlayerAS3 extends Sprite
	{
		public static const QUALITY_SMALL:String				= 'small';
		public static const QUALITY_MEDIUM:String				= 'medium';
		public static const QUALITY_LARGE:String				= 'large';
		public static const QUALITY_HD:String					= 'hd720';
		public static const QUALITY_DEFAULT:String				= 'default';
		
		public var autoplay:Boolean								= false;
		public var chromeless:Boolean							= false;
		public var loop:Boolean									= false;
		public var pars:String									= '';
		public var playerHeight:Number							= 300;
		public var playerWidth:Number							= 400;
		public var quality:String								= QUALITY_LARGE;
		
		private var isLoaded:Boolean							= false;
		private var isPlaying:Boolean							= false;
		private var requestURLChromed:String					= 'http://www.youtube.com/v/ID?version=3';
		private var requestURLChromeless:String					= 'http://www.youtube.com/apiplayer?version=3';
		
		private var player:Object;
		private var videoId:String;
		
		public function YouTubePlayerAS3()
		{
			Security.allowDomain( '*' );
			Security.allowDomain( 'www.youtube.com' );  
			Security.allowDomain( 'youtube.com' );  
			Security.allowDomain( 's.ytimg.com' );  
			Security.allowDomain( 'i.ytimg.com' );
		}
		
		public function play(videoId:String):void
		{
			this.videoId = videoId;
			
			if ( !isLoaded )
			{
				loadPlayer();
			}
			else
			{
				playVideo();
			}	
		}
		
		private function loadPlayer():void
		{
			var request:URLRequest 	= new URLRequest( ( chromeless ? requestURLChromeless : requestURLChromed.replace( 'ID', videoId ) ) + ( pars.indexOf( '&' ) !== 0 ? '&' : '' ) + pars );
			var loader:Loader 		= new Loader();
			
			loader.contentLoaderInfo.addEventListener( Event.INIT, handleLoaderInit );
			
			loader.load( request );	
		}
		
		private function handleLoaderInit(e:Event):void
		{
			var player:Object = e.target.content;
			
			player.addEventListener( 'onReady', 				handlePlayerReady );
			player.addEventListener( 'onStateChange', 			handlePlayerStateChange );
			player.addEventListener( 'onPlaybackQualityChange', handlePlayerQualityChange );
			player.addEventListener( 'onError', 				handlePlayerError );
			
			addChild( player as DisplayObject );
		}
		
		private function handlePlayerReady(e:Event):void
		{
			player 					= e.target;
			
			isLoaded 				= true;
			
			dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.READY ) );
			
			player.setSize( playerWidth, playerHeight );
			
			playVideo();
		}
		
		private function handlePlayerStateChange(e:Object):void
		{
			var state:Number = player.getPlayerState();
			
			switch ( state )
			{
				case 0:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.ENDED ) );
				
				isPlaying	= false;
				
				if ( loop )
				{
					playVideo();
				}
				
				break;
				
				case 1:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PLAYING ) );
				
				isPlaying	= true;
				
				break;
				
				case 2:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.PAUSED ) );
				
				isPlaying	= false;
				
				break;
				
				case 3:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.BUFFERING ) );
				
				isPlaying	= false;
				
				if ( getPlaybackQuality() != quality )
				{
					setPlaybackQuality( quality );
				}
				
				break;
				
				case 4:
				// hmmm?
									
				break;
				
				case 5:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.QUEUED ) );
				
				isPlaying	= false;
				
				if ( getPlaybackQuality() != quality )
				{
					setPlaybackQuality( quality );
				}
				
				break;
				
				default:
				dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.NOT_STARTED ) );
				
				isPlaying	= false;
				
				break;
			}
		}
		
		private function handlePlayerQualityChange(e:Object):void
		{
			dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.QUALITY_CHANGED, getPlaybackQuality() ) ); 
		}
		
		private function handlePlayerError(e:Object):void
		{
			dispatchEvent( new YouTubePlayerEvent( YouTubePlayerEvent.ERROR, e ) );
		}
		
		private function playVideo():void
		{
			if ( isLoaded )
			{
				if ( !autoplay )
				{
					player.cueVideoById( videoId );
				}
				else
				{
					player.loadVideoById( videoId );
				}
			}
		}
		
		public function stop():void
		{
			if ( isLoaded )
			{
				player.stopVideo();
			}
		}
		
		public function pause():void
		{
			if ( isLoaded )
			{
				player.pauseVideo();
			}
		}
		
		public function resume():void
		{
			if ( isLoaded )
			{
				player.playVideo();
			}
		}
		
		public function getCurrentTime():Number
		{
			return ( isLoaded ? player.getCurrentTime() : 0 );
		}
		
		public function getDuration():Number
		{
			return ( isLoaded ? player.getDuration() : 0 );
		}
		
		public function getVideoUrl():String
		{
			return ( isLoaded ? player.getVideoUrl() : '' );
		}
		
		public function getPlaybackQuality():String
		{
			return ( isLoaded ? player.getPlaybackQuality() : '' );
		}
		
		public function getVideoBytesLoaded():Number
		{
			return ( isLoaded ? player.getVideoBytesLoaded() : 0 );
		}
		
		public function getVideoBytesTotal():Number
		{
			return ( isLoaded ? player.getVideoBytesTotal() : 0 );
		}
		
		public function setPlaybackQuality(suggestedQuality:String):void
		{
			if ( isLoaded )
			{
				player.setPlaybackQuality( suggestedQuality );
			}
		}
		
		public function mute():void
		{
			if ( isLoaded )
			{
				player.mute();
			}
		}
		
		public function unMute():void
		{
			if ( isLoaded )
			{
				player.unMute();
			}
		}
		
		public function isMuted():Boolean
		{
			return ( isLoaded ? player.isMuted() : false );
		}
		
		public function setVolume(value:Number):void
		{
			if ( isLoaded )
			{
				player.setVolume( value );
			}
		}
		
		public function getVolume():Number
		{
			return ( isLoaded ? player.getVolume() : 0 );
		}
		
		public function seekTo(seconds:Number, allowSeekAhead:Boolean=true):void
		{
			if ( isLoaded )
			{
				player.seekTo( seconds, allowSeekAhead );
			}
		}
		
		public function get ytPlayer():Object
		{
			return ( isLoaded ? player : null );
		}
		
		public function get playing():Boolean
		{
			return isPlaying;
		}
		
		override public function set height(value:Number):void
		{
			playerHeight 			= value;
			
			if ( isLoaded )
			{
				player.setSize( playerWidth, playerHeight );
			}
		}
		
		override public function set width(value:Number):void
		{
			playerWidth 			= value;
			
			if ( isLoaded )
			{
				player.setSize( playerWidth, playerHeight );
			}
		}
	}
}