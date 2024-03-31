/*
Script: onPlayerRespawn.sqf

Description:
    Executed locally when player respawns.
    https://community.bistudio.com/wiki/Event_Scripts#onPlayerRespawn.sqf

Parameters:
    Object newUnit:
        The player unit that respawned.

Author:
    thegamecracks

*/
params ["_newUnit"];

private _loadout = missionProfileNamespace getVariable ["SHZ_lastLoadout", []];
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

call SHZ_fnc_initUnflipAction;
[_newUnit] remoteExec [
    "SHZ_fnc_initMoneyShareActions",
    SHZ_globalPlayerTarget,
    (_newUnit call BIS_fnc_netId) + ":SHZ_moneyShare"
];
[_newUnit, "NoVoice"] remoteExec [
    "setSpeaker",
    SHZ_globalPlayerTarget,
    (_newUnit call BIS_fnc_netId) + ":SHZ_setSpeaker"
];

if (isNil "SHZ_shownIntroHint") then {
    [["Intro", "Welcome"], 15, nil, 35, nil, true, true, false, false] spawn BIS_fnc_advHint;
    SHZ_shownIntroHint = true;
};
