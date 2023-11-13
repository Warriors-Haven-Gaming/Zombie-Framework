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
    "!isMultiplayer || {call BIS_fnc_admin > 0}"
];
