/*
Function: SHZ_fnc_showInsufficientFunds

Description:
    Shows that the player does not have enough money.
    Function must be remote executed on client from the server.

Parameters:
    Number current:
        The player's available money.
    Number required:
        The amount of money required.
    String item:
        (Optional, default "$STR_SHZ_showInsufficientFunds_defaultItem")
        The name of the item or service that could not be purchased.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params [
    "_current",
    "_required",
    ["_item", "$STR_SHZ_showInsufficientFunds_defaultItem"]
];
if (_item select [0,1] isEqualTo "$") then {_item = localize _item};
hint format [localize "$STR_SHZ_showInsufficientFunds", _item, _required, _current];
