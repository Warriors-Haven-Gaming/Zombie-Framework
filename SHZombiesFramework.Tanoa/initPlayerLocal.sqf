/*
Script: initPlayerLocal.sqf

Description:
    Executed locally when player joins mission.
    https://community.bistudio.com/wiki/Event_Scripts#initPlayerLocal.sqf

Parameters:
    Object player:
        The player unit.

Author:
    thegamecracks

*/
params ["_player"];

// In case the Loot module is present, disable it (duplicated in initServer.sqf)
// (not placed in init.sqf due to initialization order in singleplayer)
ryanzombiesAllLoot = nil;

if (!hasInterface) exitWith {};

// Set a random loadout before it gets saved by onPlayerKilled.sqf
private _loadout = [_player] call SHZ_fnc_getRespawnLoadout;
if (_loadout isNotEqualTo []) then {_player setUnitLoadout _loadout};

SHZ_shopkeeperPurchases = createHashMap;

call SHZ_fnc_initDiary;
call SHZ_fnc_initArsenalLoadoutHandlers;
call SHZ_fnc_initFriendlyFireHandlers;
call SHZ_fnc_initTeamSafezoneHandlers;
call SHZ_fnc_initIncapacitatedHandlers;
call SHZ_fnc_initUnflipAction;
call SHZ_fnc_musicStartPlaylist;
0 spawn SHZ_fnc_initFriendlyMapIcons;
0 spawn SHZ_fnc_updateChannelLoop;
0 spawn SHZ_fnc_selfReviveLoop;

systemChat format ["Finished initialization (%1)", briefingName];
