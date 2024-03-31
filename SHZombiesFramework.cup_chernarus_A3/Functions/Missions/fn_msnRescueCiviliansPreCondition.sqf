/*
Function: SHZ_fnc_msnRescueCiviliansPreCondition

Description:
    Checks if the Rescue Civilians mission can start.

Returns:
    Boolean

Author:
    thegamecracks

*/
allMapMarkers findIf {[_x, "SHZ_prison"] call SHZ_fnc_stringStartsWith} > -1
