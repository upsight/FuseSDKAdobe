package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import com.fusepowered.fuseapi.FuseAPI;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension; 

import com.fusepowered.fuseactivities.FuseApiAdBrowser;
import com.fuse.ane.callback.AdCallback;

public class ShowAdFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		
		FuseAPI.displayAd(new FuseApiAdBrowser(), new AdCallback(arg0.getActivity()));
		
		
		return null;
	}

}
