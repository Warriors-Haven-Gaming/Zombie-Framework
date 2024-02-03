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

Returns:
    Number
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
params ["_vehicle", "_player", "_money"];

_vehicle setVariable ["SHZ_vehicleRefund_player", _player];
_vehicle setVariable ["SHZ_vehicleRefund_money", _money];
private _index = _vehicle addEventHandler ["Killed", {
    params ["_vehicle"];
    private _player = _vehicle getVariable "SHZ_vehicleRefund_player";
    private _money = _vehicle getVariable "SHZ_vehicleRefund_money";
    private _uid = getPlayerUID _player;
    if (_uid isEqualTo "") exitWith {};
    [_uid, _money] call SHZ_fnc_addMoney;
    [_vehicle, _money] remoteExec ["SHZ_fnc_showVehicleRefund", _player];
}];
SHZ_vehicleRefundHandlers pushBack [diag_tickTime, _vehicle, [["Killed", _index]]];
