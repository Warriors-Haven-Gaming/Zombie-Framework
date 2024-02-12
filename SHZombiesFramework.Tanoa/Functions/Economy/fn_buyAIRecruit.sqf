/*
Function: SHZ_fnc_buyAIRecruit

Description:
    Buys an AI recruit for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

        The item included in the context should define the following keys:
            String _recruitType:
                The unit type to spawn in.

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

private _groupLimit = 6;
private _playerAICount = {!isPlayer _x} count units _player;
if (_playerAICount >= _groupLimit) exitWith {[
    [_groupLimit],
    "SHZ_fnc_showBuyAIRecruitLimit"
]};

private _group = group _player;
private _unit = _group createUnit [_recruitType, _vehicleSpawn, [], 0, "NONE"];
[_unit] joinSilent _group;
_unit setDir (_vehicleSpawn getDir _player);
_unit setVariable ["SHZ_recruitOwnedBy", getPlayerUID _player, true];
[_unit, "NoVoice"] remoteExec ["setSpeaker", 0, _unit];

[_unit, _player, _item get "_cost", _shopkeeper] call SHZ_fnc_addShopkeeperPurchaseServer;

true
