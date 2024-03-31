/*
Function: SHZ_fnc_zombieImmunityLoop

Description:
    Periodically heals the given unit when necessary.
    Function must be ran in scheduled environment.

Parameters:
    Object unit:
        The unit to be healed.

Author:
    thegamecracks

*/
params ["_unit"];
while {alive _unit} do {
    sleep (0.5 + random 0.5);
    if (damage _unit >= 0.1) then {_unit setDamage 0};
    if (_unit getVariable ["ryanzombiesinfected", 0] > 0) then {
        _unit setVariable ["ryanzombiesinfected", 0, true];
    };
};
