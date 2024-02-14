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
    Array | String tags:
        (Optional, default [])
        A string or array of strings to label the money that is added.
        Any duplicates will be ignored.
        The following tags cannot be used:
            "TOTAL"
    Boolean applyMultipliers:
        (Optional, default false)
        If true, the player's current money multiplier will be applied
        to however much money the player will have available. This has
        no effect on the stats tracked in the SHZ_moneyEarned hashmap
        other than the "TOTAL" key.

Returns:
    Number
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid", "_money", ["_tags", []], ["_applyMultipliers", false]];

if (_uid isEqualTo "") exitWith {
    diag_log text format ["%1: Passed invalid UID", _fnc_scriptName];
};

if !(_tags isEqualType []) then {_tags = [_tags]};
_tags = _tags select {!(_x in ["TOTAL"])};
_tags = _tags arrayIntersect _tags;

private _moneyEarned = SHZ_moneyEarned getOrDefaultCall [_uid, {createHashMap}, true];
{
    _moneyEarned set [_x, (_moneyEarned getOrDefault [_x, 0]) + _money];
} forEach _tags;

if (_applyMultipliers && {_money > 0}) then {
    private _multiplier = SHZ_moneyMultipliers_current getOrDefault [_uid, 1];
    _money = _money * _multiplier;
};

_moneyEarned set ["TOTAL", _moneyEarned getOrDefault ["TOTAL", 0] + _money];

private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
private _newMoney = (_playerMoney getOrDefault [_uid, 0]) + _money max 0;
_playerMoney set [_uid, _newMoney];
_newMoney
