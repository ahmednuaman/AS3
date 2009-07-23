/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.utils
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class URLUtil
	{
		public static function goToURL(url:String, target:String='_blank'):void
		{
			var request:URLRequest = new URLRequest( url );
			
			navigateToURL( request, target );
		}
		
		public static function parseURL(url:String):Object
		{
			var result:Object = { };
			
			result.protocol		= url.split( '://' )[ 0 ] + '://';
			result.hostAndPort	= url.split( '/' )[ 2 ];
			result.host			= result.hostAndPort.toString().split( ':' )[ 0 ];
			result.port			= result.hostAndPort.toString().split( ':' )[ 1 ];
			
			return result;
		}
	}
}