/*
Function: SHZ_fnc_addVehicleRefund

Description:
    Adds a refund handler to the given vehicle for when it gets destroyed.
    This handler can be automatically removed by SHZ_fnc_vehicleRefundLoop.
    Only one handler can be added to a vehicle at a time.

Parameters:
    Object vehicle:
        The vehicle to add the handler to.
    Object player:
        The player that owns the vehicle.
    Number money:
        The money to refund the player when the vehicle is destroyed.

Author:
    thegamecracks

*/
params ["_vehicle", "_player", "_money"];
if (isNull _vehicle) exitWith {};

private _time = time;
_vehicle setVariable ["SHZ_vehicleRefund_time", _time];
_vehicle setVariable ["SHZ_vehicleRefund_player", _player];
_vehicle setVariable ["SHZ_vehicleRefund_money", _money];

private _refundHandler = {
    params ["_vehicle"];
    private _time = _vehicle getVariable "SHZ_vehicleRefund_time";
    private _player = _vehicle getVariable "SHZ_vehicleRefund_player";
    private _money = _vehicle getVariable "SHZ_vehicleRefund_money";

    private _uid = getPlayerUID _player;
    if (_uid isEqualTo "") exitWith {};

    private _rate = [_time] call SHZ_fnc_getVehicleRefundRate;
    if (_rate <= 0) exitWith {};
    _money = ceil (_money * _rate);

    [_uid, _money] call SHZ_fnc_addMoney;
    [_vehicle, _money, _rate] remoteExec ["SHZ_fnc_showVehicleRefund", _player];
};

if (!alive _vehicle) exitWith {
    [_vehicle] call _refundHandler;
};

private _index = _vehicle addEventHandler ["Killed", _refundHandler];
SHZ_vehicleRefund_handlers pushBack [_time, _vehicle, [["Killed", _index]]];
