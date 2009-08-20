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
	import com.gskinner.utils.SWFBridgeAS3;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;

	public class YouTubePlayer extends Sprite
	{
		public static const NAME:String							= 'YouTubePlayer';
	
		public var bridgeName:String							= 'YouTubePlayerBridge';		
		public var chromeless:Boolean							= false;
		public var playerHeight:Number							= 240;
		public var playerWidth:Number							= 320;
		
		public var autoPlay:Boolean;
		public var pars:String;
		public var wrapperURL:String;
		
		private var isLoaded:Boolean							= false;
		
		private var player:Loader;
		private var bridge:SWFBridgeAS3;
		private var videoId:String;
		
		public function init(videoId:String):void
		{
			trace( '*** This function is depreciated, please use play() ***' );
			
			play( videoId );
		}
		
		public function play(videoId:String):void
		{
			var request:URLRequest;
			
			this.videoId = videoId;
			
			if ( !isLoaded )
			{
				if ( wrapperURL )
				{
					request = new URLRequest( wrapperURL );
				
					player = new Loader();
					
					addChild( player );
					
					player.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, 		handlePlayerLoadFailed );
					player.contentLoaderInfo.addEventListener( Event.INIT, 					handlePlayerLoadComplete );
					
					player.load( request );
				}
				else
				{
					throw new Error( 'You need to specify the wrapper url' );
				}
			}
			else
			{
				handlePlayerLoadComplete();
			}
		}	
		
		private function handlePlayerLoadFailed(e:IOErrorEvent):void
		{
			throw new Error( 'Failed to load wrapper, check the url and permissions?' );
		}
		
		private function handlePlayerLoadComplete(e:Event=null):void
		{						
			if ( bridge )
			{
				handleBridgeConnect(); 
			}
			else
			{
				bridge = new SWFBridgeAS3( bridgeName, this );
			
				bridge.addEventListener( Event.CONNECT, handleBridgeConnect );				
			}
		}
		
		private function handleBridgeConnect(e:Event=null):void
		{			
			isLoaded = true;
			
			trace( 'connected' );
			
			playVideo( videoId );
		}	
		
		private function playVideo(videoId:String):void
		{
			bridge.send( 'playVideo', videoId, playerWidth, playerHeight, autoPlay, pars, chromeless );
		}
		
		public function stop():void
		{
			if ( isLoaded )
			{
				bridge.send( 'stopVideo' );
			}
			else
			{
				setTimeout( stop, 250 );
			}
		}
		
		public function resize(width:Number, height:Number):void
		{
			if ( isLoaded )
			{
				bridge.send( 'resizePlayer', width, height );
			}
			else
			{
				setTimeout( resize, 250, width, height );
			}
		}
		
		public function sendEvent(e:String):void
		{
			var event:String = YouTubePlayerEvent.NAME + e.replace( /on|player/ , '' );
			
			dispatchEvent( new YouTubePlayerEvent( event ) );
		}
	}
}