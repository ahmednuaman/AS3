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
	import com.adobe.utils.DateUtil;
	
	import mx.utils.StringUtil;
	
	public class YouTubeUtil
	{
		public static function cleanGDataFeed(data:XML):Array
		{
			var cleanData:Array = [ ];
			
			for each ( var entry:XML in data..*::entry )
			{  
				if ( StringUtil.trim( entry..*::videoid ) != '' )
				{
					cleanData.push({ 
						title: entry.*::title, 
						description: entry..*::description,
						keywords: entry..*::keywords,
						author: entry.*::author.name, 
						username: entry..*::credit.toString(), 
						videoId: entry..*::videoid.toString(), 
						rating: entry.*::rating.@average, 
						views: NumberUtil.format( entry.*::statistics.@viewCount ),
						uploaded: DateUtil.parseW3CDTF( entry..*::uploaded.toString() ).valueOf()
					});
				} 
			}
			
			return cleanData;
		}
	}
}