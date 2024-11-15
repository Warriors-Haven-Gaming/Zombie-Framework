/*
Function: SHZ_fnc_msnClearSpecials

Description:
    Players must clear out special infected from an area.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the mission instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_center", []]];

if (_center isEqualTo []) then {
    private _options = selectBestPlaces [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize, "houses", 100, 50];
    {
        _x params ["_pos", "_expr"];
        if (_expr < 0.8) then {continue};
        _pos pushBack 0;
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

private _taskID = [blufor, "", "clearSpecials", _center, "CREATED", -1, true, "danger"] call SHZ_fnc_taskCreate;

private _activationArea = [_center, 200, 200, 0, false, 20];
private _areaMarker = [
    [_fnc_scriptName + "_area_"],
    _activationArea,
    true
] call SHZ_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;
private _participants = [];
private _spawnerScript = [
    blufor,
    _activationArea,
    10 + count allPlayers,
    20 + count allPlayers * 2 min 100,
    [
        5 + floor (count allPlayers * 0.5),
        "specials",
        SHZ_zombieSide,
        [0,0,0],
        10,
        0.25 + random 0.75,
        [[_participants, SHZ_fnc_addParticipantHandler]]
    ],
    100,
    5,
    20,
    5
] spawn SHZ_fnc_hordeSpawnLoop;

while {true} do {
    sleep 10;
    if (scriptDone _spawnerScript) exitWith {
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };
};

[_fnc_scriptName, _participants, 500] call SHZ_fnc_addCompletedMission;

deleteMarker _areaMarker;
private _safezone = [_activationArea, true] call SHZ_fnc_createSafezone;
_safezone setMarkerSizeLocal (markerSize _safezone vectorMultiply [2, 2]);
_safezone setMarkerBrushLocal "SolidBorder";
_safezone setMarkerColorLocal "ColorBlue";
_safezone setMarkerAlpha 0.2;
_safezone spawn {
    scriptName "SHZ_fnc_msnClearSpecials_tempSafezone";
    sleep 1800;
    // TODO: announce safezone disappearing
    deleteMarker _this;
};
