/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.data.twitter
{
	import com.firestartermedia.lib.as3.data.DataService;
	import com.firestartermedia.lib.as3.events.DataServiceEvent;
	
	import flash.net.URLRequest;

	public class TwitterDataService extends DataService
	{
		public static const TWITTER_URL:String					= 'http://twitter.com/';
		public static const STATUS_URL:String					= TWITTER_URL + 'statuses/user_timeline/';
		
		public function TwitterDataService()
		{
			super( DataServiceEvent.LOADING, DataServiceEvent.LOADED, DataServiceEvent.READY );
		}
		
		public function getUserStatues(userId:String):void
		{
			var request:URLRequest = new URLRequest( STATUS_URL + userId + '.rss' );
			
			loader.load( request );
		}
	}
}