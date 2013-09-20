Air Native Extension for Fuse API (iOS)
======================================

This is an [Air native extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) for the [FuseAPI](http://www.fuseboxx.com).

Fuse API
---------

This ANE uses Fuse API version 1.31

Installation
---------

To integrate the plugin into your Flash project, follow the following steps:

1.  First, copy the AIRFuseAPI.ane and AIRFuseAPI.swf found in the github directory (/bin/) into your project.
2.  Next, in Flash navigate to:<rr />File->Air for iOS Settings->General<br />In the "Included files" list, add an entry and choose the AirFuseAPI.ane file.
3.  Finally, navigate to:

File->Advanced Actionscript Settings->Library Path

Click the button to "Browse to a Native Air Extension (ANE file)", and select the AIRFuseAPI.ane file.


Usage
---------

To use the AIRFuseAPI plugin in your Flash project, first import Fuse package: 

    import com.fuse.ane.*;

Next, call 'startSession' as soon as the app is initialized:

    public class KillerApp extends App {
        fuse = new AirFuseAPI();
        fuse.startSession('<YOUR FUSE API KEY>');
    }

The Fuse API key can be found in your dashboard view for the app your are trying to integrate by navigating to Admin->Integrate SDK in the (Fuseboxx)[https://www.fuseboxx.com] dashboard.


### Features ####

The current list of features supported by the Fuse ANE plugin are as follows:

#### Interstitial Ads ####

    fuse.showAd(adResponseCallback);

    function adResponseCallback() {
        // The ad has been closed - proceed
    }

#### Interstitial Ad Availability ####
    
    fuse.checkAdAvailable(adCheckResponseCallback);

    function adCheckResponseCallback(available:Boolean, error:int) {
        if (error == 0 && available) {
            // Ad is available
        }
    }


#### Analytics Events ####

There are a number of ways to register data in the Fuse analytics system:

    // A five-level event with two dictionaries
    fuse.registerEvent("Game Events", {"Level Completed": "2"}, {"Win": 0, "Difficulty": 5});
    
    // A five-level analytics event with one dictionary
    fuse.registerEvent("Game Events", "Level Completed", "2", {"Win": 0, "Difficulty": 5});

    // A three-level analytics event
    fuse.registerEvent("Game Events", "Level Completed", "2");
    
    // Or
    fuse.registerEvent("Game Events", {"Level Completed": "2"});

#### More Games ####

    fuse.displayMoreGames();
    
    
#### Fuse Notifications ####

    fuse.displayNotifications();


#### App Configuration Parameters ####

App configuration key/value pairs can be configured in the Fuseboxx dashboard.  The code to access the values are as follows:

    var _key:String = "test_key";
    
    var _value:String = fuse.getGameConfigurationValue(_key);


#### Registering Levels ####

    var _level:int = 5; // the user's achieved level
    
    fuse.registerLevel(_level);


#### Registering Currency ####

    var _type:int = 0; // type in 0->3
    var _balance:int = 52; // the users's current balance
    
    fuse.registerCurrency(_type, _balance);
    

Build script
---------

Should you need to edit the extension source code and/or recompile it, you will find an ant build script (build.xml) in the *build* folder:

    cd /path/to/the/ane/build
    mv example.build.config build.config
    #edit the build.config file to provide your machine-specific paths
    ant


Authors
------

This ANE has been written by [Gary Kosinsky](http://www.fuseboxx.com). It belongs to [Fuse Powered Inc.](http://www.fusepowered.com) and is distributed under the [Apache Licence, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
