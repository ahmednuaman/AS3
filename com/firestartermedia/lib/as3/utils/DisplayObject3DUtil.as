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
	import flash.display.DisplayObject;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	public class DisplayObject3DUtil
	{
		public static function centerRotate(target:DisplayObject, center:Vector3D, degreesX:Number, degreesY:Number, degreesZ:Number):void
		{
			var m:Matrix3D				= target.transform.matrix3D;
		    
		    m.appendTranslation( -center.x, -center.y, -center.z );
		    m.appendRotation( degreesX, Vector3D.X_AXIS );
		    m.appendRotation( degreesY, Vector3D.Y_AXIS );
		    m.appendRotation( degreesZ, Vector3D.Z_AXIS );
		    m.appendTranslation( center.x, center.y, center.z );
		    
			target.transform.matrix3D	= m;
		}
	}
}