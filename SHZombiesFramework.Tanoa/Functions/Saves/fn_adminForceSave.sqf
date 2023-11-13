/*
Function: SHZ_fnc_adminForceSave

Description:
    Saves the current profile.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The admin requesting the profile to be saved.
        This must be owned by the same client remote executing this function.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (remoteExecutedOwner isEqualTo 0 && {isMultiplayer}) exitWith {};

params ["_player"];
if (!isPlayer _player) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};
if (isMultiplayer && {admin remoteExecutedOwner isEqualTo 0}) exitWith {};

diag_log text format ["Admin %1 (%2) requested force save", name _player, getPlayerUID _player];
saveMissionProfileNamespace;
// TODO: proper response function for SHZ_fnc_adminForceSave
[format ['Successfully saved to "%1"!', SHZ_saveName]] remoteExec ["hint", remoteExecutedOwner];
