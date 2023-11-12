/*
Function: SHZ_fnc_getSaveVariable

Description:
    Retrieves a variable from the given save.
    If the variable is not set, SHZ_fnc_getSaveVariableDefault is used
    to return a default value.
    Function must be ran on server.

Parameters:
    String name:
        The name of the variable to retrieve.
    String saveName:
        (Optional, default SHZ_saveName)
        The name of the save to retrieve the variable from.

Returns:
    Anything

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_name", ["_saveName", SHZ_saveName]];

private _selectedSave = [_saveName] call SHZ_fnc_getSave;

private _value = _selectedSave get _name;
if (isNil "_value") then {
    _value = [_name] call SHZ_fnc_getSaveVariableDefault;
    _selectedSave set [_name, _value];
};

_value
