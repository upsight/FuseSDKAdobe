package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.fusepowered.fuseactivities.FuseApiMoregamesBrowser;
import com.fusepowered.fuseapi.FuseAPI;

public class MoreGamesFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub
		
		FuseAPI.displayMoreGames(new FuseApiMoregamesBrowser());
		
		return null;
	}

}
