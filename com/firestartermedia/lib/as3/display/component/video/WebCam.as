/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.component.video
{
	import com.firestartermedia.lib.as3.utils.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;

	public class WebCam extends Sprite
	{
		private var cameraHeight:Number;
		private var cameraWidth:Number;
		private var video:Video;
		
		public function WebCam(width:Number=320, height:Number=240)
		{
			cameraHeight	= height;
			cameraWidth		= width;
			
			init();
		}
		
		private function init():void
		{
			var camera:Camera 	= Camera.getCamera();
			
			video = new Video( cameraWidth, cameraHeight );
			
			video.smoothing		= true;
			
			video.attachCamera( camera );
			
			addChild( video );
		}
		
		public function captureImage():Bitmap
		{
			var image:Bitmap = new Bitmap( BitmapUtil.grab( video, new Rectangle( 0, 0, cameraWidth, cameraHeight ), true ) );
			
			return image;
		}
	}
}