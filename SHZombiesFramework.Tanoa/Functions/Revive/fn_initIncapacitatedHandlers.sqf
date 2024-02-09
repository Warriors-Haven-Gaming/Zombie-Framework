/*
Function: SHZ_fnc_initIncapacitatedHandlers

Description:
    Sets up player damage handlers for incapacitation.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "_selection"];
    if (lifeState _unit isNotEqualTo "INCAPACITATED") exitWith {};
    _unit getHit _selection
}}];
