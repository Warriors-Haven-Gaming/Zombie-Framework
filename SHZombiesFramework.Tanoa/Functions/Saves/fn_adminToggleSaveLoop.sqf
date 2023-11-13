/*
Function: SHZ_fnc_adminToggleSaveLoop

Description:
    Prompts the user if they want to toggle the save loop script.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The admin requesting to toggle the save loop.
        This must be owned by the same client remote executing this function.

Author:
    thegamecracks

*/
if (!call SHZ_fnc_isRemoteExecutedByAdmin) exitWith {};

params ["_player"];
if (!isPlayer _player) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};

[!scriptDone SHZ_saveScript] remoteExec ["SHZ_fnc_adminToggleSaveLoopPrompt", remoteExecutedOwner];
