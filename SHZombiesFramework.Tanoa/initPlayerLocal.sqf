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

if (!isServer) then {call SHZ_fnc_initZombieSettings};

if (!hasInterface) exitWith {};

// Set the player's loadout before they respawn and onPlayerKilled.sqf saves it
private _loadout = missionProfileNamespace getVariable ["SHZ_lastLoadout", []];
if (_loadout isEqualTo []) then {
    _loadout = [_player] call SHZ_fnc_getRespawnLoadout;
};
if (_loadout isNotEqualTo []) then {_player setUnitLoadout _loadout};

SHZ_shopkeeperPurchases = createHashMap;

call SHZ_fnc_initDiary;
call SHZ_fnc_initArsenalLoadoutHandlers;
call SHZ_fnc_initFriendlyFireHandlers;
call SHZ_fnc_initTeamSafezoneHandlers;
call SHZ_fnc_initIncapacitatedHandlers;
0 spawn SHZ_fnc_initFriendlyMapIcons;
0 spawn SHZ_fnc_updateChannelLoop;
0 spawn SHZ_fnc_selfReviveLoop;

systemChat format ["Finished initialization (%1)", briefingName];
