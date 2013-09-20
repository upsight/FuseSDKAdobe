package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

import com.fusepowered.fuseapi.FuseAPI;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;

public class RegisterCurrencyFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		AirFuseAPIExtension.log("Registering Currency");
		try {
			FuseAPI.registerCurrency(arg1[0].getAsInt(), arg1[1].getAsInt());
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("Registering Currency illegal state");
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("Registering Currency type mismatch");
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("Registering Currency invalid object");
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("Registering Currency thread exception");
			e.printStackTrace();
		}
		
		
		return null;
	}

}
