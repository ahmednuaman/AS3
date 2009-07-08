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
	import com.firestartermedia.lib.as3.events.YouTubePlayerEvent;
	import com.gskinner.utils.SWFBridgeAS3;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class YouTubePlayer extends Sprite
	{
		public static const NAME:String							= 'YouTubePlayer';
	
		public static const BRIDGE_AS3_TO_AS2:String			= 'PlayerWrapperBridgeAS3ToAS2';
		public static const BRIDGE_AS2_TO_AS3:String			= 'PlayerWrapperBridgeAS2ToAS3';
		
		public var chromeless:Boolean							= false;
		
		public var autoPlay:Boolean;
		public var pars:String;
		public var playerWidth:Number;
		public var playerHeight:Number;
		public var wrapperURL:String;
		
		private var player:Loader;
		private var bridge:SWFBridgeAS3;
		private var videoId:String;
		private var loaded:Boolean;
		
		public function init(videoId:String):void
		{
			trace( '*** This function is depreciated, please use play() ***' );
			
			play( videoId );
		}
		
		public function play(videoId:String):void
		{
			this.videoId = videoId;
			
			if ( !loaded )
			{
				var request:URLRequest = new URLRequest( wrapperURL );
				
				player = new Loader();
				
				addChild( player );
				
				player.contentLoaderInfo.addEventListener( Event.INIT, handlePlayerLoadedComplete );
				
				player.load( request );
			}
			else
			{
				handlePlayerLoadedComplete();
			}
		}	
		
		private function playVideo(videoId:String):void
		{
			bridge.send( 'playVideo', videoId, playerWidth, playerHeight, autoPlay, pars, chromeless );
		}
		
		public function stop():void
		{
			bridge.send( 'stopVideo' );
		}
		
		public function handlePlayerLoadedComplete(e:Event=null):void
		{						
			if ( bridge )
			{
				handleBridgeConnect(); 
			}
			else
			{
				bridge = new SWFBridgeAS3( BRIDGE_AS3_TO_AS2, this );
			
				bridge.addEventListener( Event.CONNECT, handleBridgeConnect );				
			}
		}
		
		public function sendEvent(e:String):void
		{
			var event:String = YouTubePlayerEvent.NAME + e.replace( /on|player/ , '' );
			
			dispatchEvent( new YouTubePlayerEvent( event ) );
		}
		
		private function handleBridgeConnect(e:Event=null):void
		{			
			loaded = true;
			
			playVideo( videoId );
		}	
	}
}