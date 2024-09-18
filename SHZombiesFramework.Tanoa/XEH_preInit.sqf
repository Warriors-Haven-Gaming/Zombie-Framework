/*
Script: XEH_preInit.sqf

Description:
    Executed globally When CBA is loaded.
    https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

    If CBA is not loaded, this is executed at mission start by init(Server).sqf.
    This is to allow assigning default settings via SHZ_fnc_addSetting.

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
] call SHZ_fnc_addSetting;
[
    "SHZ_gcUnhideDistance",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcUnhideDistance", "STR_SHZ_settings_gc_gcUnhideDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [0, 10000, 500, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_gcZombieDistance",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcZombieDistance", "STR_SHZ_settings_gc_gcZombieDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [0, 10000, 200, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

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
] call SHZ_fnc_addSetting;

// Zombies
[
    "SHZ_loiteringHordeThreshold_delay",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loiteringHordeThreshold_delay", "STR_SHZ_settings_zombies_loiteringHordeThreshold_delay_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [1, 600, 120, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_loiteringHordeThreshold_min",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loiteringHordeThreshold_min", "STR_SHZ_settings_zombies_loiteringHordeThreshold_min_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 500, 40, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_loiteringHordeThreshold_max",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loiteringHordeThreshold_max", "STR_SHZ_settings_zombies_loiteringHordeThreshold_max_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 500, 200, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_loiteringHordeThreshold_playerScale",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loiteringHordeThreshold_playerScale", "STR_SHZ_settings_zombies_loiteringHordeThreshold_playerScale_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 50, 1, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_loiteringHordeThreshold_random",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loiteringHordeThreshold_random", "STR_SHZ_settings_zombies_loiteringHordeThreshold_random_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 100, 20, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
