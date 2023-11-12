/*
Function: SHZ_fnc_getSaveVariableDefault

Description:
    Returns the default value for the given save variable.

Parameters:
    String name:
        The name of the variable to return the default value for.

Returns:
    Anything

Author:
    thegamecracks

*/
params ["_name"];
switch (_name) do {
    case "zombieKills": {createHashMap};
    default {nil};
}
