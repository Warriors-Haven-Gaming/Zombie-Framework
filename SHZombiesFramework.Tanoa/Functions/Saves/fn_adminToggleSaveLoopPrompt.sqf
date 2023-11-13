/*
Function: SHZ_fnc_adminToggleSaveLoopPrompt

Description:
    Prompts the admin to toggle the save loop on or off.
    Function must be remote executed on client from the server.

Parameters:
    Boolean autosaving:
        Indicates whether the server is currently autosaving or not.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};

params ["_autosaving"];
private _result = [
    [
        "Are you sure you want to enable autosaving?",
        "Are you sure you want to disable autosaving?"
    ] select _autosaving,
    "Toggle Autosaving",
    true,
    true
] call BIS_fnc_guiMessage;
if (!_result) exitWith {};
[player, _autosaving] remoteExec ["SHZ_fnc_adminToggleSaveLoopCallback", 2];
