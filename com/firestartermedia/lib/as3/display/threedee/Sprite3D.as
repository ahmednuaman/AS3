package com.firestartermedia.lib.as3.display.threedee
{
	import com.firestartermedia.lib.as3.utils.DisplayObjectUtil;
	import com.firestartermedia.lib.as3.utils.NumberUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	public class Sprite3D extends Sprite
	{
		protected var _container:Sprite							= new Sprite();
		
		private var _angleX:Number								= 0;
		private var _angleY:Number								= 0;
		private var _angleZ:Number								= 0;
		private var _depth:Number								= 0;
		private var _height:Number								= 0;
		private var _width:Number								= 0;
		private var _x:Number									= 0;
		private var _y:Number									= 0;
		private var _z:Number									= 0;
		
		private var _depthInitial:Number;
			
		public function Sprite3D()
		{
			super();
			
			super.addChild( container );
		}
		
		public function rotate(rotX:Number, rotY:Number, rotZ:Number, p:Vector3D=null):void
		{
			var pivot:Vector3D = ( p ||= calculatePivotPoint() );
			var matrix:Matrix3D = container.transform.matrix3D;
			
			if ( matrix )
			{
				matrix.identity();
				matrix.appendTranslation( -pivot.x, -pivot.y, -pivot.z );
		        matrix.appendRotation( rotX, Vector3D.X_AXIS );
		        matrix.appendRotation( rotY, Vector3D.Y_AXIS );
		        matrix.appendRotation( rotZ, Vector3D.Z_AXIS );
		        matrix.appendTranslation( pivot.x, pivot.y, pivot.z );
			}
		}
		
		private function calculatePivotPoint():Vector3D
		{
			var pivot:Vector3D = new Vector3D( width / 2, height / 2, depth / 2 );
			
			return pivot;
		}
		
		private function calculatePosition():void
		{		
			calculateHeight();
			calculateWidth();
			calculateDepth();
			
			rotate( _angleX, _angleY, _angleZ );
		}
		
		private function calculateDepth():void
		{ 
			var depthX:Number		= NumberUtil.toScalar( NumberUtil.calculateOppposite( rotationX, _height, true ) 		+ NumberUtil.calculateAdjacent( rotationX, _depthInitial, true ) );
			var depthY:Number		= NumberUtil.toScalar( NumberUtil.calculateOppposite( rotationX, _width / 2, true ) 	+ NumberUtil.calculateAdjacent( rotationX, _depthInitial, true ) );
			var depthZ:Number		= NumberUtil.toScalar( NumberUtil.calculateOppposite( rotationX, _height / 2, true ) );
			var newDepth:Number		= 0;
			
			if ( depthX > depthY && depthX > depthZ && depthX > newDepth )
			{
				newDepth = depthX;
			}
			
			if ( depthY > depthX && depthY > depthZ && depthY > newDepth )
			{
				newDepth = depthY;
			}
			
			if ( depthZ > depthX && depthZ > depthY && depthZ > newDepth )
			{
				newDepth = depthZ;
			}
			
			_depth = ( newDepth === 0 ? _depthInitial : newDepth );
		}
		
		private function calculateHeight():void
		{
			var callback:Function;
			var heights:Array;
			
			callback = function(target:DisplayObject):Number
			{
				return target.height;
			}
			
			heights = DisplayObjectUtil.eachChild( container, callback );
			
			heights.sort( Array.DESCENDING | Array.NUMERIC );
			
			_height = heights[ 0 ];
		}
		
		private function calculateWidth():void
		{
			var callback:Function;
			var widths:Array;
			
			callback = function(target:DisplayObject):Number
			{
				return target.width;
			}
			
			widths = DisplayObjectUtil.eachChild( container, callback );
			
			widths.sort( Array.DESCENDING | Array.NUMERIC );
			
			_width = widths[ 0 ];
		}
		
		public function get container():Sprite
		{
			return _container;
		}
		
		public function set depth(value:Number):void
		{
			if ( !_depthInitial )
			{
				_depthInitial = value;
			}
			
			_depth = value;
			
			calculatePosition();
		}
		
		public function get depth():Number
		{
			return _depth;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var c:DisplayObject = container.addChild( child );
			
			calculatePosition();
			
			return c;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var c:DisplayObject = container.addChildAt( child, index );
			
			calculatePosition();
			
			return c;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var c:DisplayObject = container.removeChild( child );
			
			calculatePosition();
			
			return c;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var c:DisplayObject = container.removeChildAt( index );
			
			calculatePosition();
			
			return c;	
		} 
		
		override public function set rotationX(value:Number):void
		{
			_angleX = NumberUtil.actualDegrees( value );
			
			calculatePosition();
		}
		
		override public function get rotationX():Number
		{
			return _angleX;
		}
		
		override public function set rotationY(value:Number):void
		{
			_angleY = NumberUtil.actualDegrees( value );
			
			calculatePosition();
		}
		
		override public function get rotationY():Number
		{
			return _angleY;
		}
		
		override public function set rotationZ(value:Number):void
		{
			_angleZ = NumberUtil.actualDegrees( value );
			
			calculatePosition();
		}
		
		override public function get rotationZ():Number
		{
			return _angleZ;
		}
	}
}