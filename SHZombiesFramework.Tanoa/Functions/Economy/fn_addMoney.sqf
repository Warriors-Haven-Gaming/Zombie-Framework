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

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid", "_money"];

if (_uid isEqualTo "") exitWith {
    diag_log text format ["%1: Passed invalid UID", _fnc_scriptName];
};

private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
_playerMoney set [_uid, (_playerMoney getOrDefault [_uid, 0]) + _money];
