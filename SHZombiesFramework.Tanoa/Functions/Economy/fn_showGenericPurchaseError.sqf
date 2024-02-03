/*
Function: SHZ_fnc_showGenericPurchaseError

Description:
    Shows that the player's purchase failed.
    Function must be remote executed on client from the server.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
hint localize "$STR_SHZ_showGenericPurchaseError";
