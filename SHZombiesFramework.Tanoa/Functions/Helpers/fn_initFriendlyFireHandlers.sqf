/*
Function: SHZ_fnc_initFriendlyFireHandlers

Description:
    Sets up player damage handlers for friendly fire.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "", "", "", "_hitIndex", "_instigator"];
    if (SHZ_friendlyFire_recruits) exitWith {};
    if (isNull _instigator) exitWith {};
    if (isPlayer _instigator) exitWith {};
    if (_instigator getVariable ["SHZ_recruitOwnedBy", ""] isEqualTo "") exitWith {};
    if ([side group _unit, side group _instigator] call BIS_fnc_sideIsEnemy) exitWith {};
    if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit}
}}];
