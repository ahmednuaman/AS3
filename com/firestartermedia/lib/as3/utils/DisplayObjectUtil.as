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
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class DisplayObjectUtil
	{
		public static function removeChildren(target:DisplayObjectContainer):void
		{
			while ( target.numChildren )
			{
				target.removeChildAt( target.numChildren - 1 );
			}
		}
		
		public static function addChildren(target:DisplayObjectContainer, ...children):void
		{
			for each ( var child:DisplayObject in children )
			{
				target.addChild( child );
			}
		}
		
		public static function getChildren(target:DisplayObjectContainer):Array
		{
			var children:Array	= [ ];
			
			for ( var i:Number; target.numChildren < i; i++ )
			{
				children.push( target.getChildAt( i ) );
			}
			
			return children;
		}
		
		public static function loadMovie(url:String, parent:DisplayObjectContainer=null, completeFunction:Function=null, applicationDomain:ApplicationDomain=null, checkPolicyFile:Boolean=false):Loader
		{
			var request:URLRequest 			= new URLRequest( url );
			var context:LoaderContext 		= new LoaderContext( checkPolicyFile, ( applicationDomain ||= ApplicationDomain.currentDomain ) );
			var loader:Loader 				= new Loader();
			
			if ( parent != null )
			{
				parent.addChild( loader );
			}
			
			if ( completeFunction != null )
			{
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeFunction );
			}
			
			try 
			{
				loader.load( request, context );
			}
			catch (e:*)
			{ }
			
			return loader;
		}
		
		public static function scale(target:DisplayObject, width:Number=0, height:Number=0):void
		{
			/*var targetHeight:Number 		= ( height > 0 ? height : target.height );
			var targetWidth:Number 			= targetHeight * ( target.width / target.height );
			
			if ( targetWidth > target.width )
			{
				targetWidth 				= ( width > 0 ? width : target.width );
				targetHeight 				= targetWidth * ( target.height / target.width );
			}
			
			target.height					= targetHeight;
			target.width					= targetWidth;*/
			
			var scaleHeight:Number	= height / target.height;
			var scaleWidth:Number	= width / target.width;
			var scale:Number		= ( scaleHeight <= scaleWidth ? scaleHeight : scaleWidth );
			
			/*target.scaleX			= scale;
			target.scaleY			= scale;*/
			
			target.height			= target.height * scale;
			target.width			= target.width * scale;
			
		}
		
		public static function eachChild(target:DisplayObjectContainer, func:Function):Array
		{
			var funcReturn:Array 			= [ ];
			
			for ( var i:Number = 0; i < target.numChildren; i++ )
			{
				funcReturn.push( func.apply( null, [ target.getChildAt( i ) ] ) );
			}
			
			return funcReturn;
		}
		
		public static function centerRotate(target:DisplayObject, center:Point, degrees:Number):void
		{
			var m:Matrix			= target.transform.matrix;
			
			m.tx 					-= center.x; 
		    m.ty 					-= center.y; 
		    
		    m.rotate( NumberUtil.toRadians( degrees ) ); 
		    
		    m.tx 					+= center.x; 
		    m.ty 					+= center.y; 
		    
			target.transform.matrix	= m;
		}
		
		public static function changeColour(target:DisplayObject, colour:*):void
		{
			var trans:ColorTransform		= target.transform.colorTransform;
			var c:uint						= ( colour is uint ? colour : NumberUtil.toUint( colour ) );
			
			trans.color						= c;
			
			target.transform.colorTransform	= trans;
		}
		
		public static function revertColour(target:DisplayObject):void
		{
			target.transform.colorTransform	= new ColorTransform();
		}
	}
}