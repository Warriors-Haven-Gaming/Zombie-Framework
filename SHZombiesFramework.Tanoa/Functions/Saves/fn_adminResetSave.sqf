/*
Function: SHZ_fnc_adminResetSave

Description:
    Resets the current save.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The admin requesting the current save to be reset.
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

diag_log text format ["Admin %1 (%2) requested reset save", name _player, getPlayerUID _player];
private _saves = missionProfileNamespace getVariable "SHZ_saves";
if (!isNil "_saves") then {
    _saves deleteAt SHZ_saveName;
    saveMissionProfileNamespace;
    diag_log text format ["Save %1 has been reset", SHZ_saveName];
};

// TODO: proper response function for SHZ_fnc_adminResetSave
["The current save has been reset!"] remoteExec ["hint", remoteExecutedOwner];
