package com.fuse.ane.AirFuseAPI;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;


public class AirFuseAPIExtension implements FREExtension {

	public static FREContext context;
	
	@Override
	public FREContext createContext(String arg0) {
		// TODO Auto-generated method stub
		context = new AirFuseAPIExtensionContext ();
		return context;
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub
		context = null;

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}
    public static void log(String message)
    {
        context.dispatchStatusEventAsync("LOGGING", message);
    }

    
    public static void dispatch(String msg, String location)
    {
    	context.dispatchStatusEventAsync(msg, location);
    }
    
}
