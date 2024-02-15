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

if (local _obj && {_obj isKindOf "Man"}) then {
    _obj setCaptive true;
    _obj spawn SHZ_fnc_zombieImmunityLoop;
};
if (!hasInterface) exitWith {};

private _condition = "isServer || {call BIS_fnc_admin > 0}";

_obj addAction [
    localize "$STR_SHZ_initAdminBoard_toggleSaveLoop_action",
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
    localize "$STR_SHZ_initAdminBoard_forceSave_action",
    {
        params ["_target", "_caller"];
        private _result = [
            localize "$STR_SHZ_initAdminBoard_forceSave_confirm",
            localize "$STR_SHZ_initAdminBoard_forceSave_action",
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
    localize "$STR_SHZ_initAdminBoard_resetSave_action",
    {
        params ["_target", "_caller"];
        private _result = [
            localize "$STR_SHZ_initAdminBoard_resetSave_confirm",
            localize "$STR_SHZ_initAdminBoard_resetSave_action",
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
