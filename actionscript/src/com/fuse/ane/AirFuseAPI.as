/////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2013 Fuse Powered, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  	http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
/////////////////////////////////////////////////////////////////////////////

package com.fuse.ane
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	import flash.events.*;
	
	public class AirFuseAPI extends EventDispatcher
	{
		private static var _instance:AirFuseAPI;
		private static var adCloseCallback:Function;
		private static var adCheckCallback:Function;
		
		private var extCtx:ExtensionContext = null;
		
		public function AirFuseAPI()
		{
			var is_ios:Boolean = Capabilities.manufacturer.indexOf('iOS') > -1;
			var is_android:Boolean = Capabilities.manufacturer.indexOf('Android') > -1;

			if (!_instance)
			{
				adCloseCallback = null;
				adCheckCallback = null;
				
				extCtx = ExtensionContext.createExtensionContext("com.fuse.AirFuseAPI", null);
				
				if (extCtx != null)
				{
					extCtx.addEventListener(StatusEvent.STATUS, onStatus);
				} 
				else
				{
					trace('[Fuse] Error - Extension Context is null.');
				}
				
				if (is_android)
				{
					this.addEventListener(Event.DEACTIVATE, deactivate);
					this.addEventListener(Event.ACTIVATE, activate);				
				}
				
				_instance = this;
			}
			else
			{
				throw Error( 'This is a singleton, use getInstance(), do not call the constructor directly.');
			}
		}
		
		public static function getInstance() : AirFuseAPI
		{
			return _instance ? _instance : new AirFuseAPI();
		}
		
		
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 							   			PUBLIC API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		/**
		 * Notify the beginning of a user session
		 * 
		 * @param _game_id String: Your Fuse application ID.
		 */
		public function startSession( _game_id : String ) : void
		{
			extCtx.call('startSession', _game_id);
		}
		
		// Ads
		public function showAd(_delegate:Function) : void
		{
			adCloseCallback = _delegate;
			
			extCtx.call('showAd');
		}
		
		public function checkAdAvailable(_delegate:Function=null) : void
		{
			adCheckCallback = _delegate;
			
			extCtx.call('checkAdAvailable');
		}
		
		// Notifications		
		public function displayNotifications() : void
		{
			extCtx.call('displayNotifications');
		}
		
		// Level specific variables
		public function registerLevel(_level:int) : void
		{
			extCtx.call('registerLevel', _level);
		}
		
		public function registerCurrency(_type:int, _balance:int) : void
		{
			extCtx.call('registerCurrency', _type, _balance);
		}
		
		// Analytics
		public function registerEvent(_eventName:String, _p1:*=null, _p2:*=null, _p3:*=null) : int
		{
			var _parameters:Object = null;
			var _variables:Object = null;
			
			if (_p1 != null)
			{
				if (_p1 is Object && !(_p1 is String))
				{
					_parameters = _p1;
					
					if (_p2 != null)
					{
						if (_p2 is Object)
						{
							_variables = _p2;
						}
					}
				}
				else if (_p1 is String)
				{
					// Implies _p1 is param_name
					
					if (_p2 != null && _p2 is String)
					{
						//  Implies _p2 is param_value
						_parameters = new Object();
						
						_parameters[_p1] = _p2;
						
						_variables = _p3;
					}
				}
			}
			
			var returnValue:int = -1;			
			
			if (!checkLength(_eventName))
			{
				trace("[Fuse Warning]", "event name too long (>255 characters)", _eventName);
				return -1;
			}

			var parameterKeys:Array = [];
			var parameterValues:Array = [];
			var variableKeys:Array = [];
			var variableValues:Array = [];
			
			if (_parameters != null)
			{
				var value:String;
				
				for (var key:String in _parameters)
				{
					value = _parameters[key].toString();
					
					if (checkLength(value) && checkLength(key))
					{
						parameterKeys.push(key);
						parameterValues.push(value);
					} 
					else
					{
						if (!checkLength(value))
						{
							trace("[Fuse Warning]", "parameter value too long (>255 characters)", value);
							return 2;
						}
						else if (!checkLength(key))
						{
							trace("[Fuse Warning]", "parameter key too long (>255 characters)", key);
							return 2;
						}
					}
				}
				
				if (_variables != null)
				{
					var v:Number;
					
					for (var k:String in _variables)
					{
						try
						{
							//v = _variables[k].toString();
							v = Number(_variables[k]);
							
							if (!isNumber(v))
							{
								v = 0;
							}
							
							if (v is Number || v is int)
							{
								variableKeys.push(k);
								variableValues.push(v.toString());
							} 
							else
							{
								if (!(v is Number) || !(v is int))
								{
									trace("[Fuse Warning]", "variable value is not a number", v);
									return 1;
								}
							}
						}
						catch (ex:*)
						{
							this.log("variable value is not a number: " + v);
						}
					}
					
					returnValue = extCtx.call('registerEvent', _eventName, parameterKeys, parameterValues, variableKeys, variableValues) as int;
				}
				else
				{
					returnValue = extCtx.call('registerEvent', _eventName, parameterKeys, parameterValues) as int;
				}
			} 
			else
			{
				returnValue = extCtx.call("registerEvent", _eventName) as int;
			}
			
			if (returnValue is int)
			{
				return returnValue;
			}
			
			return -1;
		}
		
		// More Games
		public function displayMoreGames() : void
		{
			extCtx.call('displayMoreGames');
		}
		
		// Debug log
		public function log(str:String) : void
		{
			extCtx.call('log', str);
		}

		// Event listeners
		public function addListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void
		{
			extCtx.addEventListener(type, listener);
		}
		
		// Application Events
		public function activate(event:Event) : void
		{
			//trace('[Fuse] resumeSession: ' + event);
			extCtx.call('resumeSession');
		}
		
		public function deactivate(event:Event) : void
		{
			//trace('[Fuse] suspendSession:' + event);
			extCtx.call('suspendSession');
		}
		
		// Dispatches an event into the event flow.
        /*public function dispatchEvent(event:Event):Boolean 
        {
            return extCtx.dispatchEvent(event);
        };
        
        // Removes a listener from the EventDispatcher object.
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
        {
            extCtx.removeEventListener(type, listener, useCapture);
        };
        
        // Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
        public function hasEventListener(type:String):Boolean 
        {
            return extCtx.hasEventListener(type);
        };
        
        // Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
        public function willTrigger(type:String):Boolean 
        {
            return extCtx.willTrigger(type);
        }*/
		
		// App Config variables
		public function getGameConfigurationValue(_key:String) : String
		{
			var value:String = extCtx.call('getGameConfigurationValue', _key) as String;
			
			if (value != null && value is String)
			{
				return value;
			}
			
			return value;
		}
		
		// Misc. functions		
		public function gamesPlayed() : int
		{
			var ret:* =  extCtx.call('gamesPlayed');
			
			var gamesPlayed:int = int(ret);
			
			if (gamesPlayed is int)
			{
				return gamesPlayed;
			}
			
			return 1;
		}
		
		private function isNumber(num:Number):Boolean
		{
			return num == num;
		}
		
		private function checkLength(value:String):Boolean
		{
			return value != null && value.length < 255;
		}
		
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 							   		EVENT LISTENERS										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		private function onStatus( event : StatusEvent ) : void
		{
			var e:AirFuseAPIEvent;
			
			//getInstance().log('AirFuseAPI onStatus Event: ' + event.code + ' Level: ' + event.level);			
			
			switch (event.code)
			{				
				case AirFuseAPIEvent.DID_CLOSE_INTERSTITIAL:
					if (adCloseCallback != null)
					{
						adCloseCallback();
					}
					
					adCloseCallback = null;
				
					e = new AirFuseAPIEvent(AirFuseAPIEvent.DID_CLOSE_INTERSTITIAL, event.level);
					break;
				
				case AirFuseAPIEvent.SESSION_START:
					e = new AirFuseAPIEvent(AirFuseAPIEvent.SESSION_START, event.level);
					break;		
				
				case AirFuseAPIEvent.DID_CLOSE_MOREGAMES:
					e = new AirFuseAPIEvent(AirFuseAPIEvent.DID_CLOSE_MOREGAMES, event.level);
					break;
				
				case AirFuseAPIEvent.APP_CONFIGURATION_RECEIVED:
					e = new AirFuseAPIEvent(AirFuseAPIEvent.APP_CONFIGURATION_RECEIVED, event.level);
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_ERROR:
					if (adCheckCallback != null)
					{
						adCheckCallback(false, event.level);
					}
					
					adCheckCallback = null;
				
					e = new AirFuseAPIEvent(AirFuseAPIEvent.AD_AVAILABILITY_ERROR, event.level);
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_AVAILABLE:
					if (adCheckCallback != null)
					{
						adCheckCallback(true, 0);
					}
					
					adCheckCallback = null;
				
					e = new AirFuseAPIEvent(AirFuseAPIEvent.AD_AVAILABILITY_AVAILABLE, event.level);
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_NOT_AVAILABLE:
					if (adCheckCallback != null)
					{
						adCheckCallback(false, 0);
					}
					
					adCheckCallback = null;
				
					e = new AirFuseAPIEvent(AirFuseAPIEvent.AD_AVAILABILITY_NOT_AVAILABLE, event.level);
					break;
				
				case "LOGGING":
					trace('[Fuse] ' + event.level);
					break;
			}
			
			if (e) dispatchEvent(e);
		}
	}
}
