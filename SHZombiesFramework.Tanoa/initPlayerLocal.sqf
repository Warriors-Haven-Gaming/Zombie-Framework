params ["_player"];

private _loadout = [_player] call SHZ_fnc_getRespawnLoadout;
if (_loadout isNotEqualTo []) then {_player setUnitLoadout _loadout};

call SHZ_fnc_musicStartPlaylist;
0 spawn SHZ_fnc_initFriendlyMapIcons;

systemChat format ["Finished initialization (%1 v%2)", briefingName, call SHZ_fnc_version];
