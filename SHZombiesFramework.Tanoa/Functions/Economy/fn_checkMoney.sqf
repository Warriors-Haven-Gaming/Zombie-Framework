/*
Function: SHZ_fnc_checkMoney

Description:
    Gets the player's money and checks if they have sufficient money.
    If they do not have enough money, SHZ_fnc_showInsufficientFunds
    will be remote executed on the player.
    Function must be executed on server.

Parameters:
    Object player:
        The player to check the money for.
        This is assumed to have a valid UID.
    Number required:
        The amount of money required.
    String item:
        (Optional, default "$STR_SHZ_showInsufficientFunds_defaultItem")
        The name of the item or service that this money is needed for.

Returns:
    Number | Nothing
        The amount of money they have, or nothing if their money was
        insufficient or was executed on client.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params [
    "_player",
    "_required",
    ["_item", "$STR_SHZ_showInsufficientFunds_defaultItem"]
];

private _uid = getPlayerUID _player;
private _money = ["playerMoney"] call SHZ_fnc_getSaveVariable getOrDefault [_uid, 0];

if (_money >= _required) then {_money} else {
    [_money, _required, _item] remoteExec ["SHZ_fnc_showInsufficientFunds", _player];
    nil
}
