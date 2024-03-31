/*
Function: SHZ_fnc_initUnflipAction

Description:
    Adds an action to unflip vehicles.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

[
    player,
    localize "$STR_SHZ_initUnflipAction_title",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff1_ca.paa",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff2_ca.paa",
    "isNull objectParent _this && {call SHZ_fnc_isLookingAtFlippedVehicle}",
    "true",
    {},
    {},
    {[cursorObject] remoteExec ["SHZ_fnc_unflipVehicle", cursorObject]},
    {},
    [],
    10,
    1000,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;
