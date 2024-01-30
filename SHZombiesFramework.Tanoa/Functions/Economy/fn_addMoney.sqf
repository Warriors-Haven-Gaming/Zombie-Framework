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

Returns:
    Number
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid", "_money"];

if (_uid isEqualTo "") exitWith {
    diag_log text format ["%1: Passed invalid UID", _fnc_scriptName];
};

private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
private _newMoney = (_playerMoney getOrDefault [_uid, 0]) + _money max 0;
_playerMoney set [_uid, _newMoney];
_newMoney
