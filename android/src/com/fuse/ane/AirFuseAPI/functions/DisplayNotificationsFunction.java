package com.fuse.ane.AirFuseAPI.functions;

import android.app.AlertDialog;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import com.fusepowered.fuseapi.FuseAPI;

public class DisplayNotificationsFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		
		//AirFuseAPIExtension.log("Displaying a notification");
		
		FuseAPI.displayNotifications(new AlertDialog.Builder(arg0.getActivity()));
		
		return null;
	}

}
