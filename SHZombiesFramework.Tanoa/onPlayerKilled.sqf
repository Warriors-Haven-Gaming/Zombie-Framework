/*
Script: onPlayerKilled.sqf

Description:
    Executed locally when player is killed.
    https://community.bistudio.com/wiki/Event_Scripts#onPlayerKilled.sqf

Parameters:
    Object oldUnit:
        The player unit that died.

Author:
    thegamecracks

*/
params ["_oldUnit"];
SHZ_lastLoadout = getUnitLoadout _oldUnit;
remoteExec ["", (_oldUnit call BIS_fnc_netId) + ":SHZ_moneyShare"];
