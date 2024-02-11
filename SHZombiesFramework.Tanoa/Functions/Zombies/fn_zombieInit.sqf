/*
Function: SHZ_fnc_zombieInit

Description:
    Initializes a spawned zombie.

Parameters:
    Object _unit:
        The zombie that was spawned.

Examples:
    (begin example)
        [_unit] remoteExec ["SHZ_fnc_zombieInit", 0];
    (end)

Author:
    thegamecracks

*/
params ["_unit"];
_unit setSkill 1;
if (isNil "ryanzombiesstartinganim") then {
    _unit switchMove "AmovPercMstpSnonWnonDnon_SaluteOut";
};
