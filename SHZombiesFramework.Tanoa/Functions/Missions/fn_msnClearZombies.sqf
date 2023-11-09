/*
Function: SHZ_fnc_msnClearZombies

Description:
    Players must clear out zombies from an area.
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
if (_center isEqualTo []) exitWith {};

private _taskID = [blufor, "", "clearZombies", _center, "CREATED", -1, true, "kill"] call SHZ_fnc_taskCreate;

private _activationArea = [_center, 100, 100, 0, false, 20];
private _safezone = [_activationArea, true] call SHZ_fnc_createSafezone;
_safezone setMarkerBrushLocal "FDiagonal";
_safezone setMarkerColorLocal "ColorRed";
_safezone setMarkerAlpha 0.7;
private _spawnerScript = [
    blufor,
    _activationArea,
    40 + count allPlayers,
    100 + floor (count allPlayers * 3.6),
    [20 + floor (count allPlayers * 0.5), "mixed", SHZ_zombieSide, [0,0,0], 10, 0.25 + random 0.75],
    100,
    5,
    30,
    10
] spawn SHZ_fnc_hordeSpawnLoop;

while {true} do {
    sleep 10;
    if (scriptDone _spawnerScript) exitWith {
        [_taskID, "SUCCEEDED"] call SHZ_fnc_taskEnd;
    };
};
_safezone setMarkerSizeLocal (markerSize _safezone vectorMultiply [2, 2]);
_safezone setMarkerBrushLocal "SolidBorder";
_safezone setMarkerColorLocal "ColorBlue";
_safezone setMarkerAlpha 0.2;
_safezone spawn {sleep 1800; deleteMarker _this}; // TODO: announce safezone disappearing
