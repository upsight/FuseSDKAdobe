package com.fuse.ane.AirFuseAPI.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;
import com.fusepowered.fuseapi.FuseAPI;
import com.adobe.fre.FREArray;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class RegisterEventFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		// TODO Auto-generated method stub

		
		
		try{
			String event = arg1[0].getAsString();
			
			//They've only sent in the event!  This is an easy case, just register the event, no need to parse anything else
			if (arg1.length == 1)
			{
				FuseAPI.registerEvent(event, null, null, null, null);
			}
			else
			{
				HashMap<String, String> params = new HashMap <String, String>();
				String param = null;
				String paramValue = null;
				
				//Parse out the parameters.  This is tricky.  They can send an array of parameter and parameter values or just paramters
				if (arg1[1].getClass().equals(FREArray.class) && arg1[2].getClass().equals(FREArray.class))
				{
					FREArray paramKeysArr = (FREArray) arg1[1];
					FREArray paramValueArr = (FREArray) arg1[2];
					
					param = paramKeysArr.getObjectAt(0).getAsString();
					paramValue = paramValueArr.getObjectAt(0).getAsString();
					
					for (int i = 0; i < paramKeysArr.getLength(); i++)
					{
						params.put(paramKeysArr.getObjectAt(i).getAsString(), paramValueArr.getObjectAt(i).getAsString());
					}
				}
				else
				{
					
					param = arg1[1].getAsString();
					paramValue = arg1[2].getAsString();
					params.put(param, paramValue);
				
				
				}
				
				//They have sent variables too.  Parse these out.
				if (arg1.length > 3)
				{
					HashMap<String, Number> variables = new HashMap <String, Number>();
					if (arg1[3].getClass().equals(FREArray.class) && arg1[4].getClass().equals(FREArray.class))
					{
						FREArray varKeys = (FREArray) arg1[3];
						FREArray varValue = (FREArray) arg1[4];
						
						for (int i = 0; i < varKeys.getLength(); i++)
						{
							int intValue = Integer.parseInt(varValue.getObjectAt(i).getAsString());
							double doubleValue = Double.parseDouble(varValue.getObjectAt(i).getAsString());
							
							if (intValue < doubleValue)
							{
								variables.put(varKeys.getObjectAt(i).getAsString(), doubleValue);
							}
							else
							{
								variables.put(varKeys.getObjectAt(i).getAsString(), intValue);
							}
						}
						
					}
					else
					{
						int intValue = arg1[4].getAsInt();
						double doubleValue = arg1[4].getAsDouble();
						
						if (intValue < doubleValue)
							variables.put(arg1[3].getAsString(), doubleValue);
						else
							variables.put(arg1[3].getAsString(), intValue);
					}
					
					FuseAPI.registerEvent(event, param, paramValue, variables);
					
				}
				else
				{
					FuseAPI.registerEvent(event, params);
				}
				
				
				
			}
			
			
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("ERROR Illegal State");
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("ERROR ERROR ERROR Got a type wrong!");
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("ERROR Invalid Object");
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			// TODO Auto-generated catch block
			AirFuseAPIExtension.log("ERROR Wrong Thread");
			e.printStackTrace();
		}
		
		return null;
	}

}
