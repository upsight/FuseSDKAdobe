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

#import "AirFuseAPI.h"
#import <UIKit/UIApplication.h>
#import <objc/runtime.h>

FREContext AirFuseAPICtx = nil;


#pragma mark - AirFuseAPI

@implementation AirFuseAPI

static AirFuseAPI *sharedInstance = nil;

+ (AirFuseAPI *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{}

#pragma mark FuseDelegate Functions
-(void) sessionStartReceived
{
    if (AirFuseAPICtx != nil)
    {
        NSString *location = @"2";
        
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"SessionStartReceived", (const uint8_t *)[location UTF8String]);
    }
}

-(void) sessionLoginError:(NSNumber*)_error
{
    if (AirFuseAPICtx != nil)
    {
        NSString *location = [_error stringValue];
        
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"SessionStartError", (const uint8_t *)[location UTF8String]);
    }
}

-(void) timeUpdated:(NSNumber*)_utcTimeStamp
{
    if (AirFuseAPICtx != nil)
    {
        NSString *location = [_utcTimeStamp stringValue];
        
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"SessionStartError", (const uint8_t *)[location UTF8String]);
    }
}

-(void) accountLoginComplete:(NSNumber*)_type Account:(NSString*)_account_id
{
    // not implemented
}

-(void) notificationAction:(NSString*)_action
{
    // not implemented
}

-(void) gameConfigurationReceived
{
    if (AirFuseAPICtx != nil)
    {
        NSString *location = @"2";
        
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"AppConfigurationReceived", (const uint8_t *)[location UTF8String]);
    }
}

-(void) friendAdded:(NSString*)_fuse_id Error:(NSNumber*)_error
{
    // not implemented
}

-(void) friendRemoved:(NSString*)_fuse_id Error:(NSNumber*)_error
{
    // not implemented
}

-(void) friendAccepted:(NSString*)_fuse_id Error:(NSNumber*)_error
{
    // not implemented
}

-(void) friendRejected:(NSString*)_fuse_id Error:(NSNumber*)_error
{
    // not implemented
}

-(void) friendsListUpdated:(NSDictionary*)_friendsList
{
    // not implemented
}

-(void) friendsListError:(NSNumber*)_error
{
    // not implemented
}

-(void) chatListReceived:(NSDictionary*)_messages User:(NSString*)_fuse_id
{
    // not implemented
}

-(void) chatListError:(NSNumber*)_error
{
    // not implemented
}

-(void) purchaseVerification:(NSNumber*)_verified TransactionID:(NSString*)_tx_id OriginalTransactionID:(NSString*)_o_tx_id
{
    // not implemented
}

-(void) mailListRecieved:(NSDictionary*)_messages User:(NSString*)_fuse_id
{
    // not implemented
}

-(void) mailListError:(NSNumber*)_error
{
    // not implemented
}

-(void) mailAcknowledged:(NSNumber*)_message_id User:(NSString*)_fuse_id RequestID:(NSNumber*)_request_id
{
    // not implemented
}

-(void) mailError:(NSNumber*)_error RequestID:(NSNumber*)_request_id;
{
    // not implemented
}

-(void) adAvailabilityResponse:(NSNumber*)_available Error:(NSNumber*)_error
{
    if (AirFuseAPICtx != nil)
    {
        BOOL isAvailable = [_available boolValue];
        int error = [_error intValue];
        NSString *location = [_error stringValue];
        
        if (error != FUSE_AD_NO_ERROR)
        {
            // An error has occurred checking for the ad
            FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"AdAvailabilityRequestError", (const uint8_t *)[location UTF8String]);
        }
        else
        {
            if (isAvailable)
            {
                // An ad is available
                FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"AdAvailabilityRequestAdAvialable", (const uint8_t *)[location UTF8String]);
            }
            else
            {
                // An ad is not available
                FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"AdAvailabilityRequestAdNotAvialable", (const uint8_t *)[location UTF8String]);
            }
        }
    }
}

@end


#pragma mark - AirFuseAPIAdDelegate

