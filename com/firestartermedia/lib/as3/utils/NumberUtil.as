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
	public class NumberUtil
	{
		public static function format(number:Number):String
		{
			var numString:String 	= number.toString()
	        var result:String 		= ''
	        var chunk:String;
	
	        while ( numString.length > 3 )
	        {
				chunk 				= numString.substr( -3 );
				numString 			= numString.substr( 0, numString.length - 3 );
				result 				= ',' + chunk + result;
	        }
	
	        if ( numString.length > 0 )
	        {
				result = numString + result;
	        }
	
	        return result
		}
		
		public static function toTimeString(number:Number, seperator:String=':'):String
		{
			var hours:Number 		= Math.floor( number / 3600 );
    		var minutes:Number 		= Math.floor( ( number % 3600 ) / 60 );
    		var seconds:Number 		= Math.floor( ( number % 3600 ) % 60 );
    		var times:Array 		= [ likeTime( hours ), likeTime( minutes, true ), likeTime( seconds, true ) ];	
    		var test:Function 		= function(item:String, index:Number, array:Array):Boolean
    								{
    									return ObjectUtil.isValid( item );
    								}
    		
    		return times.filter( test ).join( seperator );
		}
		
		public static function likeTime(number:Number, forceZero:Boolean=false):String
		{
			return ( number > 0 || ( number == 0 && forceZero ) ? prependZero( number ) : '' );
		}
		
		public static function prependZero(number:Number):String
		{
			return ( number < 10 ? '0' + number.toString() : number.toString() );
		}
		
		public static function toUint(string:Object):uint
		{
			return uint( string.toString().replace( '#', '0x' ) );
		}
		
		public static function toScalar(value:Number):Number
		{
			return value * ( value < 0 ? -1 : 1 );
		}
		
		public static function denominate(value:Number, denominator:Number):Number
		{
			var actual:Number = value;
			
			while ( actual >= denominator )
			{
				actual -= denominator;
			}
			
			while ( actual < -denominator )
			{
				actual += denominator;
			}
			
			return actual;
		}
		
		public static function actualDegrees(degrees:Number):Number
		{
			return denominate( degrees, 360 );
		}
		
		public static function actualRadians(radians:Number):Number
		{	
			return denominate( radians, Math.PI * 2 );
		}
		
		public static function toDegrees(radians:Number):Number
		{
			return actualRadians( radians ) * ( 180 / Math.PI );
		}
		
		public static function toRadians(degrees:Number):Number
		{
			return actualDegrees( degrees ) * ( Math.PI / 180 );
		}
		
		public static function calculateAdjacent(value:Number, hypotenuse:Number, isAngle:Boolean=false):Number
		{
			var radians:Number = ( isAngle ? toRadians( value ) : actualRadians( value ) );
			
			return Math.cos( radians ) * hypotenuse;
		}
		
		public static function calculateOppposite(value:Number, hypotenuse:Number, isAngle:Boolean=false):Number
		{
			var radians:Number = ( isAngle ? toRadians( value ) : actualRadians( value ) );
			
			return Math.sin( radians ) * hypotenuse;
		}
		
		public static function calculatePartPercentage(current:Number, total:Number, loaded:Number):Number
		{
			return ( loaded * ( 1 / total ) * 100 ) + ( current / total ) * 100;
		}
	}
}