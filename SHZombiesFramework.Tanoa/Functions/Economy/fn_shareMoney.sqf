/*
Function: SHZ_fnc_shareMoney

Description:
    Sends money from one player to another player.
    Function must be remote executed on server from a client.

Parameters:
    Object from:
        The player that is sharing their money.
        This must be owned by the same client remote executing this function.
    Object to:
        The player that will be receiving the money.
    Number money:
        The amount of money this player will receive.

Author:
    thegamecracks

*/
params ["_from", "_to", "_money"];
if !([_from] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};
if (_from isEqualTo _to) exitWith {};

private _fromUID = getPlayerUID _from;
private _toUID = getPlayerUID _to;
if (_toUID isEqualTo "") exitWith {};

private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
private _fromMoney = _playerMoney getOrDefault [_fromUID, 0];
if (_fromMoney < _money) exitWith {
    [_money, _fromMoney] remoteExec ["SHZ_fnc_showInsufficientFundsToShare", _from];
};

private _toMoney = _playerMoney getOrDefault [_toUID, 0];

_fromMoney = _fromMoney - _money;
_toMoney = _toMoney + _money;
_playerMoney set [_fromUID, _fromMoney];
_playerMoney set [_toUID, _toMoney];

[_money, _to, _fromMoney] remoteExec ["SHZ_fnc_showSharedMoneyFrom", _from];
[_money, _from, _toMoney] remoteExec ["SHZ_fnc_showSharedMoneyTo", _to];
