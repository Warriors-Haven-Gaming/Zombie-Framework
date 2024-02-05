params ["_oldUnit"];
SHZ_lastLoadout = getUnitLoadout _oldUnit;
remoteExec ["", (_oldUnit call BIS_fnc_netId) + ":SHZ_moneyShare"];
