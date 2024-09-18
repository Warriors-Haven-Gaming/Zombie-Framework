/*
Script: XEH_preInit.sqf

Description:
    Executed globally when CBA is loaded.
    https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

Author:
    thegamecracks

*/

// Parameters:
//     _setting     - Unique setting name. Matches resulting variable name <STRING>
//     _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
//     _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
//     _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
//     _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
//     _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
//     _script      - Script to execute when setting is changed. (optional) <CODE>
//     _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>

// Garbage Collection
[
    "SHZ_gcDeletionDistance",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcDeletionDistance", "STR_SHZ_settings_gc_gcDeletionDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [0, 10000, 500, 0, false],
    true,
    {},
    false
] call CBA_fnc_addSetting;
[
    "SHZ_gcUnhideDistance",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcUnhideDistance", "STR_SHZ_settings_gc_gcUnhideDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [0, 10000, 500, 0, false],
    true,
    {},
    false
] call CBA_fnc_addSetting;
[
    "SHZ_gcZombieDistance",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcZombieDistance", "STR_SHZ_settings_gc_gcZombieDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [0, 10000, 200, 0, false],
    true,
    {},
    false
] call CBA_fnc_addSetting;

// Saves
[
    "SHZ_saveName",
    "EDITBOX",
    ["STR_SHZ_settings_saves_saveName", "STR_SHZ_settings_saves_saveName_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_saves"],
    "default",
    true,
    {},
    false
] call CBA_fnc_addSetting;
