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
	}
}