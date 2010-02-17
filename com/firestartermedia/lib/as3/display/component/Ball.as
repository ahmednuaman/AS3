package com.firestartermedia.lib.as3.display.component
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Ball extends Sprite
	{
		private var ball:Shape									= new Shape();
		
		private var startY:Number;
		
		public function Ball()
		{
			init();
		}
		
		private function init():void
		{
			ball.graphics.beginFill( 0xFF0000 );
			ball.graphics.drawCircle( 0, 0, 100 );
			ball.graphics.endFill();
			
			addChild( ball );
		}
	}
}