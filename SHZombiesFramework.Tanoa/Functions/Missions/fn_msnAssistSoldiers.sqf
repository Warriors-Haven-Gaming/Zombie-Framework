/*
Function: SHZ_fnc_msnAssistSoldiers

Description:
    Players must assist friendly units barricaded in one or more buildings.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default objNull)
        If specified, the given position is used for the mission instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_center", []]];

private _bluforRadius = 50;
private _zombieRadius = 100;
private _minQuantity = 8;
private _maxQuantity = 24;
private _buildings = [];

if (_center isEqualTo []) then {
    private _location = selectRandom nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity"],
        sqrt 2 / 2 * worldSize
    ];
    private _randomPosArgs = [[[locationPosition _location, size _location + [0, false]]]];
    for "_i" from 1 to 30 do {
        private _pos = _randomPosArgs call BIS_fnc_randomPos;
        _buildings = nearestObjects [_pos, ["House", "Building"], _bluforRadius, true];

        private _availableQuantity = 0;
        _buildings = _buildings select {
            private _nPos = count (_x buildingPos -1);
            _availableQuantity = _availableQuantity + _nPos;
            _nPos > 0
        };

        if (_availableQuantity < _minQuantity) then {
            _buildings = [];
            continue;
        };

        _center = _pos;
        break;
    };
};

if (count _buildings < 1) exitWith {
    diag_log text format ["%1: No buildings found", _fnc_scriptName];
};

private _buildingPositions = [];
_buildings = _buildings call BIS_fnc_arrayShuffle;
{_buildingPositions append (_x buildingPos -1)} forEach _buildings;

private _quantity =
    _minQuantity
    + floor random (_maxQuantity - _minQuantity + 1)
    min count _buildingPositions;

if (_quantity < 1) exitWith {
    diag_log text format ["%1: No room to spawn soldiers", _fnc_scriptName];
};

private _units = [];
private _group = createGroup blufor;
private _unitTypes = [
    "rhsusf_usmc_marpat_wd_squadleader",
    "rhsusf_usmc_marpat_wd_teamleader",
    "rhsusf_usmc_marpat_wd_autorifleman",
    "rhsusf_usmc_marpat_wd_rifleman_m4",
    "rhsusf_usmc_marpat_wd_riflemanat",
    "rhsusf_usmc_marpat_wd_marksman"
];
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, [0,0,0], [], 50, "NONE"];
    _units pushBack _unit;
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;
    _unit setPosATL (_buildingPositions select _i - 1);
    if (random 1 < 0.5) then {doStop _unit};
    _unit setVariable ["SHZ_disableAmbientHordes", true, true];
    _unit setVariable ["SHZ_hiddenFromMap", true, true];
};
_group setBehaviourStrong "COMBAT";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};

private _taskID = [blufor, "", "assistSoldiers", _center, "CREATED", -1, true, "help"] call SHZ_fnc_taskCreate;

private _activationArea = [_center, _zombieRadius, _zombieRadius, 0, false, 20];
private _safezone = [_activationArea, true] call SHZ_fnc_createSafezone;
_safezone setMarkerBrushLocal "FDiagonal";
_safezone setMarkerColorLocal "ColorRed";
_safezone setMarkerAlpha 0.7;
private _participants = [];
private _spawnerScript = [
    blufor,
    _activationArea,
    40 + floor (count allPlayers * 0.5),
    _quantity * 10 + count allPlayers * 3 min 300,
    [
        40,
        "mixed",
        SHZ_zombieSide,
        [0,0,0],
        30,
        0.25 + random 0.75,
        [[_participants, SHZ_fnc_addParticipantHandler]]
    ],
    [_bluforRadius, _zombieRadius],
    0,
    20,
    10
] spawn SHZ_fnc_hordeSpawnLoop;

private _succeeded = false;
while {true} do {
    sleep 10;

    if (scriptDone _spawnerScript) exitWith {
        _succeeded = true;
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };

    if (_units findIf {alive _x} isEqualTo -1) exitWith {
        _succeeded = false;
        [_taskID, "FAILED"] spawn SHZ_fnc_taskEnd;
    };
};

if (_succeeded) then {
    [_fnc_scriptName, _participants, 500] call SHZ_fnc_addCompletedMission;
    _safezone setMarkerSizeLocal (markerSize _safezone vectorMultiply [2, 2]);
    _safezone setMarkerBrushLocal "SolidBorder";
    _safezone setMarkerColorLocal "ColorBlue";
    _safezone setMarkerAlpha 0.2;
    _safezone spawn {
        scriptName "SHZ_fnc_msnAssistSoldiers_tempSafezone";
        sleep 1800;
        // TODO: announce safezone disappearing
        deleteMarker _this;
    };
} else {
    deleteMarker _safezone;
    terminate _spawnerScript;
};
[_units] call SHZ_fnc_queueGCDeletion;
