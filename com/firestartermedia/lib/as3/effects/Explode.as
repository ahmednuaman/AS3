package com.firestartermedia.lib.as3.effects
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import org.osflash.thunderbolt.Logger;

	public class Explode extends Sprite
	{		
		public var target:DisplayObject;
		
		public function Explode(target:DisplayObject)
		{
			this.target = target;
		}
		
		public function init():void
		{
			var targetBitmap:BitmapData = new BitmapData( target.width, target.height, true, 0x00FFFFFF );
			var explosion:Sprite = new Sprite();
			var explosionMatrix:Matrix = new Matrix();
			
			explosionMatrix.scale( 1, 1 );
			
			targetBitmap.draw( target, explosionMatrix );
			
			explosion.graphics.beginBitmapFill( targetBitmap );
			explosion.graphics.drawRect( 0, 0, target.width, target.height );
			explosion.graphics.endFill();
			
			explosion.cacheAsBitmap = true;
			
			addChild( explosion );
			
			target.alpha = 0;
			target.visible = false;
		}
	}
}