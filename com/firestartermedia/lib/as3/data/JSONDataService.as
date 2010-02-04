/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.data
{
	import com.firestartermedia.lib.as3.events.DataServiceEvent;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class JSONDataService extends DataService
	{
		public function JSONDataService()
		{
			super( DataServiceEvent.LOADING, DataServiceEvent.LOADED, DataServiceEvent.READY, DataService.TYPE_JSON );
		}
		
		public function send(url:String, data:URLVariables=null, method:String='GET'):void
		{
			var request:URLRequest = new URLRequest( url );
			
			request.data = data;
			request.method = method;
			
			try 
			{
				loader.load( request );
				
				dispatchEvent( new DataServiceEvent( DataServiceEvent.LOADING ) );
			} 
			catch (e:*) 
			{ }
		}
		
		public function sendPost(url:String, data:URLVariables=null):void
		{
			send( url, data, URLRequestMethod.POST );
		}
	}
}