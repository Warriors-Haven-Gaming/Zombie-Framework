/*
Function: SHZ_fnc_isZombie

Description:
    Checks if the given object or class is a zombie.

Parameters:
    Object | String type:
        The type to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_type"];
[
    "RyanZombieCivilian_F",
    "RyanZombieB_Soldier_base_F"
] findIf {_type isKindOf _x} isNotEqualTo -1
