/*
Function: SHZ_fnc_showInsufficientFundsToShare

Description:
    Shows that the player does not have enough money to share.
    Function must be remote executed on client from the server.

Parameters:
    Number required:
        The amount of money the player tried to share.
    Number current:
        The player's available money.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_required", "_current"];
hint format [
    localize "$STR_SHZ_showInsufficientFundsToShare",
    _required call SHZ_fnc_formatMoney,
    _current call SHZ_fnc_formatMoney
];
playSoundUI ["a3\missions_f_beta\data\sounds\firing_drills\checkpoint_not_clear.wss"];
