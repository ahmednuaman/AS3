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
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class BitmapUtil
	{
		public static function flatten(source:DisplayObject):BitmapData
		{
			return grab( source, new Rectangle( 0, 0, source.width, source.height ) ); 
		}
		
		public static function grab(source:DisplayObject, rect:Rectangle, smoothing:Boolean=true):BitmapData
		{
			var draw:BitmapData = new BitmapData( source.width, source.height, true, 0 );
			var copy:BitmapData = new BitmapData( rect.width, rect.height, true, 0 );
			
			draw.draw( source, null, null, null, null, smoothing );
			copy.copyPixels( draw, rect, new Point( 0, 0 ) );
			
			draw.dispose();
			
			return copy;
		}
	}
}