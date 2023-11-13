/*
Function: SHZ_fnc_initAdminBoard

Description:
    Initializes the given object as an administrative board.

Parameters:
    Object obj:
        The object to initialize.

Author:
    thegamecracks

*/
params ["_obj"];

private _condition = "isServer || {call BIS_fnc_admin > 0}";

_obj addAction [
    "Toggle Autosaving",
    {
        params ["_target", "_caller"];
        [_caller] remoteExec ["SHZ_fnc_adminToggleSaveLoop", 2];
    },
    [],
    1.5,
    true,
    true,
    "",
    _condition
];
_obj addAction [
    "Save Now",
    {
        params ["_target", "_caller"];
        private _result = [
            "Are you sure you want to save?",
            "Save Now",
            true,
            true
        ] call BIS_fnc_guiMessage;
        if (!_result) exitWith {};
        [_caller] remoteExec ["SHZ_fnc_adminForceSave", 2];
    },
    [],
    1.5,
    true,
    true,
    "",
    _condition
];
_obj addAction [
    "Reset Current Save",
    {
        params ["_target", "_caller"];
        private _result = [
            "Are you sure you want to reset the current save?",
            "Reset Current Save",
            true,
            true
        ] call BIS_fnc_guiMessage;
        if (!_result) exitWith {};
        [_caller] remoteExec ["SHZ_fnc_adminResetSave", 2];
    },
    [],
    1.5,
    true,
    true,
    "",
    _condition
];
