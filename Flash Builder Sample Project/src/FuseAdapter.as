package
{
	import com.fuse.ane.AirFuseAPI;
	import com.fuse.ane.AirFuseAPIEvent;
	import flash.events.StatusEvent;
	import flash.system.Capabilities;	
	
	public class FuseAdapter
	{
		public static var callNumber:int;
		private static var _instance:FuseAdapter;
		private static var fuse:AirFuseAPI;
		private static var ad_available:Object;
		private static var adCloseCallback:Function;
		private static var InAppPurchaseCallback:Function;
		
		public function FuseAdapter()
		{
			if (!_instance)
			{
				fuse = new AirFuseAPI();
				ad_available = new Object();
				adCloseCallback = null;
				
				fuse.addListener(StatusEvent.STATUS, onStatus);
				
				_instance = this;
			}
			else
			{
				throw Error( 'This is a singleton, use getInstance(), do not call the constructor directly.');
			}
		}
		
		public static function getInstance() : FuseAdapter
		{
			return _instance ? _instance : new FuseAdapter();
		}
		
		public static function initialise():void 
		{
			// init the api
			try 
			{
				getInstance();
				
				var os = Capabilities.manufacturer;
				var is_ios:Boolean = os.indexOf('iOS') > -1;
				var is_android:Boolean = os.indexOf('Android') > -1;
				
				// Start a session
				if (is_android)
				{
					Main.debugLog('Fuse: initializing Android');
					fuse.startSession('<YOUR API KEY>');  // android - UPDATE THIS WITH YOUR API KEY
				}
				else if (is_ios)
				{
					Main.debugLog('Fuse: initializing iOS');
					// ios - UPDATE THIS WITH YOUR API KEY
					fuse.startSession('<YOUR API KEY>');
				}
				else
				{
					Main.debugLog('Fuse: Not initializing - platform not found.  All subsequent Fuse calls will not work');
					fuse = null;
				}
			} 
			catch (err:Error) 
			{
				Main.debugLog('init_fuse: ' + err.errorID + ":" + err.message);
			}
		}
		private static var appIsLockedForAds:Boolean;
		
		public static function showAd(_callback:Function=null, _zone_id : String = "") : void
		{
			adCloseCallback = _callback;
			//fuse.checkAdAvailable();
			
			if (fuse != null)
			{
				try
				{
					fuse.showAd(signalAdClose, _zone_id);
				}
				catch (ex:*) 
				{
					signalAdClose();
				}
			}
			else
			{
				signalAdClose();
			}
		}
		
		private static function signalAdClose() : void
		{
			if (adCloseCallback != null)
			{
				var c:Function = adCloseCallback;
				adCloseCallback = null;	// free up references for garbage collection and prevent double calls
				c();
			}
		}
		
		public static function checkAdAvailable(_delegate:Function=null, _zone_id : String = "") : void
		{
			//trace(_delegate);
			
			if (fuse != null)
			{
				try 
				{
					fuse.checkAdAvailable(_delegate, _zone_id);
				}
				catch (ex:*) 
				{
					
				}
			}
		}
		
		public static function preloadAdForZone(_zone_id : String = "") : void
		{
			if (fuse != null)
			{
				try 
				{
					fuse.preloadAdForZone(_zone_id);
				}
				catch (ex:*) 
				{
					
				}
			}
		}
		
		public static function displayNotifications() : void
		{
			if (fuse != null)
			{
				try 
				{
					fuse.displayNotifications();
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function registerLevel(_level:int) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.registerLevel(_level);
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function registerGender(_gender:int) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.registerGender(_gender);
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function registerInAppPurchase(_callback:Function, _state:String, _price:String, _currency:String, _product_id:String, _transaction_id:String, _validation_payload:String=null) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.registerInAppPurchase(_callback, _state, _price, _currency, _product_id, _transaction_id, _validation_payload);
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function registerCurrency(_type:int, _balance:int) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.registerCurrency(_type, _balance);
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function registerEvent(_eventName:String, _p1:*=null, _p2:*=null, _p3:*=null) : int
		{
			if (fuse != null)
			{
				try
				{
					return fuse.registerEvent(_eventName, _p1, _p2, _p3);				
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
			
			return -1;
		}
		
		public static function displayMoreGames() : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.displayMoreGames();
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
		}
		
		public static function getGameConfigurationValue(_key:String) : String
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getGameConfigurationValue(_key);;
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function gamesPlayed() : int
		{
			if (fuse != null)
			{
				try
				{
					return fuse.gamesPlayed();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return 1;
		}
		
		public static function userPushNotification(fuseId : String, msg : String) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.userPushNotification(fuseId, msg);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function friendsPushNotification(msg : String) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.friendsPushNotification(msg);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function facebookLogin(facebookId : String, name : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.facebookLogin(facebookId, name, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function facebookLoginWithToken(facebookId : String, name : String, accessToken : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.facebookLoginWithToken(facebookId, name, accessToken, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function twitterLogin(twitterId : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.twitterLogin(twitterId, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function twitterLoginWithAlias(twitterId : String, alias : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.twitterLoginWithAlias(twitterId, alias, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function deviceLogin(alias : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.deviceLogin(alias, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function fuseLogin(fuseId : String, alias : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.fuseLogin(fuseId, alias, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function googlePlayLogin(alias : String, accessToken : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.googlePlayLogin(alias, accessToken, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function getOriginalAccountId() : String
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getOriginalAccountId();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function getOriginalAccountAlias() : String
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getOriginalAccountAlias();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function getOriginalAccountType() : int
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getOriginalAccountType();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return 0;
		}
		
		public static function getFuseID() : String
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getFuseID();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function updateFriendsListFromServer(callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.updateFriendsListFromServer(callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function getFriendsList() : Array
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getFriendsList();
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function addFriend(fuseId : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.addFriend(fuseId, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function removeFriend(fuseId : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.removeFriend(fuseId, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function acceptFriend(fuseId : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.acceptFriend(fuseId, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function rejectFriend(fuseId : String, callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.rejectFriend(fuseId, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function getMailListFromServer(callback : Function) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.getMailListFromServer(callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function getMailList(fuseId : String) : Array
		{
			if (fuse != null)
			{
				try
				{
					return fuse.getMailList(fuseId);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return null;
		}
		
		public static function setMailAsReceived(mailId : int) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.setMailAsReceived(mailId);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
		}
		
		public static function sendMail(fuseId : String, msg : String, callback : Function) : int
		{
			if (fuse != null)
			{
				try
				{
					return sendMail(fuseId, msg, callback);
				}
				catch (ex:*)
				{
					// ignore
				}
			}
			
			return 0;
		}
		
		
		public static function log(str:String) : void
		{
			if (fuse != null)
			{
				try
				{
					fuse.log(str);
					
					return;
				}
				catch (ex:*) 
				{
					// ignore
				}
			}
			
			return;
		}
		
		public function onStatus( event : StatusEvent ) : void
		{
			var e:AirFuseAPIEvent;
			
			switch (event.code)
			{				
				case AirFuseAPIEvent.APP_CONFIGURATION_RECEIVED:
					// App configuration has been updated by the server
					
					try
					{
						//var tmp:String = fuse.getGameConfigurationValue('sample_value');
						
					}
					catch (ex:*)
					{
					}
					
					break;
				
				case AirFuseAPIEvent.DID_CLOSE_INTERSTITIAL:
					signalAdClose();
					//fuse.checkAdAvailable();  // recheck if the next ad is available
					break;
				
				case AirFuseAPIEvent.SESSION_START:
					Main.debugLog('Session start received');
					//fuse.checkAdAvailable();        // prime the pump to see if an ad is available
					//fuse.displayNotifications();    // display notifications if you'd like on start session
					break;		
				
				case AirFuseAPIEvent.DID_CLOSE_MOREGAMES:
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_ERROR:
					Main.debugLog('Fuse Ad error');
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_AVAILABLE:
					Main.debugLog('Fuse Ad available');
					break;
				
				case AirFuseAPIEvent.AD_AVAILABILITY_NOT_AVAILABLE:
					Main.debugLog('Fuse Ad not available');
					break;
				case AirFuseAPIEvent.INAPP_PURCHASE_RESPONSE:
					break;
				
				case AirFuseAPIEvent.AD_REWARD_COMPLETE:
					Main.debugLog("REWARD GET");
					break;
				case AirFuseAPIEvent.ACCOUNT_LOGIN_COMPLETE:
					Main.debugLog('Account login complete');
					break;
				case AirFuseAPIEvent.FRIEND_ACCEPTED:
					Main.debugLog('Friend accepted');
					break;
				case AirFuseAPIEvent.FRIEND_ADDED:
					Main.debugLog('Friend added');
					break;
				case AirFuseAPIEvent.FRIEND_REJECTED:
					Main.debugLog('Friend rejected');
					break;
				case AirFuseAPIEvent.FRIEND_REMOVED:
					Main.debugLog('Friend removed');
					break;
				case AirFuseAPIEvent.FRIENDS_LIST_ERROR:
					Main.debugLog('Friend list error');
					break;
				case AirFuseAPIEvent.FRIENDS_LIST_UPDATED:
					Main.debugLog('Friend list updated');
					break;
				case AirFuseAPIEvent.MAIL_LIST_RECEIVED:
					Main.debugLog('Mail list recieved');
					break;
				case AirFuseAPIEvent.MAIL_LIST_ERROR:
					Main.debugLog('Mail list error');
					break;
				case AirFuseAPIEvent.MAIL_ACKNOWLEDGED:
					Main.debugLog('Mail acknowledged');
					break;
				case AirFuseAPIEvent.MAIL_ERROR:
					Main.debugLog('Mail error');
					break;
				//default:
				case "LOGGING":
					trace('[Fuse] ' + event.level);
					break;
			}
		}
	}
}