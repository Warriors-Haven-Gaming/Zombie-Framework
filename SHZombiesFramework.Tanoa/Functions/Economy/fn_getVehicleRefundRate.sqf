/*
Function: SHZ_fnc_getVehicleRefundRate

Description:
    Returns the refund rate for a given vehicle purchased at the given time.

Parameters:
    Number time:
        The time at which the vehicle was purchased,
        as returned by diag_tickTime.
    Number now:
        (Optional, default diag_tickTime)
        The current time.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_time", ["_now", diag_tickTime]];
private _minTime = 60;
private _maxTime = 120;
private _maxRate = 1;
private _minRate = 0;
private _elapsed = _now - _time;
if (_elapsed > _maxTime) exitWith {0};
linearConversion [_minTime, _maxTime, _elapsed, _maxRate, _minRate, true]
