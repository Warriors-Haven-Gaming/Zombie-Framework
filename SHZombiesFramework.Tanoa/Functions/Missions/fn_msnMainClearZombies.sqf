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

private _killCountMarker = [
    ["SHZ_mainMission_killCount"],
    _area # 0 vectorAdd [_area # 1 + 50, 0, 0]
] call SHZ_fnc_createLocalMarker;
_killCountMarker setMarkerColorLocal "ColorRed";
_killCountMarker setMarkerTypeLocal "KIA";
_killCountMarker setMarkerAlpha 0.7;

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

private _lastKillCount = -1;
private _lastKillCountTime = -1;
while {true} do {
    sleep 10;

    private _now = diag_tickTime;
    private _killCount = call _getKillCount;

    if (_killCount >= _killThreshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };

    if (_now >= _lastKillCountTime + 30 && {_killCount isNotEqualTo _lastKillCount}) then {
        _lastKillCount = _killCount;
        _lastKillCountTime = _now;
        [_killCountMarker, _killCount, _killThreshold] remoteExec [
            "SHZ_fnc_updateKillCountMarker",
            [0, -2] select isDedicated
        ];
    };
};

removeMissionEventHandler ["EntityKilled", _killEH];
deleteMarker _areaMarker;
deleteMarker _killCountMarker;
[_fnc_scriptName, keys _kills, 500] call SHZ_fnc_addCompletedMission;
