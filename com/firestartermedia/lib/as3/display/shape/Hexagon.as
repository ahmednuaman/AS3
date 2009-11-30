package com.firestartermedia.lib.as3.display.shape
{
	import flash.display.Shape;

	public class Hexagon extends Polygon
	{
		public function Hexagon(radius:Number=100, bgColour:uint=0xFF6600, borderColour:uint=0x000099, borderThickness:Number=1)
		{
			super( radius, 6, bgColour, borderColour, borderThickness );
		}
	}
}