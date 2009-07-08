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
	import com.firestartermedia.lib.as3.events.LoaderProgressEvent;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import gs.TweenLite;
	import gs.easing.Strong;

	public class LoaderProgressText extends Sprite
	{		
		public var yMargin:Number								= 50;
		public var xMargin:Number								= 0;
		
		private var field:TextField;
		private var format:TextFormat;
		private var loadingPrefix:String;
		
		public function LoaderProgressText(format:TextFormat, filters:Array=null, loadingPrefix:String='Loading')
		{		
			this.format = format;
			this.filters = filters;
			this.loadingPrefix = loadingPrefix;
			
			alpha = 0;
			
			init();
		}
		
		private function init():void
		{			
			field = new TextField();
			
			field.autoSize = TextFieldAutoSize.CENTER;
			field.defaultTextFormat = format;
			field.embedFonts = true;
			field.mouseEnabled = false;
			field.text = loadingPrefix + ' 0%';
			field.wordWrap = false;
			
			addChild( field );
		}
		
		public function show():void
		{
			field.text = loadingPrefix + ' 0%';
			field.x = -xMargin;
			field.y = -yMargin;
			
			TweenLite.to( field, .5, { y: 0, ease: Strong.easeOut } );
			TweenLite.to( this, .5, { autoAlpha: 1, ease: Strong.easeOut } );
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.SHOW, true ) );
		}
		
		public function update(percent:Number):void
		{
			field.text = loadingPrefix + ' ' +percent.toString() + '%';
			
			width = field.width;
			height = field.height;
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.UPDATE, percent, true ) );
			
			if ( percent == 100 )
			{
				dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.COMPLETE, null, true ) );
			}
		}
		
		public function hide():void
		{
			TweenLite.killTweensOf( field );
			TweenLite.killTweensOf( this );
			
			TweenLite.to( field, .5, { y: yMargin, ease: Strong.easeOut } );
			TweenLite.to( this, .5, { autoAlpha: 0, ease: Strong.easeOut } );
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.HIDE, true ) );
		}
	}
}