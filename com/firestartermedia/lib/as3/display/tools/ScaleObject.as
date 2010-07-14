/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.tools
{
	import com.firestartermedia.lib.as3.utils.BitmapUtil;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class ScaleObject extends Sprite
	{
		public var bitmapTL:Sprite;
		public var bitmapTC:Sprite;
		public var bitmapTR:Sprite;
		public var bitmapML:Sprite;
		public var bitmapMC:Sprite;
		public var bitmapMR:Sprite;
		public var bitmapBL:Sprite;
		public var bitmapBC:Sprite;
		public var bitmapBR:Sprite;
		
		private var master:*;
		private var scaleGrid:Rectangle;
		
		public function ScaleObject(master:*, scaleGrid:Rectangle)
		{
			this.master = master;
			this.scaleGrid = scaleGrid;
			
			init();
		}
		
		private function init():void
		{
			var tlX:Number 			= 0;
			var tlY:Number 			= 0;
			var tlWidth:Number 		= scaleGrid.x;
			var tlHeight:Number 	= scaleGrid.y;
			var tcX:Number 			= tlWidth;
			var tcY:Number 			= tlY;
			var tcWidth:Number 		= scaleGrid.width;
			var tcHeight:Number 	= tlHeight;
			var trX:Number 			= tlWidth + tcWidth;
			var trY:Number 			= tlY;
			var trWidth:Number 		= master.width - trX;
			var trHeight:Number 	= tlHeight;
			
			var mlX:Number 			= 0;
			var mlY:Number 			= tlHeight;
			var mlWidth:Number 		= tlWidth;
			var mlHeight:Number 	= scaleGrid.height;
			var mcX:Number 			= tlWidth;
			var mcY:Number 			= mlY;
			var mcWidth:Number 		= tcWidth;
			var mcHeight:Number 	= mlHeight;
			var mrX:Number 			= trX;
			var mrY:Number 			= mlY;
			var mrWidth:Number 		= trWidth;
			var mrHeight:Number 	= mlHeight;
			
			var blX:Number 			= 0;
			var blY:Number 			= tlHeight + mlHeight;
			var blWidth:Number 		= tlWidth;
			var blHeight:Number 	= master.height - blY;
			var bcX:Number 			= tlWidth;
			var bcY:Number 			= blY;
			var bcWidth:Number 		= tcWidth;
			var bcHeight:Number 	= blHeight;
			var brX:Number 			= trX;
			var brY:Number 			= blY;
			var brWidth:Number 		= trWidth;
			var brHeight:Number 	= blHeight;
			
			bitmapTL 				= slice( tlX, tlY, tlWidth, tlHeight );
			bitmapTC 				= slice( tcX, tcY, tcWidth, tcHeight );
			bitmapTR 				= slice( trX, trY, trWidth, trHeight );
			bitmapML 				= slice( mlX, mlY, mlWidth, mlHeight );
			bitmapMC 				= slice( mcX, mcY, mcWidth, mcHeight );
			bitmapMR 				= slice( mrX, mrY, mrWidth, mrHeight );
			bitmapBL 				= slice( blX, blY, blWidth, blHeight );
			bitmapBC 				= slice( bcX, bcY, bcWidth, bcHeight );
			bitmapBR 				= slice( brX, brY, brWidth, brHeight );
		}
		
		private function slice(x:Number, y:Number, width:Number, height:Number):Sprite
		{
			var rect:Rectangle = new Rectangle( x, y, width, height );
			var sliceData:BitmapData = BitmapUtil.grab( master, rect );
			var slice:Sprite;
			
			slice = new Sprite();
			
			slice.graphics.beginBitmapFill( sliceData );
			slice.graphics.drawRect( 0, 0, width, height );
			slice.graphics.endFill();
			slice.x = x;
			slice.y = y;
			
			addChild( slice );
			
			return slice;
		}
		
		override public function set height(value:Number):void
		{
			var targetHeight:Number = Math.floor( value - bitmapTL.height - bitmapBL.height );
			var targetY:Number = Math.floor( value - bitmapBL.height );
			
			bitmapML.height 	= targetHeight;
			bitmapMC.height 	= targetHeight;
			bitmapMR.height 	= targetHeight;
			
			bitmapBL.y 			= targetY;
			bitmapBC.y 			= targetY;
			bitmapBR.y 			= targetY;
		}
		
		override public function set width(value:Number):void
		{
			var targetWidth:Number = Math.floor( value - bitmapTL.width - bitmapTR.width );
			var targetX:Number = Math.floor( targetWidth + bitmapTL.width );
			
			bitmapTC.width 		= targetWidth;
			bitmapMC.width 		= targetWidth;
			bitmapBC.width 		= targetWidth;
			
			bitmapTR.x 			= targetX;
			bitmapMR.x 			= targetX;
			bitmapBR.x 			= targetX;
		}
	}
}