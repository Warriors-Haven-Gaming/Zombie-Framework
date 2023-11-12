/*
Function: SHZ_fnc_getSave

Description:
    Retrieves the given save from missionProfileNamespace.
    Function must be ran on server.

Parameters:
    String saveName:
        (Optional, default SHZ_saveName)
        The name of the save to retrieve.

Returns:
    HashMap

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params [["_saveName", SHZ_saveName]];

private _saves = missionProfileNamespace getVariable "SHZ_saves";
if (isNil "_saves") then {
    _saves = createHashMap;
    missionProfileNamespace setVariable ["SHZ_saves", _saves];
};

private _selectedSave = _saves get _saveName;
if (isNil "_selectedSave") then {
    _selectedSave = createHashMap;
    _saves set [_saveName, _selectedSave];
};

_selectedSave
