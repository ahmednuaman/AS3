package com.firestartermedia.lib.puremvc.patterns
{
	import com.firestartermedia.lib.as3.utils.ArrayUtil;
	
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		protected var excludedMediators:Array					= [ ];
		protected var tabbedMediators:Array						= [ ];
		protected var viewNamingHide:String						= 'Hide';
		protected var viewNamingMediator:String					= 'Mediator';
		protected var viewNamingShow:String						= 'Show';
		
		protected var classPath:String;
		protected var currentMediator:String;
		
		public function ApplicationMediator(name:String=null, viewComponent:Object=null)
		{
			super( name, viewComponent );
		}
		
		protected function addMediator(mediator:Object, data:Object=null):void
		{
			var m:Object;
			
			if ( !mediator.hasOwnProperty( 'NAME' ) )
			{
				mediator		= getDefinitionByName( classPath + mediator.toString().split( '-' )[ 0 ] ) as Class
			}
			
			if ( !facade.hasMediator( mediator.NAME ) )
			{
				removeOtherMediators( mediator.NAME );				
				
				facade.registerMediator( new mediator() );
				
				m				= facade.retrieveMediator( mediator.NAME );
				
				view.addChild( m.getViewComponent() );
				
				if ( m.hasOwnProperty( 'data' ) )
				{
					m.data		= data;
				}
				
				currentMediator	= mediator.NAME;
			}
		}
		
		protected function removeMediator(mediator:Object):void
		{
			var m:Object;
			
			if ( !mediator.hasOwnProperty( 'NAME' ) )
			{
				mediator		= getDefinitionByName( classPath + mediator.toString().split( '-' )[ 0 ] ) as Class
			}
			
			if ( facade.hasMediator( mediator.NAME ) )
			{	
				m			= facade.retrieveMediator( mediator.NAME );
			
				view.removeChild( m.getViewComponent() );
				
				facade.removeMediator( mediator.NAME );
			}
		}
		
		protected function removeOtherMediators(mediator:String=''):void
		{
			if ( ( ArrayUtil.search( excludedMediators, mediator ) === -1 && ArrayUtil.search( tabbedMediators, mediator ) !== -1 ) || mediator === '' )
			{
				for each ( var m:String in tabbedMediators )
				{
					if ( m !== mediator )
					{
						removeMediator( getDefinitionByName( classPath + m ) as Class );
					}
				}
			}
		}
		
		protected function handleSectionChange(notification:INotification):void
		{
			var name:String		= notification.getName();
			var mediator:String	= name.replace( viewNamingHide, '' ).replace( viewNamingShow, '' ) + viewNamingMediator;
			
			if ( name.indexOf( viewNamingHide ) !== -1 )
			{
				removeMediator( mediator );
			}
			else
			{
				addMediator( mediator );
			}
		}
		
		protected function mediator(name:String):*
		{
			return facade.retrieveMediator( name );
		}
	}
}