@implementation AirFuseAPIAdDelegate

static AirFuseAPIAdDelegate *sharedAdInstance = nil;

+ (AirFuseAPIAdDelegate *)sharedInstance
{
    if (sharedAdInstance == nil)
    {
        sharedAdInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedAdInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

#pragma mark Fuse Ad Delegate functions

-(void) adWillClose
{
    if (AirFuseAPICtx != nil)
    {
        NSString *location = @"2";
        
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"DidCloseInterstitial", (const uint8_t *)[location UTF8String]);
    }
}

@end

#pragma mark - AirFuseAPIAdDelegate

@implementation AirFuseAPIMoreGamesDelegate

static AirFuseAPIMoreGamesDelegate *sharedMoreGamesInstance = nil;

+ (AirFuseAPIMoreGamesDelegate *)sharedInstance
{
    if (sharedMoreGamesInstance == nil)
    {
        sharedMoreGamesInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedMoreGamesInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

#pragma mark More Games Delegate function

-(void) adWillClose
{
    if (AirFuseAPICtx != nil)
    {
        FREDispatchStatusEventAsync(AirFuseAPICtx, (const uint8_t *)"DidCloseMoreGames", nil);
    }
}

@end

#pragma mark - C interface

void didRegisterForRemoteNotificationsWithDeviceToken(id self, SEL _cmd, UIApplication* application, NSData* deviceToken)
{
    NSString* tokenString = [NSString stringWithFormat:@"%@", deviceToken];
    
    [FuseAPI applicationdidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

void didFailToRegisterForRemoteNotificationsWithError(id self, SEL _cmd, UIApplication* application, NSError* error)
{
    //NSLog(@"Error registering Push Notifications: %@ %@", [error localizedDescription], [NSString stringWithFormat:@"(Error code %i)", [error code]]);
    
    [FuseAPI applicationdidFailToRegisterForRemoteNotificationsWithError:error];
}

void didReceiveRemoteNotification(id self, SEL _cmd, UIApplication* application,NSDictionary *userInfo)
{
    [FuseAPI applicationdidReceiveRemoteNotification:userInfo Application:application];
}

DEFINE_ANE_FUNCTION(FuseStartSession)
{
    uint32_t stringLength;
    
    const uint8_t *valueAppId;
    if (FREGetObjectAsUTF8(argv[0], &stringLength, &valueAppId) != FRE_OK)
    {
        return nil;
    }
    NSString *appId = [NSString stringWithUTF8String:(char*)valueAppId];
    
    [FuseAPI startSession:appId Delegate:[AirFuseAPI sharedInstance]];
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseShowInterstitial)
{
    [FuseAPI showAdWithDelegate:[AirFuseAPIAdDelegate sharedInstance]];
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseCheckAdAvailable)
{
    [FuseAPI checkAdAvailable];
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseDisplayNotifications)
{
    [FuseAPI displayNotifications];
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseRegisterLevel)
{
    int32_t level = 0;

    if (FREGetObjectAsInt32(argv[0], &level) == FRE_OK)
    {
        [FuseAPI registerLevel:level];
    }
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseRegisterCurrency)
{
    int32_t type = 0;
    int32_t balance = 0;
    
    if (FREGetObjectAsInt32(argv[0], &type) != FRE_OK)
    {
        return nil;
    }

    if (FREGetObjectAsInt32(argv[1], &balance) != FRE_OK)
    {
        return nil;
    }
    
    [FuseAPI registerCurrency:type Balance:balance];
    
    return nil;
}

DEFINE_ANE_FUNCTION(FuseRegisterEvent)
{
    int returnValue = -1;
    
    uint32_t stringLength;
    
    const uint8_t *value;
    if (FREGetObjectAsUTF8(argv[0], &stringLength, &value) != FRE_OK)
    {
        return nil;
    }
    NSString *eventName = [NSString stringWithUTF8String:(char*)value];
    
    // Parameters
    NSMutableDictionary *params = nil;
    
    if (argc > 1 && argv[1] != NULL && argv[2] != NULL && argv[1] != nil && argv[2] != nil)
    {
        FREObject arrKey = argv[1]; // array
        uint32_t arr_len = 0; // array length
        
        FREObject arrValue = argv[2]; // array
        
        if (arrKey != nil)
        {
            if (FREGetArrayLength(arrKey, &arr_len) != FRE_OK)
            {
                arr_len = 0;
            }
            
            params = [[NSMutableDictionary alloc] init];
            
            for (int32_t i = arr_len-1; i >= 0; i--)
            {
                // get an element at index
                FREObject key;
                if (FREGetArrayElementAt(arrKey, i, &key) != FRE_OK)
                {
                    continue;
                }
                
                FREObject value;
                if (FREGetArrayElementAt(arrValue, i, &value) != FRE_OK)
                {
                    continue;
                }
                
                // convert it to NSString
                uint32_t stringLength;
                const uint8_t *keyString;
                if (FREGetObjectAsUTF8(key, &stringLength, &keyString) != FRE_OK)
                {
                    continue;
                }
                
                const uint8_t *valueString;
                if (FREGetObjectAsUTF8(value, &stringLength, &valueString) != FRE_OK)
                {
                    continue;
                }
                
                [params setValue:[NSString stringWithUTF8String:(char*)valueString] forKey:[NSString stringWithUTF8String:(char*)keyString]];
            }
        }
    }
    
    // Variables
    NSMutableDictionary *variables = nil;

    if (argc > 3 && argv[3] != NULL && argv[4] != NULL && argv[3] != nil && argv[4] != nil)
    {
        FREObject arrKey = argv[3]; // array
        uint32_t arr_len = 0; // array length
        
        FREObject arrValue = argv[4]; // array
        
        if (arrKey != nil)
        {
            if (FREGetArrayLength(arrKey, &arr_len) != FRE_OK)
            {
                arr_len = 0;
            }
            
            variables = [[NSMutableDictionary alloc] init];
            
            for (int32_t i = arr_len-1; i >= 0; i--)
            {
                // get an element at index
                FREObject key;
                if (FREGetArrayElementAt(arrKey, i, &key) != FRE_OK)
                {
                    continue;
                }
                
                FREObject value;
                if (FREGetArrayElementAt(arrValue, i, &value) != FRE_OK)
                {
                    continue;
                }
                
                // convert it to NSString
                uint32_t stringLength;
                const uint8_t *keyString;
                if (FREGetObjectAsUTF8(key, &stringLength, &keyString) != FRE_OK)
                {
                    continue;
                }
                
                const uint8_t *valueString;
                if (FREGetObjectAsUTF8(value, &stringLength, &valueString) != FRE_OK)
                {
                    continue;
                }
                
                NSString *val = [NSString stringWithUTF8String:(char*)valueString];
                
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *num = [f numberFromString:val];
                [f release];
                
                [variables setValue:num forKey:[NSString stringWithUTF8String:(char*)keyString]];
            }
        }
    }
    
    if (variables != nil && variables.count > 0)
    {
        NSArray *keys = [params allKeys];
        
        for (int i = 0; i < [keys count]; i++)
        {
            NSString *params_name = [keys objectAtIndex:i];
            NSString *params_value = (NSString*)[params objectForKey:params_name];
            
            returnValue = [FuseAPI registerEvent:eventName ParameterName:params_name ParameterValue:params_value Variables:variables];
        }
    }
    else if (params != nil && params.count > 0)
    {
        [FuseAPI registerEvent:eventName withDict:params];
    }
    else
    {
        [FuseAPI registerEvent:eventName];
    }
   
    FREObject freObject;
    FREResult freResult = FRENewObjectFromInt32(returnValue, &freObject);
    
    if (freResult != FRE_OK)
    {
        return nil;
    }
    
    return freObject;
}

DEFINE_ANE_FUNCTION(FuseRegisterGender)
{
    int32_t gender = 0;
    
    if (FREGetObjectAsInt32(argv[0], &gender) == FRE_OK)
    {
        [FuseAPI registerGender:gender];
    }
    
    return nil;
}


DEFINE_ANE_FUNCTION(FuseRegisterInAppPurchase)
{
    uint32_t stringLength;
    
    NSData *receipt_data = nil;
    
    // Parameter 1: tx_state
    int32_t tx_state = 0;
    
    if (FREGetObjectAsInt32(argv[0], &tx_state) != FRE_OK)
    {
        return nil;
    }
    
    // Parameter 2: Price
    const uint8_t *price_ptr;
    if (FREGetObjectAsUTF8(argv[1], &stringLength, &price_ptr) != FRE_OK)
    {
        return nil;
    }
    NSString *price = [NSString stringWithUTF8String:(char*)price_ptr];
    
    // Parameter 2: Currency
    const uint8_t *currency_ptr;
    if (FREGetObjectAsUTF8(argv[2], &stringLength, &currency_ptr) != FRE_OK)
    {
        return nil;
    }
    NSString *currency = [NSString stringWithUTF8String:(char*)currency_ptr];
    
    // Parameter 3: Product ID
    const uint8_t *product_id_ptr;
    if (FREGetObjectAsUTF8(argv[3], &stringLength, &product_id_ptr) != FRE_OK)
    {
        return nil;
    }
    NSString *product_id = [NSString stringWithUTF8String:(char*)product_id_ptr];
    
    // Parameter 4: Transaction ID
    const uint8_t *tx_id_ptr;
    if (FREGetObjectAsUTF8(argv[4], &stringLength, &tx_id_ptr) != FRE_OK)
    {
        return nil;
    }
    NSString *tx_id = [NSString stringWithUTF8String:(char*)tx_id_ptr];
    
    [FuseAPI registerInAppPurchase:receipt_data TxState:tx_state Price:price Currency:currency ProductID:product_id TransactionID:tx_id];

    return nil;
}

DEFINE_ANE_FUNCTION(FuseDisplayMoreGames)
{
    [FuseAPI displayMoreGames:[AirFuseAPI sharedInstance]];
    
    return  nil;
}

DEFINE_ANE_FUNCTION(FuseGetGameConfigurationValue)
{
    uint32_t stringLength;
    
    const uint8_t *valueKey;
    if (FREGetObjectAsUTF8(argv[0], &stringLength, &valueKey) != FRE_OK)
    {
        return nil;
    }
    NSString *key = [NSString stringWithUTF8String:(char*)valueKey];
    
    
    NSString *value = [FuseAPI getGameConfigurationValue:key];
    
    if (value == nil)
    {
        value = @"";
    }
    
    FREObject freObject;
    
    const char *tempString = [value cStringUsingEncoding:NSASCIIStringEncoding];

    FRENewObjectFromUTF8(strlen(tempString)+1, (const uint8_t *) tempString, &freObject);
    
    return freObject;
}

DEFINE_ANE_FUNCTION(FuseGamesPlayed)
{
    int gamesPlayed = [FuseAPI gamesPlayed];
    
    FREObject freObject;
    FREResult freResult = FRENewObjectFromInt32(gamesPlayed, &freObject);
    
    if (freResult != FRE_OK)
    {
        return nil;
    }
    
    return freObject;
}

DEFINE_ANE_FUNCTION(FuseLog)
{
    uint32_t stringLength;
    
    const uint8_t *valueKey;
    if (FREGetObjectAsUTF8(argv[0], &stringLength, &valueKey) != FRE_OK)
    {
        return nil;
    }
    NSString *value = [NSString stringWithUTF8String:(char*)valueKey];
    
    NSLog(@"Fuse: %@", value);
    
    return nil;
}

#pragma mark - ANE setup

/* AirFuseAPIExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void AirFuseAPIExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirFuseAPIContextInitializer;
    *ctxFinalizerToSet = &AirFuseAPIContextFinalizer;
}

/* AirFuseAPIExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void AirFuseAPIExtFinalizer(void* extData) 
{
    return;
}

/* AirFuseAPIContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void AirFuseAPIContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    // Override the applicaiton delegate push token function with our own
    id delegate = [[UIApplication sharedApplication] delegate];
    
    Class objectClass = object_getClass(delegate);
    
    NSString *newClassName = [NSString stringWithFormat:@"Custom_%@", NSStringFromClass(objectClass)];
    Class modDelegate = NSClassFromString(newClassName);
    
    if (modDelegate == nil)
    {
        // this class doesn't exist; create it
        // allocate a new class
        modDelegate = objc_allocateClassPair(objectClass, [newClassName UTF8String], 0);
        
        SEL selectorToOverride1 = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
        
        SEL selectorToOverride2 = @selector(application:didFailToRegisterForRemoteNotificationsWithError:);
        
        SEL selectorToOverride3 = @selector(application:didReceiveRemoteNotification:);
        
        // get the info on the method we're going to override
        Method m1 = class_getInstanceMethod(objectClass, selectorToOverride1);
        Method m2 = class_getInstanceMethod(objectClass, selectorToOverride2);
        Method m3 = class_getInstanceMethod(objectClass, selectorToOverride3);
        
        // add the method to the new class
        class_addMethod(modDelegate, selectorToOverride1, (IMP)didRegisterForRemoteNotificationsWithDeviceToken, method_getTypeEncoding(m1));
        class_addMethod(modDelegate, selectorToOverride2, (IMP)didFailToRegisterForRemoteNotificationsWithError, method_getTypeEncoding(m2));
        class_addMethod(modDelegate, selectorToOverride3, (IMP)didReceiveRemoteNotification, method_getTypeEncoding(m3));
        
        // register the new class with the runtime
        objc_registerClassPair(modDelegate);
    }
    
    // change the class of the object
    object_setClass(delegate, modDelegate);
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 13;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "startSession";
    func[0].functionData = NULL;
    func[0].function = &FuseStartSession;
    
    func[1].name = (const uint8_t*) "showAd";
    func[1].functionData = NULL;
    func[1].function = &FuseShowInterstitial;
    
    func[2].name = (const uint8_t*) "checkAdAvailable";
    func[2].functionData = NULL;
    func[2].function = &FuseCheckAdAvailable;
    
    func[3].name = (const uint8_t*) "displayNotifications";
    func[3].functionData = NULL;
    func[3].function = &FuseDisplayNotifications;
    
    func[4].name = (const uint8_t*) "registerLevel";
    func[4].functionData = NULL;
    func[4].function = &FuseRegisterLevel;
    
    func[5].name = (const uint8_t*) "registerCurrency";
    func[5].functionData = NULL;
    func[5].function = &FuseRegisterCurrency;
    
    func[6].name = (const uint8_t*) "registerEvent";
    func[6].functionData = NULL;
    func[6].function = &FuseRegisterEvent;
    
    func[7].name = (const uint8_t*) "displayMoreGames";
    func[7].functionData = NULL;
    func[7].function = &FuseDisplayMoreGames;
    
    func[8].name = (const uint8_t*) "getGameConfigurationValue";
    func[8].functionData = NULL;
    func[8].function = &FuseGetGameConfigurationValue;
    
    func[9].name = (const uint8_t*) "gamesPlayed";
    func[9].functionData = NULL;
    func[9].function = &FuseGamesPlayed;
    
    func[10].name = (const uint8_t*) "log";
    func[10].functionData = NULL;
    func[10].function = &FuseLog;
    
    func[11].name = (const uint8_t*) "registerGender";
    func[11].functionData = NULL;
    func[11].function = &FuseRegisterGender;
    
    func[12].name = (const uint8_t*) "registerInAppPurchase";
    func[12].functionData = NULL;
    func[12].function = &FuseRegisterInAppPurchase;
    
    *functionsToSet = func;

    AirFuseAPICtx = ctx;
}

/* AirFuseAPIContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls AirFuseAPIContextFinalizer().
 */
void AirFuseAPIContextFinalizer(FREContext ctx) 
{
    return;
}


