/*
Function: SHZ_fnc_msnDownloadIntelLaptopTimerCondition

Description:
    The laptop condition required to maintain download.

Parameters:
    Position2D laptopPos:
        The intel laptop's position.

Author:
    thegamecracks

*/
params ["", "", "_args"];
_args params ["_laptopPos"];
[units blufor, [_laptopPos, 5, 5, 0, false, 5]] call SHZ_fnc_anyInArea
