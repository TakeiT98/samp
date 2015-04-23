#define FILTERSCRIPT

#include <a_samp>

#define flashtime 115 //milliseconds for the flash, larger number = slower flash

#if defined FILTERSCRIPT

new Flash[MAX_VEHICLES];
new FlashTime[MAX_VEHICLES];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Flashing Lights by TakeiT Loaded.");
	print("--------------------------------------\n");
	return 1;
}

forward OnLightFlash(vehicleid);
public OnLightFlash(vehicleid)
{
    new panels, doors, lights, tires;
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	switch(Flash[vehicleid])
	{
        case 0: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);

	    case 1: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);

	    case 2: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);

	    case 3: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);

	    case 4: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);

	    case 5: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
	}
	if(Flash[vehicleid] >=5) Flash[vehicleid] = 0;
	else Flash[vehicleid] ++;
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	if(newstate)
	{
	    FlashTime[vehicleid] = SetTimerEx("OnLightFlash", flashtime, true, "d", vehicleid);
	}
	
	if(!newstate)
	{
		new panels, doors, lights, tires;

		KillTimer(FlashTime[vehicleid]);
	    
		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	    UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
	}
	return 1;
}

public OnFilterScriptExit()
{
    new panels, doors, lights, tires;
    
	for(new i=0; i<GetVehiclePoolSize(); i++)
	{
	    KillTimer(FlashTime[i]);
	    
	    GetVehicleDamageStatus(i, panels, doors, lights, tires);
	    UpdateVehicleDamageStatus(i, panels, doors, 0, tires);
	}
	return 1;
}

#endif
