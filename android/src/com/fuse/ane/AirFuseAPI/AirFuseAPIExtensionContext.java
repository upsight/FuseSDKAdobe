package com.fuse.ane.AirFuseAPI;
import java.util.Map;
import java.util.HashMap;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

import com.fuse.ane.AirFuseAPI.functions.*;

public class AirFuseAPIExtensionContext extends FREContext {

	@Override
	public Map<String, FREFunction> getFunctions() {
		// TODO Auto-generated method stub
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("startSession", new StartSessionFunction());
		functions.put("registerEvent", new RegisterEventFunction());
		functions.put("checkAdAvailable", new CheckAdAvailableFunction());
		functions.put("displayNotifications", new DisplayNotificationsFunction());
		functions.put("showAd", new ShowAdFunction());
		functions.put("getGameConfigurationValue", new GetGameConfigurationValueFunction());
		functions.put("registerLevel", new RegisterLevelFunction());
		functions.put("registerCurrency", new RegisterCurrencyFunction());
		functions.put("gamesPlayed", new GamesPlayedFunction());
		functions.put("suspendSession", new SuspendSessionFunction());
		functions.put("resumeSession", new ResumeSessionFunction());
		functions.put("displayMoreGames", new MoreGamesFunction());

		return functions;
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

}
