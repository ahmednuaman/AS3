package com.firestartermedia.lib.as3.display.threedee
{
	import flash.display.Sprite;

	public class Sprite3D extends Sprite
	{
		private var _depth:Number;
			
		public function Sprite3D()
		{
			super();
		}
		
		public function set depth(value:Number):void
		{
			_depth = value;
		}
		
		public function get depth():Number
		{
			return _depth;
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
		}
		
		override public function set rotationX(value:Number):void
		{
			super.rotationX = value;
		}
		
		override public function set rotationY(value:Number):void
		{
			super.rotationY = value;
		}
		
		override public function set rotationZ(value:Number):void
		{
			super.rotationZ = value;
		}
	}
}