params ["_newUnit"];

private _loadout = missionNamespace getVariable ["SHZ_lastLoadout", []];
if (_loadout isEqualTo []) then {
	_loadout = call SHZ_fnc_getRespawnLoadout;
};
if (_loadout isNotEqualTo []) then {_newUnit setUnitLoadout _loadout};
