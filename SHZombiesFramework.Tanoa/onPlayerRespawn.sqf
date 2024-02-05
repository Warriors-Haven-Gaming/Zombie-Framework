params ["_newUnit"];

private _loadout = missionNamespace getVariable ["SHZ_lastLoadout", []];
if (_loadout isEqualTo []) then {
    _loadout = [_newUnit] call SHZ_fnc_getRespawnLoadout;
};
if (_loadout isNotEqualTo []) then {_newUnit setUnitLoadout _loadout};

_newUnit setUnitTrait ["audibleCoef", 0.5];
_newUnit setUnitTrait ["camouflageCoef", 0.2];
_newUnit setUnitTrait ["loadCoef", 0.7];
_newUnit setUnitTrait ["engineer", true];
_newUnit setUnitTrait ["explosiveSpecialist", true];
_newUnit setUnitTrait ["medic", true];

[_newUnit] remoteExec [
    "SHZ_fnc_initMoneyShareActions",
    [0, -2] select isDedicated,
    _newUnit
];
