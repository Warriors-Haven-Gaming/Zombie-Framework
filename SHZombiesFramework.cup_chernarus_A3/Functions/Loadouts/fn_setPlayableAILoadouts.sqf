/*
Function: SHZ_fnc_setPlayableAILoadouts

Description:
    Sets all playable AI loadouts.
    Function must be ran on server.

Examples:
    (begin example)
        call SHZ_fnc_setPlayableAILoadouts;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

{
    if (isPlayer _x) then {continue};
    private _loadout = [_x] call SHZ_fnc_getRespawnLoadout;
    if (_loadout isNotEqualTo []) then {_x setUnitLoadout _loadout};
} forEach playableUnits + switchableUnits;
