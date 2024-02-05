params ["_player"];

if (!hasInterface) exitWith {};

// Set a random loadout before it gets saved by onPlayerKilled.sqf
private _loadout = [_player] call SHZ_fnc_getRespawnLoadout;
if (_loadout isNotEqualTo []) then {_player setUnitLoadout _loadout};

[_player] remoteExec [
    "SHZ_fnc_initMoneyShareActions",
    [0, -2] select isDedicated,
    _player
];

call SHZ_fnc_initTeamSafezoneHandlers;
call SHZ_fnc_musicStartPlaylist;
0 spawn SHZ_fnc_initFriendlyMapIcons;
0 spawn SHZ_fnc_updateChannelLoop;

systemChat format ["Finished initialization (%1)", briefingName];
