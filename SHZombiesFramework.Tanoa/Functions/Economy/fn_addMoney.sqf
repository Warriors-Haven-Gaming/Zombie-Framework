/*
Function: SHZ_fnc_addMoney

Description:
    Adds money to a player.
    Function must be executed on server.

Parameters:
    String uid:
        The player UID to add the money to.
    Number money:
        The money to add.
    Boolean applyMultipliers:
        (Optional, default false)
        If true, the player's current money multiplier will be applied.
    Boolean affectMultipliers:
        (Optional, default false)
        If true, this money counts towards the player's money multiplier.

Returns:
    Number
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid", "_money", ["_applyMultipliers", false], ["_affectMultipliers", false]];

if (_uid isEqualTo "") exitWith {
    diag_log text format ["%1: Passed invalid UID", _fnc_scriptName];
};

if (_affectMultipliers && {_money > 0}) then {
    private _oldMoney = SHZ_moneyMultipliers_moneyEarned getOrDefault [_uid, 0];
    SHZ_moneyMultipliers_moneyEarned set [_uid, _oldMoney + _money];
};

if (_applyMultipliers && {_money > 0}) then {
    private _multiplier = SHZ_moneyMultipliers_current getOrDefault [_uid, 1];
    _money = _money * _multiplier;
};

private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
private _newMoney = (_playerMoney getOrDefault [_uid, 0]) + _money max 0;
_playerMoney set [_uid, _newMoney];
_newMoney
