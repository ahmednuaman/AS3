/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.component
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Reflection extends Sprite
	{
		public var target:DisplayObject;
		
		public function Reflection(target:DisplayObject)
		{
			this.target = target;
			
			init();
		}
		
		private function init():void
		{
			var targetBitmap:BitmapData = new BitmapData( target.width, target.height, true, 0x00FFFFFF );
			var reflection:Sprite = new Sprite();
			var reflectionMatrix:Matrix = new Matrix();
			var gradient:Sprite = new Sprite();
			var gradientMatrix:Matrix = new Matrix();
			
			reflectionMatrix.translate( 0, -target.height );
			reflectionMatrix.scale( 1, -1 );
			
			gradientMatrix.createGradientBox( target.width, target.height, Math.PI * 1.5, 0, ( target.height / 1.5 ) * -1 );
			
			targetBitmap.draw( target, reflectionMatrix );
			
			reflection.graphics.beginBitmapFill( targetBitmap );
			reflection.graphics.drawRect( 0, 0, target.width, target.height );
			reflection.graphics.endFill();
			
			gradient.graphics.beginGradientFill( GradientType.LINEAR, [ 0xFFFFFF, 0xFFFFFF ], [ 0, .8 ], [ 0, 255 ], gradientMatrix );
			gradient.graphics.drawRect( 0, 0, target.width, target.height );
			gradient.graphics.endFill();
			
			reflection.cacheAsBitmap = true;
			gradient.cacheAsBitmap = true;
			
			addChild( reflection );
			addChild( gradient );
			
			reflection.mask = gradient;
		}
	}
}