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

#import "FlashRuntimeExtensions.h"
#import "FuseAPI.h"

@interface AirFuseAPI : NSObject <UIApplicationDelegate, FuseDelegate>

+ (AirFuseAPI *)sharedInstance;

@end

@interface AirFuseAPIAdDelegate : NSObject <FuseAdDelegate>

+ (AirFuseAPIAdDelegate *)sharedInstance;

@end

@interface AirFuseAPIMoreGamesDelegate : NSObject <FuseAdDelegate>

+ (AirFuseAPIMoreGamesDelegate *)sharedInstance;

@end


// C interface

DEFINE_ANE_FUNCTION(FuseStartSession);
DEFINE_ANE_FUNCTION(FuseShowInterstitial);
DEFINE_ANE_FUNCTION(FuseCheckAdAvailable);
DEFINE_ANE_FUNCTION(FuseDisplayNotifications);
DEFINE_ANE_FUNCTION(FuseRegisterLevel);
DEFINE_ANE_FUNCTION(FuseRegisterCurrency);
DEFINE_ANE_FUNCTION(FuseRegisterEvent);
DEFINE_ANE_FUNCTION(FuseDisplayMoreGames);
DEFINE_ANE_FUNCTION(FuseGetGameConfigurationValue);
DEFINE_ANE_FUNCTION(FuseGamesPlayed);
DEFINE_ANE_FUNCTION(FuseLog);
DEFINE_ANE_FUNCTION(FuseRegisterGender);
DEFINE_ANE_FUNCTION(FuseRegisterInAppPurchase);

void didRegisterForRemoteNotificationsWithDeviceToken(id self, SEL _cmd, UIApplication* application, NSData* deviceToken);
void didFailToRegisterForRemoteNotificationsWithError(id self, SEL _cmd, UIApplication* application, NSError* error);
void didReceiveRemoteNotification(id self, SEL _cmd, UIApplication* application,NSDictionary *userInfo);


// ANE setup

/* AirFuseAPIExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
*/
void AirFuseAPIExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

/* AirFuseAPIExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
*/
void AirFuseAPIExtFinalizer(void* extData);

/* AirFuseAPIContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
*/
void AirFuseAPIContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

/* AirFuseAPIContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls AirFuseAPIContextFinalizer().
*/
void AirFuseAPIContextFinalizer(FREContext ctx);


