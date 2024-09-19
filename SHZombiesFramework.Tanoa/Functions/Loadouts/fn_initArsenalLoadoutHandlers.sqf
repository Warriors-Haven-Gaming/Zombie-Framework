/*
Function: SHZ_fnc_initArsenalLoadoutHandlers

Description:
    Sets up a handler to save the player's loadout upon exiting the arsenal.

Author:
    thegamecracks

*/
[missionNamespace, "arsenalClosed", {
    if (!SHZ_loadouts_saveOnArsenal) exitWith {};
    missionProfileNamespace setVariable ["SHZ_lastLoadout", getUnitLoadout player];
    if (!isServer) then {saveMissionProfileNamespace};
}] call BIS_fnc_addScriptedEventHandler;
