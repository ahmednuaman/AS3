package com.firestartermedia.lib.as3.display.shape
{
	import com.firestartermedia.lib.as3.utils.NumberUtil;
	
	import flash.display.Shape;

	public class Polygon extends Shape
	{
		public function Polygon(radius:Number=100, segments:Number=5, bgColour:uint=0xFF6600, borderColour:uint=0x000099, borderThickness:Number=1)
		{
			super();
			
			draw( radius, segments, bgColour, borderColour, borderThickness );
		}
		
		protected function draw(radius:Number, segments:Number, bgColour:uint, borderColour:uint, borderThickness:Number):void
		{
			var coords:Array 		= [ ];
			var ratio:Number		= 360 / segments;
			var vectorId:Number 	= 0;
			var vectorRadians:Number;
			var vectorX:Number;
			var vectorY:Number;
			var prevVector:Array;
			
			graphics.beginFill( bgColour );
			graphics.lineStyle( borderThickness, borderColour );
			
			for ( var i:Number = 0; i <= 360; i += ratio )
			{
				vectorRadians		= NumberUtil.toRadians( i );
				
				vectorX				= Math.sin( vectorRadians ) * radius;
				vectorY				= ( Math.cos( vectorRadians ) * radius );
				
				coords[ vectorId ]	= [ vectorX, vectorY ];
				
				if ( vectorId >= 1 )
				{
					graphics.lineTo( vectorX, vectorY );
				}
				else
				{
					graphics.moveTo( vectorX, vectorY );
				}
				
				vectorId++;
			}
			
			graphics.endFill();
		}
	}
}