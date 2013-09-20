package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.fusepowered.fuseapi.FuseAPI;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;

public class RegisterLevelFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		//AirFuseAPIExtension.log("Register Level");
		try {
			FuseAPI.registerLevel(arg1[0].getAsInt());
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("RegisterLevel Illegal State");
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("RegisterLevel Type Mismatch");
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("RegisterLevel Invalid Object");
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("RegisterLevel Wrong Thread");
			e.printStackTrace();
		}
		
		return null;
	}

}
