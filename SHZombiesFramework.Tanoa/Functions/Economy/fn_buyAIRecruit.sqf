/*
Function: SHZ_fnc_buyAIRecruit

Description:
    Buys an AI recruit for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

Returns:
    Array | Boolean
        True if successful, false otherwise.
        An array can also be returned containing the parameters
        and function name to be remote executed on the client.

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
params ["_context"];
values _context params keys _context;

private _recruitType = _item get "_recruitType";
if (isNil "_recruitType") exitWith {false};
if (isNil "_vehicleSpawn") exitWith {false};

// FIXME: proper response for max AI
private _playerAICount = {!isPlayer _x} count units _player;
if (_playerAICount > 6) exitWith {false};

private _group = group _player;
private _unit = _group createUnit [_recruitType, _vehicleSpawn, [], 0, "NONE"];
[_unit] joinSilent _group;
_unit setDir (_vehicleSpawn getDir _player);

true
