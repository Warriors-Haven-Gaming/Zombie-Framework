/*
Function: SHZ_fnc_initTeamSafezoneHandlers

Description:
    Sets up player damage handlers for team safezones.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "_selection", "", "", "", "", "_instigator"];
    if (isNull _instigator) exitWith {};
    if (!isPlayer _instigator) exitWith {};
    if ([side group _unit, side group _instigator] call BIS_fnc_sideIsEnemy) exitWith {};
    if ([_unit] call SHZ_fnc_inAreaTeamSafezone isEqualTo []) exitWith {};
    _unit getHit _selection
}}];
