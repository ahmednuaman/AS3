package com.firestartermedia.lib.as3.display.component
{
	import com.firestartermedia.lib.as3.events.CountdownEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;

	public class Countdown extends Sprite
	{
		private var currentDate:Date							= new Date();
		
		private var buildCountdown:Boolean;
		private var targetDate:Date;
		private var textFormat:TextFormat;
		private var visualTargets:Object;
		
		private var _decades:Number;
		private var _years:Number;
		private var _months:Number;
		private var _weeks:Number;
		private var _days:Number;
		private var _hours:Number;
		private var _mins:Number;
		private var _secs:Number;
		private var _mSecs:Number;
		
		public function Countdown(targetDate:Date, buildCountdown:Boolean=false, visualTargets:Object=null)
		{
			this.buildCountdown		= buildCountdown;
			this.targetDate 		= targetDate;
			this.visualTargets		= visualTargets;
			
			init();
		}
		
		private function init():void
		{
			if ( buildCountdown )
			{
				// build();
			}
			else
			{
				addEventListener( Event.ENTER_FRAME, applyTimes );
			}
		}
		
		private function applyTimes(e:Event):void
		{
			var diff:Number = targetDate.getTime() - currentDate.getTime();
			
			if ( visualTargets.hasOwnProperty( 'decades' ) )
			{
				
			}
			
			if ( visualTargets.hasOwnProperty( 'years' ) )
			{
				
			}
			
			if ( visualTargets.hasOwnProperty( 'months' ) )
			{
				
			}
			
			if ( visualTargets.hasOwnProperty( 'weeks' ) )
			{
				
			}
			
			if ( visualTargets.hasOwnProperty( 'days' ) )
			{
				_days = Math.floor( diff / 86400000 );
				
				diff -= ( _days * 86400000 );
			}
			
			if ( visualTargets.hasOwnProperty( 'hours' ) )
			{
				_hours = Math.floor( diff / 3600000 );
				
				diff -= ( _hours * 3600000 );
			}
			
			if ( visualTargets.hasOwnProperty( 'mins' ) )
			{
				_mins = Math.floor( diff / 60000 );
				
				diff -= ( _mins * 60000 );
			}
			
			if ( visualTargets.hasOwnProperty( 'secs' ) )
			{
				_secs = Math.floor( diff / 1000 );
				
				diff -= ( _secs * 1000 );
			}
			
			if ( visualTargets.hasOwnProperty( 'mSecs' ) )
			{
				
			}
			
			dispatchEvent( new CountdownEvent( CountdownEvent.TIME, 
							{ 
								diff: 		targetDate.getTime() - currentDate.getTime(),
								decades: 	_decades, 
								years: 		_years, 
								months: 	_months, 
								weeks: 		_weeks, 
								days: 		_days, 
								hours: 		_hours, 
								mins: 		_mins, 
								secs: 		_secs, 
								mSecs: 		_mSecs 
							}
						) 
					);
			
			currentDate = new Date();
		}
	}
}