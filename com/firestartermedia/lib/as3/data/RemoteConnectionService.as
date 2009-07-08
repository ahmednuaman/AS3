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
	import com.adobe.serialization.json.JSON;
	import com.firestartermedia.lib.as3.events.RemoteConnectionServiceEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;

	public class RemoteConnectionService extends NetConnection
	{	
		public var handleReady:Boolean							= true;
		
		public var data:Object;
		public var gatewayURL:String;
		public var responder:Responder;
		
		private var loadedEvent:String;
		private var readyEvent:String;
		private var faultEvent:String;
		
		public function RemoteConnectionService(gatewayURL:String, loadedEvent:String='', readyEvent:String='', faultEvent:String='', encoding:uint=3)
		{
			this.gatewayURL = gatewayURL;
			this.loadedEvent = loadedEvent;
			this.readyEvent = readyEvent;
			this.faultEvent = faultEvent;
			
			objectEncoding = encoding;
			
			if ( gatewayURL )
			{						
				responder = new Responder( handleResponseResult, handleResponseFault );
				
				addEventListener( NetStatusEvent.NET_STATUS, handleNetEvent );
				
				connect( gatewayURL );
			}
		}
		
		public function send(method:String, ... args):void
		{
			call.apply( null, [ method, responder ].concat( args ) );
		}
		
		private function handleNetEvent(e:NetStatusEvent):void
		{
			dispatchEvent( new RemoteConnectionServiceEvent( faultEvent, e.info.code ) );
		}
		
		private function handleResponseResult(data:Object):void
		{			
			dispatchEvent( new RemoteConnectionServiceEvent( loadedEvent, data ) ); 
			
			if ( handleReady )
			{
				handleLoaderDataReady( data );
			}
		}
		
		public function handleLoaderDataReady(data:Object):void
		{
			this.data = data;
			
			dispatchEvent( new RemoteConnectionServiceEvent( readyEvent, data ) );
		}
		
		private function handleResponseFault(data:Object):void
		{
			dispatchEvent( new RemoteConnectionServiceEvent( faultEvent, data ) );
		}
	}
}