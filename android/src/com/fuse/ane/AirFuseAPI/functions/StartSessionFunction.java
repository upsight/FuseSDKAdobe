package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.fusepowered.fuseapi.FuseAPI;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;
import com.fuse.ane.callback.MessageCallback;

public class StartSessionFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		
	
		try {
			//AirFuseAPIExtension.log("This is the app ID " + arg1[0].getAsString());
			FuseAPI.startSession(arg1[0].getAsString(), arg0.getActivity(), arg0.getActivity().getApplicationContext(), new MessageCallback(arg0.getActivity()));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

}
