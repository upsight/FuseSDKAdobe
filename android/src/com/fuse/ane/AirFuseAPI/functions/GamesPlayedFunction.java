package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

import com.fusepowered.fuseapi.FuseAPI;

public class GamesPlayedFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		
		int gamesplayed = FuseAPI.gamesPlayed();
		
		try {
			return FREObject.newObject(gamesplayed);
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
