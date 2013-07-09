Air Native Extension for Fuse API (iOS)
======================================

This is an [Air native extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) for the [FuseAPI](http://www.fuseboxx.com) on iOS.

Fuse API
---------

This ANE uses Fuse API version 1.29

Installation
---------

To integrate the plugin into your Flash project, follow the following steps:

1.  First, copy the AIRFuseAPI.ane and AIRFuseAPI.swf found in the github directory (/bin/) into your project.

2.  Next, in Flash navigate to:

File->Air fo iOS Settings->General

In the "Included files" list, add an entry and choose the AirFuseAPI.ane file.

2.  Finally, navigate to:

File->Advanced Actionscript Settings->Library Path

Click the button to "Browse to a Native Air Extension (ANE file)", and select the AIRFuseAPI.ane file.


Usage
---------

To use the AIRFuseAPI plugin in your Flash project, first import Fuse package: 

    ```
    import com.fuse.ane.*;
    ```

Next, call 'startSession' as soon at the app is initialized:

    ```
    public class KillerApp extends App {
    
        fuse = new AirFuseAPI();
        fuse.startSession('<YOUR FUSE API KEY>');
    }

    ```

The Fuse API key can be found in your dashboard view for the app your are trying to integrate by navigating to Admin->Integrate SDK in the (Fuseboxx)[https://www.fuseboxx.com] dashboard.


### Features ####


#### Interstitial Ads ####


    ```
    fuse.showAd(_delegate);
    ```


#### Analytics Events ####


#### More Games ####


#### Fuse Notifications ####


#### App Configuration Parameters ####


#### Registering Levels ####


#### Registering Currency ####



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
