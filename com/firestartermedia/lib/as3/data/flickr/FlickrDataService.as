/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
 */
package com.firestartermedia.lib.as3.data.flickr
{
	import com.firestartermedia.lib.as3.data.DataService;
	import com.firestartermedia.lib.as3.events.DataServiceEvent;
	
	import flash.net.URLRequest;
	
	public class FlickrDataService extends DataService
	{
		public static const FLICKR_URL:String					= 'http://api.flickr.com/services/rest/?format=json&nojsoncallback=1&api_key=API_KEY&method=';
		
		public static const METHOD_GET_PUBLIC_PHOTOS:String		= 'flickr.people.getPublicPhotos';
		
		public function FlickrDataService()
		{
			super( DataServiceEvent.LOADING, DataServiceEvent.LOADED, DataServiceEvent.READY, DataService.TYPE_JSON );
		}
		
		public function getPublicPhotos(userId:String, apiKey:String, extras:String=''):void
		{
			var request:URLRequest = new URLRequest( FLICKR_URL.replace( 'API_KEY', apiKey ) + METHOD_GET_PUBLIC_PHOTOS + '&user_id=' + userId + '&extras=' + extras );
			
			loader.load( request );
		}
	}
}