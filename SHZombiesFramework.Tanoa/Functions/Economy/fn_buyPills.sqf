/*
Function: SHZ_fnc_buyPills

Description:
    Buys pills for a player.
    Function must be executed on server.

Parameters:
    Object player:
        The player buying this item.
        This must be owned by the same client remote executing this function.
    HashMap context:
        The shopkeeper's context.

Returns:
    Boolean
        True if successful, false otherwise.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_player", "_context"];
_player addItem "RyanZombiesAntiVirusTemporary_Item";
["Successfully bought pills!"] remoteExec ["hint", _player]; // TODO: proper response
true
