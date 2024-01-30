/*
Function: SHZ_fnc_msnDownloadIntelLaptopTimer

Description:
    Starts the laptop countdown.

Parameters:
    Object laptop:
        The intel laptop.

Author:
    thegamecracks

*/
params ["_laptop"];

private _duration = _laptop getVariable ["downloadProgress", [0, 60]];
private _area = [getPosATL _laptop, 100, 100, 0, false];
private _condition = [[_laptop], "SHZ_fnc_msnDownloadIntelLaptopTimerCondition"];
private _hasElapsed = [_duration, "$STR_SHZ_defaultTimer", _area, _condition] call SHZ_fnc_displayTimer;
if (!_hasElapsed) exitWith {
    if (hasInterface && {player inArea _area}) then {
        [blufor, "HQ"] sideChat localize "$STR_SHZ_downloadIntelLaptop_interrupted";
    };
    _laptop setVariable ["downloadStarted", false];
};
_laptop setVariable ["downloadEnded", true];

if (hasInterface) then {
    if (player inArea _area) then {
        [blufor, "HQ"] sideChat localize "$STR_SHZ_downloadIntelLaptop_ended_inArea";
    } else {
        [blufor, "HQ"] sideChat localize "$STR_SHZ_downloadIntelLaptop_ended";
    };
};
