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
	import flash.events.Event;
	
	public class AirFuseAPIEvent extends Event
	{
		public static const SESSION_START:String = "SessionStartReceived";
		public static const DID_CLOSE_INTERSTITIAL:String = "DidCloseInterstitial";
		public static const DID_CLOSE_MOREGAMES:String = "DidCloseMoreGames";
		public static const APP_CONFIGURATION_RECEIVED:String = "AppConfigurationReceived";
		public static const AD_AVAILABILITY_ERROR:String = "AdAvailabilityRequestError";
		public static const AD_AVAILABILITY_AVAILABLE:String = "AdAvailabilityRequestAdAvialable";
		public static const AD_AVAILABILITY_NOT_AVAILABLE:String = "AdAvailabilityRequestAdNotAvialable";
		
		/** Name of the location related to this event. */
		public var location:String;
		
		public function AirFuseAPIEvent(type:String, location:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.location = location;
		}
	}
}