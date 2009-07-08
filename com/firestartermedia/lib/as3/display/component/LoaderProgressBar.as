package com.firestartermedia.lib.as3.display.component
{
	import com.firestartermedia.lib.as3.events.LoaderProgressEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import gs.TweenLite;
	import gs.easing.Strong;

	public class LoaderProgressBar extends Sprite
	{
		private var bar:DisplayObject;
		private var maxWidth:Number;
		
		public function LoaderProgressBar(bar:DisplayObject, maxWidth:Number)
		{
			this.bar = bar;
			this.maxWidth = maxWidth;
			
			alpha = 0;
			
			init();
		}
		
		private function init():void
		{
			bar.width = 0;
			
			addChild( bar );
		}
		
		public function show():void
		{
			TweenLite.to( this, .5, { autoAlpha: 1 } );
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.SHOW, true ) );
		}
		
		public function update(percent:Number):void
		{
			TweenLite.to( bar, .5, { width: ( percent / 100 ) * maxWidth, ease: Strong.easeOut, onComplete: checkComplete, onCompleteParams: [ percent ] } );
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.UPDATE, percent, true ) );
		}
		
		private function checkComplete(percent:Number):void
		{
			if ( percent == 100 )
			{
				dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.COMPLETE, null, true ) );
			}
		}
		
		public function hide():void
		{
			TweenLite.to( this, .5, { autoAlpha: 0 } );
			
			dispatchEvent( new LoaderProgressEvent( LoaderProgressEvent.HIDE, true ) );
		}
	}
}