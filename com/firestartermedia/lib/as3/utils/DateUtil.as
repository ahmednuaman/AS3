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
	public class DateUtil
	{
		/**
		 * This is taken from Adobe's CoreLib. Unfortunatly their DateUtil class doesn't seem to work
		 * as it can't find mx.formatters.DateBase and nor can I!
		 * 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function parseW3CDTF(str:String):Date
		{
            var finalDate:Date;
			try
			{
				var dateStr:String = str.substring(0, str.indexOf("T"));
				var timeStr:String = str.substring(str.indexOf("T")+1, str.length);
				var dateArr:Array = dateStr.split("-");
				var year:Number = Number(dateArr.shift());
				var month:Number = Number(dateArr.shift());
				var date:Number = Number(dateArr.shift());
				
				var multiplier:Number;
				var offsetHours:Number;
				var offsetMinutes:Number;
				var offsetStr:String;
				
				if (timeStr.indexOf("Z") != -1)
				{
					multiplier = 1;
					offsetHours = 0;
					offsetMinutes = 0;
					timeStr = timeStr.replace("Z", "");
				}
				else if (timeStr.indexOf("+") != -1)
				{
					multiplier = 1;
					offsetStr = timeStr.substring(timeStr.indexOf("+")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("+"));
				}
				else // offset is -
				{
					multiplier = -1;
					offsetStr = timeStr.substring(timeStr.indexOf("-")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("-"));
				}
				var timeArr:Array = timeStr.split(":");
				var hour:Number = Number(timeArr.shift());
				var minutes:Number = Number(timeArr.shift());
				var secondsArr:Array = (timeArr.length > 0) ? String(timeArr.shift()).split(".") : null;
				var seconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				var milliseconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				var utc:Number = Date.UTC(year, month-1, date, hour, minutes, seconds, milliseconds);
				var offset:Number = (((offsetHours * 3600000) + (offsetMinutes * 60000)) * multiplier);
				finalDate = new Date(utc - offset);
	
				if (finalDate.toString() == "Invalid Date")
				{
					throw new Error("This date does not conform to W3CDTF.");
				}
			}
			catch (e:Error)
			{
				var eStr:String = "Unable to parse the string [" +str+ "] into a date. ";
				eStr += "The internal error was: " + e.toString();
				throw new Error(eStr);
			}
            return finalDate;
		}
		
		public static function toTimestamp(date:Date):String
		{
			var timestamp:String = '';
			
			timestamp 	+= date.getFullYear() + '-' + NumberUtil.prependZero( date.getMonth() + 1 ) + '-' + NumberUtil.prependZero( date.getDate() ) + ' ';
			timestamp	+= NumberUtil.prependZero( date.getHours() ) + ':' + NumberUtil.prependZero( date.getMinutes() ) + ':' + NumberUtil.prependZero( date.getSeconds() );
			
			return timestamp;
		}
		
		public static function toNumericalTimestamp(date:Date):String
		{
			var timestamp:String = '';
			
			timestamp 	+= date.getFullYear() + NumberUtil.prependZero( date.getMonth() + 1 ) + NumberUtil.prependZero( date.getDate() );
			timestamp	+= NumberUtil.prependZero( date.getHours() ) + NumberUtil.prependZero( date.getMinutes() ) + NumberUtil.prependZero( date.getSeconds() );
			
			return timestamp;
		}
		
		/* "stolen" from http://stackoverflow.com/questions/3163/actionscript-3-fastest-way-to-parse-yyyy-mm-dd-hhmmss-to-a-date-object */
		public static function parseUTCDate(str:String):Date 
		{
		    var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
		    var d : Date = new Date();
		
		    d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
		    d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
		
		    return d;
		}
		
		/* "stolen" from http://stackoverflow.com/questions/3163/actionscript-3-fastest-way-to-parse-yyyy-mm-dd-hhmmss-to-a-date-object */
		public static function parseDate(str:String):Date
		{
			var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d)/);
		    var d : Date = new Date();
		
		    d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
		
		    return d;
		}
	}
}