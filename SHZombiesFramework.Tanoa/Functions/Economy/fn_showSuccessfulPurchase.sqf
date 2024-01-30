/*
Function: SHZ_fnc_showSuccessfulPurchase

Description:
    Shows a successful purchase for the given context.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_context"];
values _context params keys _context;
hint format [
    localize "$STR_SHZ_showSuccessfulPurchase",
    _item get "_displayName",
    _money
];
playSoundUI ["a3\3den\data\sound\cfgsound\notificationdefault.wss"];
