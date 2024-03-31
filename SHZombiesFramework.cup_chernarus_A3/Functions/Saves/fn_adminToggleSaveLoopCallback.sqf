/*
Function: SHZ_fnc_adminToggleSaveLoopCallback

Description:
    Toggles the save loop script.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The admin requesting to toggle the save loop.
        This must be owned by the same client remote executing this function.
    Boolean lastAutosaving:
        Indicates if the server is still autosaving.
        This is used as a sanity check to ensure the save loop is running
        or not running as expected.

Author:
    thegamecracks

*/
if (!call SHZ_fnc_isRemoteExecutedByAdmin) exitWith {};

params ["_player", "_lastAutosaving"];
if (!isPlayer _player) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};

private _autosaving = !scriptDone SHZ_saveScript;
// TODO: proper response function for SHZ_fnc_adminToggleSaveLoopCallback
if (_autosaving && {_lastAutosaving}) exitWith {
    terminate SHZ_saveScript;
    ["autosave", false] call SHZ_fnc_setSaveVariable;
    [
        "Autosaving has been disabled. "
        + "This setting will not persist until the next time you save."
    ] remoteExec ["hint", remoteExecutedOwner];
};

if (!_autosaving && {!_lastAutosaving}) exitWith {
    SHZ_saveScript = 0 spawn SHZ_fnc_saveLoop;
    ["autosave", true] call SHZ_fnc_setSaveVariable;
    [
        "Autosaving has been enabled. "
        + "This setting will persist after the next save."
    ] remoteExec ["hint", remoteExecutedOwner];
};

[
    "The autosaving state has unexpectedly changed. "
    + "Please try again."
] remoteExec ["hint", remoteExecutedOwner];
