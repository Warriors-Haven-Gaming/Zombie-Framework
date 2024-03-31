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
        localize "$STR_SHZ_adminToggleSaveLoopPrompt_confirm_enable",
        localize "$STR_SHZ_adminToggleSaveLoopPrompt_confirm_disable"
    ] select _autosaving,
    localize "$STR_SHZ_initAdminBoard_toggleSaveLoop_action",
    true,
    true
] call BIS_fnc_guiMessage;
if (!_result) exitWith {};
[player, _autosaving] remoteExec ["SHZ_fnc_adminToggleSaveLoopCallback", 2];
