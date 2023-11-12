/*
Function: SHZ_fnc_setSaveVariable

Description:
    Sets a variable for the given save.
    Function must be ran on server.

Parameters:
    String name:
        The name of the variable to set.
    String saveName:
        (Optional, default SHZ_saveName)
        The name of the save to set the variable for.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_name", "_value", ["_saveName", SHZ_saveName]];

private _selectedSave = [_saveName] call SHZ_fnc_getSave;
_selectedSave set [_name, _value];
