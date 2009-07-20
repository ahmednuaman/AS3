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
	import com.firestartermedia.lib.as3.events.DataServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;

	public class DataService extends EventDispatcher
	{
		public static const TYPE_XML:String						= 'xml';
		public static const TYPE_JSON:String					= 'json';
		
		public var handleReady:Boolean							= true;
		
		public var data:Object;
		public var loader:URLLoader;

		private var loadingEvent:String;
		private var loadedEvent:String;
		private var readyEvent:String;
		private var dataType:String
		
		public function DataService(loadingEvent:String='', loadedEvent:String='', readyEvent:String='', dataType:String='xml')
		{
			this.loadingEvent = loadingEvent;
			this.loadedEvent = loadedEvent;
			this.readyEvent = readyEvent;
			this.dataType = dataType;
			
			loader = new URLLoader();
			
			loader.addEventListener( Event.OPEN, 					handleLoaderStarted );
			loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, 	handleGenericEvent );
			loader.addEventListener( IOErrorEvent.IO_ERROR, 		handleGenericEvent );
			loader.addEventListener( ProgressEvent.PROGRESS, 		handleGenericEvent );
			loader.addEventListener( Event.COMPLETE, 				handleLoaderComplete );
		}
		
		public function handleLoaderStarted(e:Event):void
		{
			dispatchEvent( new DataServiceEvent( loadingEvent ) );
		}
		
		public function handleGenericEvent(e:*):void
		{
			dispatchEvent( e );
		}
		
		public function handleLoaderComplete(e:Event):void
		{
			var data:Object = ( dataType == TYPE_XML ? new XML( e.target.data ) : JSON.decode( e.target.data ) );
			
			dispatchEvent( new DataServiceEvent( loadedEvent, data ) );
			
			if ( handleReady )
			{
				handleLoaderDataReady( data );
			}
		}
		
		public function handleLoaderDataReady(data:Object):void
		{
			this.data = data;
			
			dispatchEvent( new DataServiceEvent( readyEvent, data ) );
		}
	}
}