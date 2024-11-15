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
if (_type isEqualType objNull) then {_type = typeOf _type};
(
    [_type, "Zombie"] call SHZ_fnc_stringStartsWith
    || {[_type, "WBK_SpecialZombie"] call SHZ_fnc_stringStartsWith}
)
