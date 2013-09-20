package com.fuse.ane.callback;

import android.app.Activity;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;
import com.fusepowered.util.FuseAdErrors;
import com.fusepowered.util.FuseAdCallback;

public class AdCallback extends FuseAdCallback{

	private Activity activity;

	public AdCallback(Activity activity) {
		this.activity = activity;
	}
	
	@Override
	public void callback() {
		AirFuseAPIExtension.log("Ad callback");
	}

	@Override
	public void adClicked() {
		AirFuseAPIExtension.log("Ad Clicked");
	}

	@Override
	public void adDisplayed() {
		AirFuseAPIExtension.log("Ad Displayed");
	}

	@Override
	public void adWillClose() {
		AirFuseAPIExtension.dispatch("DidCloseInterstitial", "2");
	}
	
	
	@Override
	public void adAvailabilityResponse(int available, int error) {
		// TODO Auto-generated method stub
		//AirFuseAPIExtension.log("Ad available response " + available + " and the error code: " + error);
		String errorValue = String.valueOf(error);
		
		
		if (FuseAdErrors.getFuseAdErrorByCode(error) != FuseAdErrors.FUSE_AD_NO_ERROR)
		{
			AirFuseAPIExtension.dispatch("AdAvailabilityRequestError", errorValue);
			//AirFuseAPIExtension.log("Ad request Error");
		}
		else
		{
			if (available != 0)
			{
				AirFuseAPIExtension.dispatch("AdAvailabilityRequestAdAvialable", errorValue);
				//AirFuseAPIExtension.log("Available");
			}
			else
			{
				AirFuseAPIExtension.dispatch("AdAvailabilityRequestAdNotAvialable", errorValue);
				//AirFuseAPIExtension.log("Not Available");
			}
		}
	}

}
