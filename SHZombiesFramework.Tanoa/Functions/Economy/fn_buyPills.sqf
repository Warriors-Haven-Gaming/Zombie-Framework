/*
Function: SHZ_fnc_buyPills

Description:
    Buys pills for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

Returns:
    Boolean
        True if successful, false otherwise.

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
params ["_context"];
values _context params keys _context;
_player addItem "RyanZombiesAntiVirusTemporary_Item";
true
