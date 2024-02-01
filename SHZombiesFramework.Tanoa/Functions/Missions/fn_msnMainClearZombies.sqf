/*
Function: SHZ_fnc_msnMainClearZombies

Description:
    Players must clear out zombies from an area.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL area:
        (Optional, default [])
        If specified, the given area is used for the mission instead of
        attempting to find a suitable area.

Author:
    thegamecracks

*/
params [["_area", []]];

if (_area isEqualTo []) then {
    private _location = selectRandom nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity"],
        sqrt 2 / 2 * worldSize
    ];
    private _radius = selectMax size _location * 2;
    _area = [locationPosition _location, _radius, _radius, 0, false];
};
if (_area isEqualTo []) exitWith {
    diag_log text format ["%1: No area found", _fnc_scriptName];
};

private _areaMarker = [["SHZ_mainMission"], _area, true] call SHZ_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _taskID = [blufor, "", "mainClearZombies", _area # 0, "CREATED", -1, true, "attack"] call SHZ_fnc_taskCreate;

private _killThreshold = 400 + count allPlayers * 10 + floor random 101;
private _kills = createHashMap;
private _getKillCount = {
    private _total = 0;
    {_total = _total + _y} forEach _kills;
    _total
};

private _killEH = addMissionEventHandler [
    "EntityKilled",
    {
        params ["_killed", "_killer", "_instigator"];
        if !([_killed] call SHZ_fnc_isZombie) exitWith {};
        if (isNull _instigator) then {
            // UAV/UGV player operated road kill
            _instigator = UAVControl vehicle _killer # 0;
        };
        if (isNull _instigator) then {
            // player driven vehicle road kill
            _instigator = _killer;
        };
        if (isNull _instigator || {!isPlayer _instigator}) exitWith {};

        private _uid = getPlayerUID _instigator;
        if (_uid isEqualTo "") exitWith {};

        _thisArgs params ["_area", "_kills"];
        if !(_killed inArea _area) exitWith {};

        _kills set [_uid, (_kills getOrDefault [_uid, 0]) + 1];
    },
    [_area, _kills]
];

while {true} do {
    sleep 10;
    if (call _getKillCount >= _killThreshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };
};

removeMissionEventHandler ["EntityKilled", _killEH];
deleteMarker _areaMarker;
[_fnc_scriptName, keys _kills, 500] call SHZ_fnc_addCompletedMission;
