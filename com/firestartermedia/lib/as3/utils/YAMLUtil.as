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
	import flash.utils.describeType;
	
	public class YAMLUtil
	{
		public static function formatArray(array:Array, tab:String):String
		{
			var result:String 	= '';
			
			for each ( var item:Object in array )
			{
				result			+= '\n' + tab + '- "' + item.toString() + '"';
			}
			
			return result;
		}
		
		public static function formatHash(hash:Object, tab:String, depth:Number=1):String
		{
			var hashInfo:XML	= describeType( hash );
			var result:String 	= '';
			var item:*;
			var itemInfo:XML;

			if ( hashInfo.@name == 'Object' )
			{
				for ( var key:String in hash )
				{
					item		= hash[ key ];
					
					itemInfo	= describeType( item );
					
					result		+= '\n' + StringUtil.multiply( tab, depth ) + key +': ' + ( itemInfo.@name == 'String' ? item : '' ) + '';
					
					if ( itemInfo.@name != 'String' )
					{
						result	+= formatHash( item, tab, depth + 1 );
					}
				}
			}
			else
			{
				for each ( var v:XML in hashInfo..*.( name() == 'variable' || name() == 'accessor' ) )
				{
					item		= hash[ v.@name ];
					
					result		+= '\n' + StringUtil.multiply( tab, depth ) + v.@name +': ' + item + '';
				}
			}
			
			return result;
		}
	}
}