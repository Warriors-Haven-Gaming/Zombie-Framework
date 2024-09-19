/*
Function: SHZ_fnc_initUnflipAction

Description:
    Adds an action to unflip vehicles.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "SHZ_unflipActionID") then {
    SHZ_unflipActionID call BIS_fnc_holdActionRemove;
};

private _actionID = [
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
    SHZ_unflip_duration,
    1000,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;

SHZ_unflipActionID = [player, _actionID];
