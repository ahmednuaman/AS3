/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.threedee.shape
{
	import com.firestartermedia.lib.as3.display.threedee.Sprite3D;
	
	import flash.display.DisplayObject;

	public class Rectangle3D extends Sprite3D
	{
		protected var faces:Object								= { };
		
		public function Rectangle3D()
		{
			super();
		}
		
		public function build():void
		{
			var depth:Number;
			var height:Number;
			var width:Number;
			
			if (  faces.hasOwnProperty( 'all' ) || 
				( faces.hasOwnProperty( 'front' ) && faces.hasOwnProperty( 'back' ) && 
				  faces.hasOwnProperty( 'left' ) && faces.hasOwnProperty( 'right' ) && 
				  faces.hasOwnProperty( 'top' ) && faces.hasOwnProperty( 'bottom' ) ) )
			{
				if ( faces.hasOwnProperty( 'all' ) )
				{
					depth	= faces.all.width;
					height	= faces.all.height;
					width	= faces.all.width;
				}
				else
				{
					depth	= ( faces.left.width >= faces.right.width ? faces.left.width : faces.right.width );
					height	= ( faces.front.height >= faces.back.height ? faces.front.height : faces.back.height );
					width	= ( faces.front.width >= faces.back.width ? faces.front.width : faces.back.width );
				}
								
				render( width, height, depth );
			}
			else
			{
				throw new Error( 'Sorry, you need to specify the faces, so either "all" (not working yet...) or "front, back, left, right, top and bottom"' );
			}
		}
		
		protected function render(width:Number, height:Number, depth:Number):void
		{
			this.depth = depth;
			
			if ( faces.hasOwnProperty( 'all' ) )
			{
				faces.front		= faces.all;
				faces.back		= faces.all;
				faces.left		= faces.all;
				faces.right		= faces.all;
				faces.top		= faces.all;
				faces.bottom	= faces.all;
			}
			
			addChild( faces.back );
			addChild( faces.left );
			addChild( faces.right );
			addChild( faces.top );
			addChild( faces.bottom );
			addChild( faces.front );
			
			faces.back.rotationY 		= 180;
			faces.back.x				= width;
			faces.back.z				= depth;
			
			faces.right.rotationY 		= 90;
			faces.right.x				= width;
			faces.right.z				= depth;
			
			faces.left.rotationY 		= 270;
			faces.left.x				= 0;
			
			faces.top.rotationX 		= 270;
			faces.top.z					= depth;
			
			faces.bottom.rotationX 		= 90;
			faces.bottom.y				= height;
		}
		
		private function orderFaces():void
		{
		}
		
		/* public function set faceAll(object:DisplayObject):void
		{
			faces.all = object;
		} */
		
		public function set faceFront(object:DisplayObject):void
		{
			faces.front = object;
		}
		
		public function set faceBack(object:DisplayObject):void
		{
			faces.back = object;
		}
		
		public function set faceLeft(object:DisplayObject):void
		{
			faces.left = object;
		}
		
		public function set faceRight(object:DisplayObject):void
		{
			faces.right = object;
		}
		
		public function set faceTop(object:DisplayObject):void
		{
			faces.top = object;
		}
		
		public function set faceBottom(object:DisplayObject):void
		{
			faces.bottom = object;
		}
		
		/* public function get faceAll():DisplayObject
		{
			return faces.all as DisplayObject;
		} */
		
		public function get faceFront():DisplayObject
		{
			return faces.front as DisplayObject;
		}
		
		public function get faceBack():DisplayObject
		{
			return faces.back as DisplayObject;
		}
		
		public function get faceTop():DisplayObject
		{
			return faces.top as DisplayObject;
		}
		
		public function get faceBottom():DisplayObject
		{
			return faces.bottom as DisplayObject;
		}
		
		public function get faceLeft():DisplayObject
		{
			return faces.left as DisplayObject;
		}
		
		public function get faceRight():DisplayObject
		{
			return faces.right as DisplayObject;
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value;
			
			orderFaces();
		}
		
		override public function set rotationX(value:Number):void
		{
			super.rotationX = value;
			
			orderFaces();
		}
		
		override public function set rotationY(value:Number):void
		{
			super.rotationY = value;
			
			orderFaces();
		}
		
		override public function set rotationZ(value:Number):void
		{
			super.rotationZ = value;
			
			orderFaces();
		}
	}
}