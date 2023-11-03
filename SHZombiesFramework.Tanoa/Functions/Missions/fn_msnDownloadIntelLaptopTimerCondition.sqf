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
params ["_laptopPos"];
units blufor findIf {_x inArea [_laptopPos, 5, 5, 0, false, 5]} >= 0
