package com.firestartermedia.lib.puremvc.vo
{
	public class MediatorNotificationInterestVO
	{
		public var func:Function;
		public var notification:String;
		
		public function MediatorNotificationInterestVO(notification:String, func:Function)
		{
			this.func			= func;
			this.notification	= notification;
		}
		
		public function toString():String
		{
			return 'Notification: ' + notification + '; Function: ' + func;
		}
	}
}