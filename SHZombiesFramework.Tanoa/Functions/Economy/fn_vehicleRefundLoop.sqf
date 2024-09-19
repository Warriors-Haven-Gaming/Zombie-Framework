/*
Function: SHZ_fnc_vehicleRefundLoop

Description:
    Periodically checks which vehicles can be refunded.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _shouldRemoveHandler = {
    params ["_time", "_vehicle"];
    if (isNull _vehicle) exitWith {true};
    if ([_now, _time] call SHZ_fnc_getVehicleRefundRate <= 0) exitWith {true};
    if (
        !SHZ_vehicleRefund_safezone
        && {[_vehicle] call SHZ_fnc_inAreaTeamSafezone isEqualTo []}
    ) exitWith {true};
    false
};

while {true} do {
    private _now = time;
    private _processed = [];
    {
        _x params ["_time", "_vehicle", "_eventHandlers"];
        if !([_time, _vehicle] call _shouldRemoveHandler) then {continue};
        {_vehicle removeEventHandler _x} forEach _eventHandlers;
        _processed pushBack _forEachIndex;
    } forEach SHZ_vehicleRefund_handlers;
    {SHZ_vehicleRefund_handlers deleteAt _x} forEachReversed _processed;
    sleep 10;
};
