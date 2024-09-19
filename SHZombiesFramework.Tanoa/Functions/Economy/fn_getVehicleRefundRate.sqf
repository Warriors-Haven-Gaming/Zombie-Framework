/*
Function: SHZ_fnc_getVehicleRefundRate

Description:
    Returns the refund rate for a given vehicle purchased at the given time.

Parameters:
    Number time:
        The time at which the vehicle was purchased,
        based on the time command.
    Number now:
        (Optional, default time)
        The current time.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_time", ["_now", time]];
private _minTime = SHZ_vehicleRefund_minTime;
private _maxTime = SHZ_vehicleRefund_maxTime;
private _maxRate = SHZ_vehicleRefund_maxRate;
private _minRate = 0;
private _elapsed = _now - _time;
if (_elapsed > _maxTime) exitWith {0};
linearConversion [_minTime, _maxTime, _elapsed, _maxRate, _minRate, true]
