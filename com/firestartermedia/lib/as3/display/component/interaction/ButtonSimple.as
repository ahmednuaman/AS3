/**
 * @author			Ahmed Nuaman (http://www.ahmednuaman.com)
 * @langversion		3
 * 
 * This work is licenced under the Creative Commons Attribution-Share Alike 2.0 UK: England & Wales License. 
 * To view a copy of this licence, visit http://creativecommons.org/licenses/by-sa/2.0/uk/ or send a letter 
 * to Creative Commons, 171 Second Street, Suite 300, San Francisco, California 94105, USA.
*/
package com.firestartermedia.lib.as3.display.component.interaction
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ButtonSimple extends SimpleButton
	{
		public var bgColourDown:*								= 0x000000;
		public var bgColourOver:*								= 0x666666;
		public var bgColourUp:*									= 0x333333;
		public var border:Boolean								= true;
		public var borderColourDown:uint						= 0x333333;
		public var borderColourOver:uint						= 0x333333;
		public var borderColourUp:uint							= 0x333333;
		public var borderCornerRadius:Number					= 5;
		public var borderWidth:Number							= 1;
		public var buttonPaddingX:Number						= 10;
		public var buttonPaddingY:Number						= 5;
		public var buttonText:String							= 'Click on me!';
		public var textColourDown:uint							= 0xCCCCCC;
		public var textColourOver:uint							= 0xFFFFFF;
		public var textColourUp:uint							= 0xFFFFFF;
		
		public var textFormat:TextFormat;
		
		public function ButtonSimple(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super( upState, overState, downState, hitTestState );
			
			textFormat = new TextFormat();
			
			textFormat.font		= 'Arial';
			textFormat.size		= 10;
		}
		
		public function draw():void
		{
			upState 		= createState( textColourUp, 	bgColourUp, 	borderColourUp );
			overState 		= createState( textColourOver, 	bgColourOver, 	borderColourOver );
			downState 		= createState( textColourDown, 	bgColourDown, 	borderColourDown );
			
			hitTestState 	= upState;
		}
		
		private function createState(textColour:uint, bgColour:*, borderColour:uint):Sprite
		{
			var container:Sprite = new Sprite();
			var button:Sprite = new Sprite();
			var field:TextField = new TextField();
			var matrix:Matrix;
			var bgGradientAlphas:Array;
			var bgGradientRatios:Array;
			
			if ( typeof bgColour == 'object' )
			{
				matrix = new Matrix();
				
				matrix.createGradientBox( 100, 100, Math.PI * .5 );
				
				bgGradientAlphas	= [ ];
				
				bgGradientRatios 	= [ ];
				
				for ( var i:Number = 0; i < bgColour.length; i++ )
				{
					bgGradientAlphas.push( 1 );
					
					bgGradientRatios.push( ( ( i + 1 ) / bgColour.length ) * 255 );
				}
				
				button.graphics.beginGradientFill( GradientType.LINEAR, bgColour, bgGradientAlphas, bgGradientRatios, matrix );
			}
			else
			{
				button.graphics.beginFill( bgColour );
			}
			
			if ( border )
			{
				button.graphics.lineStyle( borderWidth, borderColour );
			}
			
			button.graphics.drawRoundRect( 0, 0, 300, 30, borderCornerRadius, borderCornerRadius );
			button.graphics.endFill();
			button.scale9Grid 			= new Rectangle( borderCornerRadius, borderCornerRadius, 300 - ( borderCornerRadius * 2 ), 30 - ( borderCornerRadius * 2 ) );
			
			container.addChild( button );
			
			field.autoSize				= TextFieldAutoSize.CENTER;
			field.condenseWhite			= true;
			field.defaultTextFormat		= textFormat;
			field.embedFonts			= true;
			field.textColor				= textColour;
			field.text					= buttonText;
			
			button.height 				= field.height + ( buttonPaddingY * 2 );
			button.width 				= field.width + ( buttonPaddingX * 2 );
			
			field.x						= ( button.width / 2 ) - ( field.width / 2 );
			field.y						= ( button.height / 2 ) - ( field.height / 2 );
			
			container.addChild( field );
			
			return container;
		}
	}
}