/*
Function: SHZ_fnc_updateKillCountMarker

Description:
    Locally updates the kill count text for the given marker.

Parameters:
    String marker:
        The marker to update the text for.
    Number killCount:
        The current number of kills.
    Number killThreshold:
        The number of kills to reach.

Author:
    thegamecracks

*/
params ["_marker", "_killCount", "_killThreshold"];
private _text = format [
    localize "$STR_SHZ_updateKillCountMarker",
    _killCount,
    _killThreshold
];
_marker setMarkerTextLocal _text;
