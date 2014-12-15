package
{
	import flash.display.MovieClip;
	import flash.display.Screen;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import fl.controls.Button;
	
	public class Main extends MovieClip
	{
		private static var mainButtons:Array = new Array();
		private static var pushButtons:Array = new Array();
		private static var socialButtons:Array = new Array();
		private static var getterButtons:Array = new Array();
		private static var friendsButtons:Array = new Array();
		private static var mailButtons:Array = new Array();
		private static var debug_clip:TextField;
		private static var debug_text:Array;
		private static var ad_only:Boolean = false;
		
		private static var adZoneLabelText:TextField = new TextField();
		private static var adZoneInput:TextField = new TextField();
		
		private static var messageLabelText:TextField = new TextField();
		private static var fuseIdLabelText:TextField = new TextField();
		private static var idLabelText:TextField = new TextField();
		private static var nameLabelText:TextField = new TextField();
		private static var tokenLabelText:TextField = new TextField();
		private static var friendsIdLabelText:TextField = new TextField();
		private static var mailIdLabelText:TextField = new TextField();
		private static var mailMsgLabelText:TextField = new TextField();
		
		
		private static var messageInput:TextField = new TextField();
		private static var fuseIdInput:TextField = new TextField();
		private static var socialIdInput:TextField = new TextField();
		private static var nameInput:TextField = new TextField();
		private static var tokenInput:TextField = new TextField();
		private static var friendsIdInput:TextField = new TextField();
		private static var mailIdInput:TextField = new TextField();
		private static var mailInput:TextField = new TextField();
		
		private static var adZoneText:String = "";
		private static var ffReg:TextFormat;
		
		[Embed(source="/Library/Fonts/Tahoma.ttf", fontName="Tahoma", embedAsCFF="false")]
		private static var FC1:Class;
		
		var verticalScale:Number;
		
		public function Main()
		{
			if(Screen.mainScreen.bounds.height > 768)
			{
				verticalScale = Screen.mainScreen.bounds.height / 820;  
			}
			else
			{
				verticalScale = 600 / Screen.mainScreen.bounds.height ;  
			}
			stage.align = StageAlign.TOP;
			verticalScale = 1;
			/* Add text fields plus text format */
			
			var ffHeader:TextFormat = new TextFormat();
			ffHeader.font = "Tahoma";
			ffHeader.size = 32 * verticalScale;
			
			var ffSubHeader:TextFormat = new TextFormat();
			ffSubHeader.font = "Tahoma";
			ffSubHeader.size = 20 * verticalScale ;	
			
			ffReg = new TextFormat();
			ffReg.font = "Tahoma";
			ffReg.size = 14 * verticalScale ;	
			
			//Debug Area
			debug_clip = new TextField();
			stage.addChild(debug_clip);
			debug_clip.embedFonts = true;
			debug_clip.defaultTextFormat = ffReg;
			debug_clip.antiAliasType=flash.text.AntiAliasType.ADVANCED;
			debug_clip.x = verticalScale *175 ;	
			debug_clip.y = verticalScale * 45;	
			debug_clip.width = verticalScale *  300 ;
			debug_clip.height = verticalScale * 550 ;
			debug_clip.border = true;
			
			var dc_label:TextField = new TextField();
			stage.addChild(dc_label);
			dc_label.embedFonts = true;
			dc_label.defaultTextFormat = ffSubHeader;
			dc_label.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
			dc_label.x = verticalScale *395 ;
			dc_label.y = verticalScale * 5 * verticalScale ;
			dc_label.height = verticalScale * 30;
			dc_label.text = "Debug Log:";
			
			FuseAdapter.initialise();
			
			var t:TextField = new TextField();
			stage.addChild(t);	
			t.antiAliasType=flash.text.AntiAliasType.ADVANCED;
			t.embedFonts = true;
			t.defaultTextFormat = ffHeader;
			t.x = verticalScale *5 ;
			t.y = verticalScale * 0 * verticalScale ;
			t.width = verticalScale *  500 ;
			t.height = verticalScale * 35 ;
			t.text = "Fuse AIR Sample App";
			
			if( !ad_only )
			{
				stage.addChild(adZoneLabelText);	
				adZoneLabelText.embedFonts = true;
				adZoneLabelText.defaultTextFormat = ffSubHeader;	
				adZoneLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				adZoneLabelText.x = verticalScale *5 ;
				adZoneLabelText.y = verticalScale * 595 ;
				adZoneLabelText.width = verticalScale *  350 ;
				adZoneLabelText.text = "OPTIONAL: Enter an ad zone name:";
				
				adZoneInput.type = TextFieldType.INPUT;
				adZoneInput.background = true;	
				adZoneLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				adZoneInput.text = adZoneText;
				adZoneInput.width = verticalScale *  400 ;
				adZoneInput.x = verticalScale *5 ;
				adZoneInput.y = verticalScale * 620 ;
				adZoneInput.height = verticalScale * 30 ;
				adZoneInput.border = true;
				adZoneInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(adZoneInput);
			}
			
			if (!ad_only)
			{
				addButton(mainButtons, "Check Ad Available", checkAdAvailableClickHandler);
				addButton(mainButtons, "Preload Ad", preloadClickHandler);
			}
			
			addButton(mainButtons, "Show Ad", showAdClickHandler);
			
			if (!ad_only)
			{
				addButton(mainButtons, "Display Notifications", displayNotificationsClickHandler);
				addButton(mainButtons, "More Games", moreGamesClickHandler);
				addButton(mainButtons, "In-App Purchase", inAppPurchaseClickHandler);
				
				addButton(mainButtons, "Push Functions", pushButtonsHandler);
				addButton(mainButtons, "Social Functions", socialButtonsHandler);
				addButton(mainButtons, "Getter Functions", getterButtonsHandler);
				addButton(mainButtons, "Friends Functions", friendsButtonsHandler);
				addButton(mainButtons, "Mail Functions", mailButtonsHandler);
			}
			
			//push notifications
			if(!ad_only)
			{
				stage.addChild(messageLabelText);	
				messageLabelText.embedFonts = true;
				messageLabelText.defaultTextFormat = ffSubHeader;	
				messageLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				messageLabelText.x = verticalScale *5 ;
				messageLabelText.y = verticalScale * 595 ;
				messageLabelText.width = verticalScale *  350 ;
				messageLabelText.text = "Message:";
				
				messageInput.type = TextFieldType.INPUT;
				messageInput.background = true;	
				messageInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				messageInput.text = adZoneText;
				messageInput.width = verticalScale *  400 ;
				messageInput.x = verticalScale *5 ;
				messageInput.y = verticalScale * 625 ;
				messageInput.height = verticalScale * 30 ;
				messageInput.border = true;
				messageInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(messageInput);
				
				
				stage.addChild(fuseIdLabelText);	
				fuseIdLabelText.embedFonts = true;
				fuseIdLabelText.defaultTextFormat = ffSubHeader;	
				fuseIdLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				fuseIdLabelText.x = verticalScale *5 
				fuseIdLabelText.y = verticalScale * 655 ;
				fuseIdLabelText.width = verticalScale *  350 ;
				fuseIdLabelText.text = "FuseID:";
				
				fuseIdInput.type = TextFieldType.INPUT;
				fuseIdInput.background = true;	
				fuseIdInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				fuseIdInput.text = adZoneText;
				fuseIdInput.width = verticalScale *  400 ;
				fuseIdInput.x = verticalScale *5 ;
				fuseIdInput.y = verticalScale * 685 ;
				fuseIdInput.height = verticalScale * 30 ;
				fuseIdInput.border = true;
				fuseIdInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				addChild(fuseIdInput);
				
				addButton(pushButtons, "User Push Notification", userPushNotificationHandler);
				addButton(pushButtons, "Friends Push Notification", friendsPushNotificationHandler);
				addButton(pushButtons, "BACK", mainButtonsHandler);
			}
			
			//social
			if(!ad_only)
			{
				stage.addChild(idLabelText);	
				idLabelText.embedFonts = true;
				idLabelText.defaultTextFormat = ffSubHeader;	
				idLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				idLabelText.x = verticalScale *5 ;
				idLabelText.y = verticalScale * 595 ;
				idLabelText.width = verticalScale *  400 ;
				idLabelText.text = "ID:";
				
				socialIdInput.type = TextFieldType.INPUT;
				socialIdInput.background = true;	
				socialIdInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				socialIdInput.text = adZoneText;
				socialIdInput.width = verticalScale *  400 ;
				socialIdInput.x = verticalScale *5 ;
				socialIdInput.y = verticalScale * 625 ;
				socialIdInput.height = verticalScale * 30 ;
				socialIdInput.border = true;
				socialIdInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(socialIdInput);
				
				
				stage.addChild(nameLabelText);	
				nameLabelText.embedFonts = true;
				nameLabelText.defaultTextFormat = ffSubHeader;	
				nameLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				nameLabelText.x = verticalScale *5 ;
				nameLabelText.y = verticalScale * 655 ;
				nameLabelText.width = verticalScale *  400 ;
				nameLabelText.text = "Name/Alias:";
				
				nameInput.type = TextFieldType.INPUT;
				nameInput.background = true;	
				nameInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				nameInput.text = adZoneText;
				nameInput.width = verticalScale *  400 ;
				nameInput.x = verticalScale *5 ;
				nameInput.y = verticalScale * 695 ;
				nameInput.height = verticalScale * 30 ;
				nameInput.border = true;
				nameInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(nameInput);
				
				
				stage.addChild(tokenLabelText);	
				tokenLabelText.embedFonts = true;
				tokenLabelText.defaultTextFormat = ffSubHeader;	
				tokenLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				tokenLabelText.x = verticalScale *5 ;
				tokenLabelText.y = verticalScale * 725 ;
				tokenLabelText.width = verticalScale *  400 ;
				tokenLabelText.text = "Access Token:";
				
				tokenInput.type = TextFieldType.INPUT;
				tokenInput.background = true;	
				tokenInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				tokenInput.text = adZoneText;
				tokenInput.width = verticalScale *  400 ;
				tokenInput.x = verticalScale *5 ;
				tokenInput.y = verticalScale * 755 ;
				tokenInput.height = verticalScale * 30 ;
				tokenInput.border = true;
				tokenInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(tokenInput);
				
				addButton(socialButtons, "FB: id, name, (token)", facebookLoginHandler);
				addButton(socialButtons, "Twttr: id, (alias)", twitterLoginHandler);
				addButton(socialButtons, "Device: alias", deviceLoginHandler);
				addButton(socialButtons, "Fuse: id, alias", fuseLoginHandler);
				addButton(socialButtons, "Google: alias, token", googlePlayLoginHandler);
				addButton(socialButtons, "BACK", mainButtonsHandler);
			}
			
			//getters
			if(!ad_only)
			{
				addButton(getterButtons, "Get Account Id", getOriginalAccountIdHandler);
				addButton(getterButtons, "Get Account Alias", getOriginalAccountAliasHandler);
				addButton(getterButtons, "Get Account Type", getOriginalAccountTypeHandler);
				addButton(getterButtons, "Get Fuse ID", getFuseIDHandler);
				addButton(getterButtons, "BACK", mainButtonsHandler);
			}
			
			//friends
			if(!ad_only)
			{
				stage.addChild(friendsIdLabelText);	
				friendsIdLabelText.embedFonts = true;
				friendsIdLabelText.defaultTextFormat = ffSubHeader;	
				friendsIdLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				friendsIdLabelText.x = verticalScale *5 ;
				friendsIdLabelText.y = verticalScale * 595 ;
				friendsIdLabelText.width = verticalScale *  400 ;
				friendsIdLabelText.text = "Friends Fuse ID:";
				
				friendsIdInput.type = TextFieldType.INPUT;
				friendsIdInput.background = true;	
				friendsIdInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				friendsIdInput.text = adZoneText;
				friendsIdInput.width = verticalScale *  400 ;
				friendsIdInput.x = verticalScale *5 ;
				friendsIdInput.y = verticalScale * 625 ;
				friendsIdInput.height = verticalScale * 30 ;
				friendsIdInput.border = true;
				friendsIdInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(friendsIdInput);
				
				addButton(friendsButtons, "Update Friends List From Server", updateFriendsListFromServerHandler);
				addButton(friendsButtons, "Get Friends List", getFriendsListHandler);
				addButton(friendsButtons, "Add Friend", addFriendHandler);
				addButton(friendsButtons, "Remove Friend", removeFriendHandler);
				addButton(friendsButtons, "Accept Friend", acceptFriendHandler);
				addButton(friendsButtons, "Reject Friend", rejectFriendHandler);
				addButton(friendsButtons, "BACK", mainButtonsHandler);
			}
			
			//mail
			if(!ad_only)
			{
				stage.addChild(mailIdLabelText);	
				mailIdLabelText.embedFonts = true;
				mailIdLabelText.defaultTextFormat = ffSubHeader;	
				mailIdLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				mailIdLabelText.x = verticalScale *5 ;
				mailIdLabelText.y = verticalScale * 595 ;
				mailIdLabelText.width = verticalScale *  400 ;
				mailIdLabelText.text = "Fuse ID:";
				
				mailIdInput.type = TextFieldType.INPUT;
				mailIdInput.background = true;	
				mailIdInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				mailIdInput.text = adZoneText;
				mailIdInput.width = verticalScale *  400 ;
				mailIdInput.x = verticalScale *5 ;
				mailIdInput.y = verticalScale * 625 ;
				mailIdInput.height = verticalScale * 30 ;
				mailIdInput.border = true;
				mailIdInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(mailIdInput);
				
				
				stage.addChild(mailMsgLabelText);	
				mailMsgLabelText.embedFonts = true;
				mailMsgLabelText.defaultTextFormat = ffSubHeader;	
				mailMsgLabelText.antiAliasType=flash.text.AntiAliasType.ADVANCED;
				mailMsgLabelText.x = verticalScale *5 ;
				mailMsgLabelText.y = verticalScale * 655 ;
				mailMsgLabelText.width = verticalScale *  400 ;
				mailMsgLabelText.text = "Mail Msg:";
				
				mailInput.type = TextFieldType.INPUT;
				mailInput.background = true;	
				mailInput.antiAliasType=flash.text.AntiAliasType.ADVANCED;	
				mailInput.text = adZoneText;
				mailInput.width = verticalScale *  400 ;
				mailInput.x = verticalScale *5 ;
				mailInput.y = verticalScale * 695 ;
				mailInput.height = verticalScale * 30 ;
				mailInput.border = true;
				mailInput.addEventListener(TextEvent.TEXT_INPUT, textInputCapture); 
				stage.addChild(mailInput);
				
				addButton(mailButtons, "Get Mail List From Server", getMailListFromServerHandler);
				addButton(mailButtons, "Get Mail List", getMailListHandler);
				addButton(mailButtons, "Send Mail", sendMailHandler);
				addButton(mailButtons, "BACK", mainButtonsHandler);
			}
			
			mainButtonsHandler(null);
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
		}
		
		public function textInputCapture(event:TextEvent):void 
		{
			debugLog('Recieved Text imput:' + adZoneInput.text);
			debugLog('Recieved Text imput:' + event.text);
			
			adZoneText = adZoneInput.text;
		}
		
		private function addButton(_array:Array, _label:String, _callback:Function):void 
		{
			var i:int = _array.length;
			
			_array[i] = new fl.controls.Button();
			_array[i].setStyle("textFormat", ffReg);
			_array[i].label = _label; 
			_array[i].toggle = true;  
			_array[i].move(5 * verticalScale, (((i + 1) * 50)+5) * verticalScale);
			_array[i].setSize(150 * verticalScale, 30 * verticalScale);
			_array[i].scaleX = 1.6 * verticalScale;
			_array[i].scaleY = 1.6 * verticalScale;
			_array[i].addEventListener(MouseEvent.CLICK, _callback);
			stage.addChild(_array[i]);
		}
		
		public static function debugLog(text:String):void 
		{
			FuseAdapter.log(text);
			trace(text);
			
			if (debug_clip != null)
			{
				if (debug_text == null) 
				{
					debug_text = [];
				}
				debug_text.push(text);
				while (debug_text.length > 10) 
				{
					debug_text.splice(0, 1);
				}
				debug_clip.text = debug_text.join("\n");
			}
		}		
		
		private function checkAdAvailableClickHandler(event:MouseEvent):void 
		{
			debugLog('checkAdAvailableClickHandler with zone: ' + adZoneInput.text);			
			
			FuseAdapter.checkAdAvailable(this.checkAdAvailableComplete, adZoneInput.text);
		}
		
		private function preloadClickHandler(event:MouseEvent):void 
		{
			debugLog('preloadClickHandler with zone: ' + adZoneInput.text);			
			
			FuseAdapter.preloadAdForZone(adZoneInput.text);
		}
		
		private function showAdClickHandler(event:MouseEvent):void 
		{
			debugLog('showAdClickHandler from zone :' + adZoneInput.text);
			FuseAdapter.showAd(this.showAdComplete, adZoneInput.text);
		}
		
		private function displayNotificationsClickHandler(event:MouseEvent):void 
		{
			debugLog('displayNotificationsClickHandler');
			FuseAdapter.displayNotifications();
		}
		
		private function moreGamesClickHandler(event:MouseEvent):void 
		{
			debugLog('moreGamesClickHandler');
			FuseAdapter.displayMoreGames();
		}
		
		private function inAppPurchaseClickHandler(event:MouseEvent):void 
		{
			debugLog('inAppPurchaseClickHandler');
			var os = Capabilities.manufacturer;
			var is_ios:Boolean = os.indexOf('iOS') > -1;
			
			var state:String;
			var product_id:String;
			var transaction_id:String;
			var price:String = '0.99';
			var currency:String = 'USD';
			
			if (is_ios)
			{
				// ios
				var receipt:String;
				
				state = '1'; // conforms to enum SKPaymentTransactionState: https://developer.apple.com/library/ios/documentation/StoreKit/Reference/SKPaymentTransaction_Class/Reference/Reference.html
				product_id = 'com.yourcompany.product.id.freddyfunbucks';
				transaction_id = '170000129449420';
				
				receipt = 'ewoJInNpZ25hdHVyZSIgPSAiQWlpZ0J5bGFHVmJwNHNFMjQ1NE9FWUZuQTNmRHNjNjFnRWJJMDBnWGNUK2pDSWErWmtLekw4NTk5Wkw3L3NXV1pqdCt4Y29Bc3RMRTVONTJEdVlDUVlhN2Ztb085U09ha2pWbXRrTnFuT2oxWWNOZWg0eW5INHY0ZjJQMXkvZnlKRDMvQ3JYSnliMzk3WUw3VVJ4Ukd6TytSV0p4N2h6Q3ZLM3ozZlJqUDl4S0FBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NCdXA0K1BBaG0vTE1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEUwTURZd056QXdNREl5TVZvWERURTJNRFV4T0RFNE16RXpNRm93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNbVRFdUxnamltTHdSSnh5MW9FZjBlc1VORFZFSWU2d0Rzbm5hbDE0aE5CdDF2MTk1WDZuOTNZTzdnaTNvclBTdXg5RDU1NFNrTXArU2F5Zzg0bFRjMzYyVXRtWUxwV25iMzRucXlHeDlLQlZUeTVPR1Y0bGpFMU93QytvVG5STStRTFJDbWVOeE1iUFpoUzQ3VCtlWnRERWhWQjl1c2szK0pNMkNvZ2Z3bzdBZ01CQUFHamNqQndNQjBHQTFVZERnUVdCQlNKYUVlTnVxOURmNlpmTjY4RmUrSTJ1MjJzc0RBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkRZZDZPS2RndElCR0xVeWF3N1hRd3VSV0VNNk1BNEdBMVVkRHdFQi93UUVBd0lIZ0RBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWVhSlYyVTUxcnhmY3FBQWU1QzIvZkVXOEtVbDRpTzRsTXV0YTdONlh6UDFwWkl6MU5ra0N0SUl3ZXlOajVVUllISytIalJLU1U5UkxndU5sMG5rZnhxT2JpTWNrd1J1ZEtTcTY5Tkluclp5Q0Q2NlI0Szc3bmI5bE1UQUJTU1lsc0t0OG9OdGxoZ1IvMWtqU1NSUWNIa3RzRGNTaVFHS01ka1NscDRBeVhmN3ZuSFBCZTR5Q3dZVjJQcFNOMDRrYm9pSjNwQmx4c0d3Vi9abEwyNk0ydWVZSEtZQ3VYaGRxRnd4VmdtNTJoM29lSk9PdC92WTRFY1FxN2VxSG02bTAzWjliN1BSellNMktHWEhEbU9Nazd2RHBlTVZsTERQU0dZejErVTNzRHhKemViU3BiYUptVDdpbXpVS2ZnZ0VZN3h4ZjRjemZIMHlqNXdOelNHVE92UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBNExUSXdJREUxT2pVeE9qSTBJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTURnMU56VXdPRFEzT1RNaU93b0pJblZ1YVhGMVpTMXBaR1Z1ZEdsbWFXVnlJaUE5SUNKaU1XSm1aRFExTURrMU4yWTJOamszWXpobE1ERmxZMll4WkdRME5XRTNPVFF5TURWaVl6TmlJanNLQ1NKdmNtbG5hVzVoYkMxMGNtRnVjMkZqZEdsdmJpMXBaQ0lnUFNBaU1qTXdNREF3TURnME56Y3pOamcxSWpzS0NTSmlkbkp6SWlBOUlDSXhMall1TXlJN0Nna2lZWEJ3TFdsMFpXMHRhV1FpSUQwZ0lqUTFOakkzTXpNMk9DSTdDZ2tpZEhKaGJuTmhZM1JwYjI0dGFXUWlJRDBnSWpJek1EQXdNREE0TkRjM016WTROU0k3Q2draWNYVmhiblJwZEhraUlEMGdJakVpT3dvSkltOXlhV2RwYm1Gc0xYQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTURnMU56VXdPRFEzT1RNaU93b0pJblZ1YVhGMVpTMTJaVzVrYjNJdGFXUmxiblJwWm1sbGNpSWdQU0FpTWpVelFURTRPVEF0UlRReU55MDBRMEV3TFRrMlFUZ3RSREJETmpNM05EVTBNekZGSWpzS0NTSnBkR1Z0TFdsa0lpQTlJQ0kwTlRreU16WTROaklpT3dvSkluWmxjbk5wYjI0dFpYaDBaWEp1WVd3dGFXUmxiblJwWm1sbGNpSWdQU0FpTmpVMk1UQXlOekV4SWpzS0NTSndjbTlrZFdOMExXbGtJaUE5SUNKamIyMHVablZ6WlhCdmQyVnlaV1F1YW1GM2N6SXVabkpsYm5wNWNHRmphekVpT3dvSkluQjFjbU5vWVhObExXUmhkR1VpSUQwZ0lqSXdNVFF0TURndE1qQWdNakk2TlRFNk1qUWdSWFJqTDBkTlZDSTdDZ2tpYjNKcFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTSWdQU0FpTWpBeE5DMHdPQzB5TUNBeU1qbzFNVG95TkNCRmRHTXZSMDFVSWpzS0NTSmlhV1FpSUQwZ0ltTnZiUzVtZFhObGNHOTNaWEpsWkM1cVlYZHpNaUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaUzF3YzNRaUlEMGdJakl3TVRRdE1EZ3RNakFnTVRVNk5URTZNalFnUVcxbGNtbGpZUzlNYjNOZlFXNW5aV3hsY3lJN0NuMD0iOwoJInBvZCIgPSAiMjMiOwoJInNpZ25pbmctc3RhdHVzIiA9ICIwIjsKfQ==';
				
				FuseAdapter.registerInAppPurchase(this.inAppPurchaseResponse, state, price, currency, product_id, transaction_id, receipt);
			}
			else
			{
				// android
				var token:String;
				
				state = 'purchased';
				product_id = 'com.yourcompany.product.id.freddyfunbucks';
				transaction_id = '1234623462246316867';
				token = 'edtmztenfapydmhjqnzeofjg.Fi0l41h4c381xf-_oU1pqGWnvdptLtcVpT9kTbVsNkO_u6lKYQ1mwD3f-5f8-cHl1qbAe79Ae7H6T5jO7U801udVFfyz3iPs18LQC5ohDvWLnoam52DLpTM';
				
				FuseAdapter.registerInAppPurchase(this.inAppPurchaseResponse, state, price, currency, product_id, transaction_id, token);
				
				debugLog('IAP registered. State: '+state+', Price: '+price+', Currency: '+currency);
			}
		}
		
		
		private function mainButtonsHandler(event:MouseEvent) : void
		{
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = true;
			}
			
			for(i=0; i< pushButtons.length; i++)
			{
				pushButtons[i].visible = false;
			}
			
			for(i=0; i< socialButtons.length; i++)
			{
				socialButtons[i].visible = false;
			}
			
			for(i=0; i< getterButtons.length; i++)
			{
				getterButtons[i].visible = false;
			}
			
			for(i=0; i< friendsButtons.length; i++)
			{
				friendsButtons[i].visible = false;
			}
			
			for(i=0; i< mailButtons.length; i++)
			{
				mailButtons[i].visible = false;
			}
			
			
			
			adZoneLabelText.visible = true;
			adZoneInput.visible = true;
			
			messageLabelText.visible = false;
			fuseIdLabelText.visible = false;
			idLabelText.visible = false;
			nameLabelText.visible = false;
			tokenLabelText.visible = false;
			friendsIdLabelText.visible = false;
			mailIdLabelText.visible = false;
			mailMsgLabelText.visible = false;
			
			
			messageInput.visible = false;
			fuseIdInput.visible = false;
			socialIdInput.visible = false;
			nameInput.visible = false;
			tokenInput.visible = false;
			friendsIdInput.visible = false;
			mailIdInput.visible = false;
			mailInput.visible = false;
		}
		
		private function pushButtonsHandler(event:MouseEvent) : void
		{
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = false;
			}
			
			for(i=0; i< pushButtons.length; i++)
			{
				pushButtons[i].visible = true;
			}
			
			
			adZoneLabelText.visible = false;
			adZoneInput.visible = false;
			
			messageLabelText.visible = true;
			fuseIdLabelText.visible = true;
			
			
			messageInput.visible = true;
			fuseIdInput.visible = true;
		}
		
		private function socialButtonsHandler(event:MouseEvent) : void
		{
			
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = false;
			}
			
			for(i=0; i< socialButtons.length; i++)
			{
				socialButtons[i].visible = true;
			}
			
			
			adZoneLabelText.visible = false;
			adZoneInput.visible = false;
			
			idLabelText.visible = true;
			nameLabelText.visible = true;
			tokenLabelText.visible = true;
			
			
			socialIdInput.visible = true;
			nameInput.visible = true;
			tokenInput.visible = true;
		}
		
		private function getterButtonsHandler(event:MouseEvent) : void
		{
			
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = false;
			}
			
			for(i=0; i< getterButtons.length; i++)
			{
				getterButtons[i].visible = true;
			}
			
			
			
			adZoneLabelText.visible = false;
			adZoneInput.visible = false;
		}
		
		private function friendsButtonsHandler(event:MouseEvent) : void
		{
			
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = false;
			}
			
			for(i=0; i< friendsButtons.length; i++)
			{
				friendsButtons[i].visible = true;
			}
			
			
			adZoneLabelText.visible = false;
			adZoneInput.visible = false;
			
			friendsIdLabelText.visible = true;
			
			
			friendsIdInput.visible = true;
		}
		
		private function mailButtonsHandler(event:MouseEvent) : void
		{
			var i:int;
			for(i=0; i< mainButtons.length; i++)
			{
				mainButtons[i].visible = false;
			}
			
			for(i=0; i< mailButtons.length; i++)
			{
				mailButtons[i].visible = true;
			}
			
			adZoneLabelText.visible = false;
			adZoneInput.visible = false;
			
			mailIdLabelText.visible = true;
			mailMsgLabelText.visible = true;
			
			
			mailIdInput.visible = true;
			mailInput.visible = true;
		}
		
		
		private function userPushNotificationHandler(event:MouseEvent):void 
		{
			debugLog('userPushNotificationHandler');
			FuseAdapter.userPushNotification(fuseIdInput.text, messageInput.text);
		}
		
		private function friendsPushNotificationHandler(event:MouseEvent):void 
		{
			debugLog('friendsPushNotificationHandler');
			FuseAdapter.friendsPushNotification(messageInput.text);
		}
		
		
		
		
		private function facebookLoginHandler(event:MouseEvent):void 
		{
			debugLog('facebookLoginHandler');
			if(tokenInput.text == "")
			{
				FuseAdapter.facebookLogin(socialIdInput.text, nameInput.text, loginCompleted);
			}
			else
			{
				FuseAdapter.facebookLoginWithToken(socialIdInput.text, nameInput.text, tokenInput.text, loginCompleted);
			}
		}
		
		private function twitterLoginHandler(event:MouseEvent):void 
		{
			debugLog('twitterLoginHandler');
			if(nameInput.text == "")
			{
				FuseAdapter.twitterLogin(socialIdInput.text, loginCompleted);
			}
			else
			{
				FuseAdapter.twitterLoginWithAlias(socialIdInput.text, nameInput.text, loginCompleted);
			}
		}
		
		private function deviceLoginHandler(event:MouseEvent):void 
		{
			debugLog('deviceLoginHandler');
			FuseAdapter.deviceLogin(nameInput.text, loginCompleted);
		}
		
		private function fuseLoginHandler(event:MouseEvent):void 
		{
			debugLog('fuseLoginHandler');
			FuseAdapter.fuseLogin(socialIdInput.text, nameInput.text, loginCompleted);
		}
		
		private function googlePlayLoginHandler(event:MouseEvent):void 
		{
			debugLog('googlePlayLoginHandler');
			FuseAdapter.googlePlayLogin(nameInput.text, tokenInput.text, loginCompleted);
		}		
		
		
		
		private function getOriginalAccountIdHandler(event:MouseEvent):void 
		{
			debugLog('getOriginalAccountIdHandler');
			debugLog("return: " + FuseAdapter.getOriginalAccountId());
		}
		
		private function getOriginalAccountAliasHandler(event:MouseEvent):void 
		{
			debugLog('getOriginalAccountAliasHandler');
			debugLog("return: " + FuseAdapter.getOriginalAccountAlias());
		}
		
		private function getOriginalAccountTypeHandler(event:MouseEvent):void 
		{
			debugLog('getOriginalAccountTypeHandler');
			debugLog("return: " + FuseAdapter.getOriginalAccountType());
		}
		
		private function getFuseIDHandler(event:MouseEvent):void 
		{
			debugLog('getFuseIDHandler');
			debugLog("return: " + FuseAdapter.getFuseID());
		}		
		
		
		
		
		
		
		private function updateFriendsListFromServerHandler(event:MouseEvent):void 
		{
			debugLog('updateFriendsListFromServerHandler');
			FuseAdapter.updateFriendsListFromServer(friendsListCallback);
		}
		
		private function getFriendsListHandler(event:MouseEvent):void 
		{
			debugLog('getFriendsListHandler');
			friendsListCallback(FuseAdapter.getFriendsList(), 0);
		}
		
		private function addFriendHandler(event:MouseEvent):void 
		{
			debugLog('addFriendHandler');
			FuseAdapter.addFriend(friendsIdInput.text, friendAdded);
		}
		
		private function removeFriendHandler(event:MouseEvent):void 
		{
			debugLog('removeFriendHandler');
			FuseAdapter.removeFriend(friendsIdInput.text, friendRemoved);
		}
		
		private function acceptFriendHandler(event:MouseEvent):void 
		{
			debugLog('acceptFriendHandler');
			FuseAdapter.acceptFriend(friendsIdInput.text, friendAccepted);
		}		
		
		private function rejectFriendHandler(event:MouseEvent):void 
		{
			debugLog('rejectFriendHandler');
			FuseAdapter.rejectFriend(friendsIdInput.text, friendRejected);
		}	
		
		
		
		
		private function getMailListFromServerHandler(event:MouseEvent):void 
		{
			debugLog('getMailListFromServerHandler');
			FuseAdapter.getMailListFromServer(mailListCallback);
		}	
		
		private function getMailListHandler(event:MouseEvent):void 
		{
			debugLog('getMailListFromServerHandler');
			mailListCallback(FuseAdapter.getMailList(mailIdInput.text), mailIdInput.text, 0);
		}		
		
		private function sendMailHandler(event:MouseEvent):void 
		{
			debugLog('sendMailHandler');
			debugLog("return: " + FuseAdapter.sendMail(mailIdInput.text, mailInput.text, mailCallback));
		}	
		
		private function showAdComplete():void
		{
			debugLog('Ad closed');			
			// Do something with the control of the app here
		}		
		
		private function checkAdAvailableComplete(available:int, error:int):void
		{
			if (available)
			{
				debugLog('Ad Check succeeded: ' + available);
				// Ad is available
			}
			else
			{
				debugLog('Ad Check failed: ' + available + ' Error: ' + error);
				// Ad is not available
			}                
		}
		
		private function inAppPurchaseResponse(state:int, transaction_id:String):void
		{
			if (state == 1)
			{
				debugLog('In-App Purchase successfully validated! ' + state + ', tx_id = ' + transaction_id);
			}
			else if (state == -1)
			{
				debugLog('In-App Purchase no validated [no attempt made] ' + state + ', tx_id = ' + transaction_id);
			}
			else if (state == 0)
			{
				debugLog('In-App Purchase failed!' + state + ', tx_id = ' + transaction_id);
			}
			else
			{
				debugLog('In-App Purchase unknown state:' + state + ', tx_id = ' + transaction_id);
			}		
		}
		
		
		
		
		private function loginCompleted(accountType : int, accountId : String) : void
		{
			debugLog("Login completed. type: " + accountType + ", id: " + accountId);
		}	
		
		private function friendsListCallback(players : Array, error : int) : void
		{
			debugLog("Friends list callback. Error " + error);
			if(players != null)
			{
				var i:int;
				debugLog("Players:");
				debugLog("FuseId   Alias   Type   AccountId   Level   Pending");
				
				for(i = 0; i < players.length; i++)
				{
					debugLog(players[i].getFuseId() + " " + players[i].getAlias() + " " + players[i].getAccountId() + " " + players[i].getLevel() + " " + players[i].getPending());
				}
				debugLog("--------------------------------------------------")
			}
		}
		
		private function friendAdded(fuseId : String, error : int) : void
		{
			debugLog("Friend added. Error " + error + " ID: " + fuseId);
		}
		
		private function friendRemoved(fuseId : String, error : int) : void
		{
			debugLog("Friend removed. Error " + error + " ID: " + fuseId);
		}
		
		private function friendAccepted(fuseId : String, error : int) : void
		{
			debugLog("Friend accepted. Error " + error + " ID: " + fuseId);
		}
		
		private function friendRejected(fuseId : String, error : int) : void
		{
			debugLog("Friend rejected. Error " + error + " ID: " + fuseId);
		}
		
		private function mailListCallback(mailMessages : Array, fuseId : String, error : int) : void
		{
			debugLog("Mail list callback. Error " + error + " ID: " + fuseId);
			if(mailMessages != null)
			{
				var i:int;
				debugLog("Messages:");
				debugLog("FuseId   Alias   Message   Date   MessageId");
				
				for(i = 0; i < mailMessages.length; i++)
				{
					debugLog(mailMessages[i].getFuseId() + " " + mailMessages[i].getAlias() + " " + mailMessages[i].getMessage() + " " + mailMessages[i].getDate() + " " + mailMessages[i].getId());
				}
				debugLog("--------------------------------------------------")
			}
		}
		
		private function mailCallback(messageId : int, fuseId : String, requestId : int, error : int) : void
		{
			debugLog("Mail complete. Error " + error + " ID: " + fuseId + " MessageID: " + messageId);
		}
	}
}