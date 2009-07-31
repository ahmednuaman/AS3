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
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class DisplayObjectUtil
	{
		public static function removeChildren(target:DisplayObjectContainer):void
		{
			for ( var i:Number = 0; i < target.numChildren; i++ )
			{
				target.removeChildAt( i );
			}
		}
		
		public static function loadMovie(url:String, parent:DisplayObjectContainer=null):Loader
		{
			var request:URLRequest = new URLRequest( url );
			var context:LoaderContext = new LoaderContext();
			var loader:Loader = new Loader();
			
			if ( parent )
			{
				parent.addChild( loader );
			}
			
			try 
			{
				loader.load( request, context );
			}
			catch (e:*)
			{ }
			
			return loader;
		}
	}
}