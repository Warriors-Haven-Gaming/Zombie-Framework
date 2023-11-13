/*
Function: SHZ_fnc_msnDownloadIntel

Description:
    Players must download intel from a research building.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL intelCenter:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_intelCenter",[]]];

private _intelDir = random 360;
if (_intelCenter isEqualTo []) then {
    private _options = selectBestPlaces [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize, "forest", 100, 50];
    {
        _x params ["_pos"];
        _pos pushBack 0;
        if (_pos isFlatEmpty [-1, -1, 0.45, 12] isEqualTo []) then {continue};
        if (_pos nearRoads 50 isNotEqualTo []) then {continue};
        _intelCenter = _pos;
        break;
    } forEach _options;
};
if (_intelCenter isEqualTo []) exitWith {};

private _terrainObjects = nearestTerrainObjects [_intelCenter, [], 20, false];
_terrainObjects apply {hideObjectGlobal _x};

private _intelBuilding = [
    _intelCenter,
    _intelDir,
    [
        ["Land_Research_house_V1_F",[0.899902,-1.85547,-0.00143886],0,1,0,[],"","",true,true],
        ["MapBoard_Tanoa_F",[0.391602,-0.604004,0.591373],172.602,1,0,[],"","",false,true],
        ["Land_PortableDesk_01_olive_F",[-0.393555,0.613281,0.727409],0,1,0,[],"","",false,true],
        ["Land_OfficeChair_01_F",[-0.799805,1.44043,0.727409],300,1,0,[],"","",false,true],
        ["Land_PCSet_Intel_01_F",[-0.316406,0.70459,1.62358],201.424,1,0,[],"","",false,true],
        ["Land_BatteryPack_01_closed_olive_F",[0.03125,0.4375,1.61434],30.2656,1,0,[],"","",false,true],
        ["Land_Document_01_F",[0.0219727,0.81543,1.62358],194.368,1,0,[],"","",false,true],
        ["Land_Laptop_unfolded_F",[0.383789,0.842773,1.61434],334.87,1,0,[],"","",true,true]
    ]
] call SHZ_fnc_objectsMapper;
private _laptop = _intelBuilding # 7;
[_laptop] remoteExec ["SHZ_fnc_msnDownloadIntelLaptop", 0, _laptop];

private _taskID = [blufor, "", "downloadIntel", [_laptop,true], "CREATED", -1, true, "documents"] call SHZ_fnc_taskCreate;

private _spawnerScript = [
    blufor,
    [_intelCenter, 200, 200, 0, false, 20],
    20 + floor (count allPlayers * 0.8),
    60 + floor (count allPlayers * 5.2),
    [10 + floor (count allPlayers / 2), "mixed", SHZ_zombieSide, [0,0,0], 10, 0.5],
    [20, 100],
    5,
    15
] spawn SHZ_fnc_hordeSpawnLoop;

while {true} do {
    sleep 3;
    if (_laptop getVariable ["downloadStarted", false]) then {};
    if (_laptop getVariable ["downloadEnded", false]) exitWith {
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };
};

private _participants = allPlayers inAreaArray [_intelCenter, 100, 100, 0, false, 20];
[_fnc_scriptName, _participants] call SHZ_fnc_addCompletedMission;
[_intelBuilding] call SHZ_fnc_queueGCDeletion;
[_terrainObjects] call SHZ_fnc_queueGCUnhide;
_spawnerScript spawn {
    scriptName "SHZ_fnc_msnDownloadIntel_spawnerTermination";
    sleep 120;
    terminate _this;
};
