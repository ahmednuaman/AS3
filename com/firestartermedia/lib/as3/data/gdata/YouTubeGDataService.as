/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.data.gdata
{
	import com.firestartermedia.lib.as3.data.DataService;
	import com.firestartermedia.lib.as3.events.DataServiceEvent;
	import com.firestartermedia.lib.as3.utils.YouTubeUtil;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class YouTubeGDataService extends DataService
	{
		public var GDATA_URL:String								= 'http://gdata.youtube.com/feeds/api/';
		public var PLAYLISTS_URL:String							= GDATA_URL + 'playlists';
		public var USERS_URL:String								= GDATA_URL + 'users';
		public var VIDEOS_URL:String							= GDATA_URL + 'videos';
		
		private var currentPlaylistEntries:Number;
		private var playlistEntries:Array;
		private var playlistId:String;
		private var playlistSearch:String;
		
		public function YouTubeGDataService()
		{
			super( DataServiceEvent.LOADING, DataServiceEvent.LOADED, DataServiceEvent.READY );
		}
		
		public function getVideoData(videoId:String):void
		{
			var request:URLRequest = new URLRequest( VIDEOS_URL + '/' + videoId );
			
			load( request );
		}
		
		public function getPlaylistData(playlistId:String, startIndex:Number=1):void
		{
			var request:URLRequest = new URLRequest( PLAYLISTS_URL + '/' + playlistId + '?v=2&max-results=50&start-index=' + startIndex );
			
			load( request );
		}
		
		public function searchPlaylistData(playlistId:String, playlistSearch:String):void
		{
			this.playlistId = playlistId;
			this.playlistSearch = playlistSearch; 
			
			handleReady = false;
			
			currentPlaylistEntries = 1;
			
			playlistEntries = [ ];
			
			addEventListener( DataServiceEvent.LOADED, handleSearchPlaylistDataComplete );
			
			getPlaylistData( playlistId );
		}
		
		private function handleSearchPlaylistDataComplete(e:DataServiceEvent):void
		{
			var data:XML = e.data as XML;
			var length:Number = data..*::itemsPerPage;
			var total:Number = data..*::totalResults;
			var entries:Array = YouTubeUtil.cleanGDataFeed( data );
			
			for each ( var entry:Object in entries )
			{
				if ( playlistEntries.length <= total )
				{
					playlistEntries.push( entry );
				}
			}
				
			currentPlaylistEntries += length;
			
			if ( currentPlaylistEntries >= total )
			{
				searchThroughPlaylistData();
			}
			else
			{				
				getPlaylistData( playlistId, currentPlaylistEntries );
			}
		}
		
		private function searchThroughPlaylistData():void
		{
			var matchEntries:Array = [ ]; 
			
			for each ( var entry:Object in playlistEntries )
			{
				if ( 
					entry.title.toLowerCase().search( playlistSearch.toLowerCase() ) != -1 || 
					entry.description.toLowerCase().search( playlistSearch.toLowerCase() ) != -1 || 
					entry.keywords.toLowerCase().search( playlistSearch.toLowerCase() ) != -1 
				)
				{
					matchEntries.push( entry );
				}
			}
			
			dispatchEvent( new DataServiceEvent( DataServiceEvent.READY, { entries: matchEntries } ) );
		}
		
		public function getUserVideos(username:String, startIndex:Number=1, max:Number=50):void
		{
			var request:URLRequest = new URLRequest( VIDEOS_URL + '?v=2&max-results=' + max + '&start-index=' + startIndex + '&author=' + username );
			
			load( request );
		}
		
		public function getAuthedUserVideos(token:String, devkey:String, startIndex:Number=1, max:Number=50):void
		{
			var request:URLRequest 	= new URLRequest( USERS_URL + '/default/uploads' );
			
			request.contentType		= 'application/atom+xml; charset=UTF-8';
			request.method			= URLRequestMethod.POST;
			request.requestHeaders	= [ new URLRequestHeader( 'X-HTTP-Method-Override', 'GET' ),
										new URLRequestHeader( 'Authorization', 'AuthSub token="' + token + '"' ), 
										new URLRequestHeader( 'GData-Version', '2' ),
										new URLRequestHeader( 'X-GData-Key', 'key=' + devkey ) ];
			request.data			= new URLVariables( 'key=' + devkey );
			
			load( request );
		}
		
		private function load(request:URLRequest):void
		{
			loader.load( request );
			
			dispatchEvent( new DataServiceEvent( DataServiceEvent.LOADING ) );
		}
	}
}