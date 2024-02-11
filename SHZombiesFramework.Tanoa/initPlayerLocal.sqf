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

if (!hasInterface) exitWith {};

// Set a random loadout before it gets saved by onPlayerKilled.sqf
private _loadout = [_player] call SHZ_fnc_getRespawnLoadout;
if (_loadout isNotEqualTo []) then {_player setUnitLoadout _loadout};

call SHZ_fnc_initDiary;
call SHZ_fnc_initTeamSafezoneHandlers;
call SHZ_fnc_initIncapacitatedHandlers;
call SHZ_fnc_initUnflipAction;
call SHZ_fnc_musicStartPlaylist;
0 spawn SHZ_fnc_initFriendlyMapIcons;
0 spawn SHZ_fnc_updateChannelLoop;
0 spawn SHZ_fnc_selfReviveLoop;

systemChat format ["Finished initialization (%1)", briefingName];
