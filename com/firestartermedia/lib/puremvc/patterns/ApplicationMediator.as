package com.firestartermedia.lib.puremvc.patterns
{
	import com.firestartermedia.lib.as3.utils.ArrayUtil;
	
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		protected var classPath:String							= 'com.firestartermedia.view.';
		protected var excludedMediators:Array					= [ ];
		protected var tabbedMediators:Array						= [ ];
		protected var viewNamingHide:String						= 'Hide';
		protected var viewNamingMediator:String					= 'Mediator';
		protected var viewNamingShow:String						= 'Show';
		
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
				
				if ( !m )
				{
					sendNotification( 'ApplicationFacadeFault', 'Well it looks like ' + mediator.NAME + ' hasn\'t loaded correctly' );
					
					return;
				}
				
				try
				{
					view.addChild( m.getViewComponent() );
				}
				catch (e:*)
				{
					sendNotification( 'ApplicationFacadeFault', 'Failed to add ' + mediator.NAME + '\'s view' );
				}
				
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
				
				if ( !m )
				{
					sendNotification( 'ApplicationFacadeFault', 'Well it looks like ' + mediator.NAME + ' hasn\'t loaded correctly' );
					
					return;
				}
				
				try
				{
					view.removeChild( m.getViewComponent() );
				}
				catch (e:*)
				{
					sendNotification( 'ApplicationFacadeFault', 'Failed to remove ' + mediator.NAME + '\'s view' );
				}
				
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
			var data:Object		= notification.getBody();
			var mediator:String	= name.replace( viewNamingHide, '' ).replace( viewNamingShow, '' ) + viewNamingMediator;
			
			if ( name.indexOf( viewNamingHide ) !== -1 )
			{
				removeMediator( mediator );
			}
			else
			{
				addMediator( mediator, data );
			}
		}
		
		protected function mediator(name:String):*
		{
			return facade.retrieveMediator( name );
		}
	}
}