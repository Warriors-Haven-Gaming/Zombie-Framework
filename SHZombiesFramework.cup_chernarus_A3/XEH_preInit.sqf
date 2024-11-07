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

// Economy
[
    "SHZ_moneyMultipliers_base",
    "SLIDER",
    ["STR_SHZ_settings_economy_moneyMultipliers_base", "STR_SHZ_settings_economy_moneyMultipliers_base_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 10, 1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_moneyMultipliers_rates_dark",
    "SLIDER",
    ["STR_SHZ_settings_economy_moneyMultipliers_rates_dark", "STR_SHZ_settings_economy_moneyMultipliers_rates_dark_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 10, 0.5, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_moneyMultipliers_rates_normal",
    "SLIDER",
    ["STR_SHZ_settings_economy_moneyMultipliers_rates_normal", "STR_SHZ_settings_economy_moneyMultipliers_rates_normal_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 1000, 20, 0, false],
    true,
    {
        if (isNil "SHZ_moneyMultipliers_rates") then {
            SHZ_moneyMultipliers_rates = createHashMap;
        };
        SHZ_moneyMultipliers_rates set ["NORMAL", _this / 100000];
    },
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_moneyMultipliers_rates_onFoot",
    "SLIDER",
    ["STR_SHZ_settings_economy_moneyMultipliers_rates_onFoot", "STR_SHZ_settings_economy_moneyMultipliers_rates_onFoot_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 1000, 20, 0, false],
    true,
    {
        if (isNil "SHZ_moneyMultipliers_rates") then {
            SHZ_moneyMultipliers_rates = createHashMap;
        };
        SHZ_moneyMultipliers_rates set ["ON_FOOT", _this / 100000];
    },
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_refundShopkeeperPurchase_maxTime",
    "SLIDER",
    ["STR_SHZ_settings_economy_refundShopkeeperPurchase_maxTime", "STR_SHZ_settings_economy_refundShopkeeperPurchase_maxTime_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 3600, 120, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_vehicleRefund_minTime",
    "SLIDER",
    ["STR_SHZ_settings_economy_vehicleRefund_minTime", "STR_SHZ_settings_economy_vehicleRefund_minTime_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 3600, 60, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_vehicleRefund_maxTime",
    "SLIDER",
    ["STR_SHZ_settings_economy_vehicleRefund_maxTime", "STR_SHZ_settings_economy_vehicleRefund_maxTime_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 3600, 120, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_vehicleRefund_maxRate",
    "SLIDER",
    ["STR_SHZ_settings_economy_vehicleRefund_maxRate", "STR_SHZ_settings_economy_vehicleRefund_maxRate_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    [0, 1, 1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_vehicleRefund_safezone",
    "CHECKBOX",
    ["STR_SHZ_settings_economy_vehicleRefund_safezone", "STR_SHZ_settings_economy_vehicleRefund_safezone_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_economy"],
    false,
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Friendly Fire
[
    "SHZ_friendlyFire_recruits",
    "CHECKBOX",
    ["STR_SHZ_settings_friendlyFire_recruits", "STR_SHZ_settings_friendlyFire_recruits_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_friendlyFire"],
    false,
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_friendlyFire_teamSafezone",
    "CHECKBOX",
    ["STR_SHZ_settings_friendlyFire_teamSafezone", "STR_SHZ_settings_friendlyFire_teamSafezone_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_friendlyFire"],
    false,
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Garbage Collection
[
    "SHZ_gcLootLifetime",
    "SLIDER",
    ["STR_SHZ_settings_gc_gcLootLifetime", "STR_SHZ_settings_gc_gcLootLifetime_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_gc"],
    [30, 3600, 300, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
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

// Loadouts
[
    "SHZ_loadouts_saveOnDeath",
    "CHECKBOX",
    ["STR_SHZ_settings_loadouts_saveOnDeath", "STR_SHZ_settings_loadouts_saveOnDeath_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_loadouts"],
    true,
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_loadouts_saveOnArsenal",
    "CHECKBOX",
    ["STR_SHZ_settings_loadouts_saveOnArsenal", "STR_SHZ_settings_loadouts_saveOnArsenal_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_loadouts"],
    true,
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Locks
[
    "SHZ_vehicleLock_enabled",
    "CHECKBOX",
    ["STR_SHZ_settings_locks_vehicleLock_enabled", "STR_SHZ_settings_locks_vehicleLock_enabled_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_locks"],
    true,
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_vehicleLock_useACE",
    "CHECKBOX",
    ["STR_SHZ_settings_locks_vehicleLock_useACE", "STR_SHZ_settings_locks_vehicleLock_useACE_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_locks"],
    true,
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Missions
[
    "SHZ_missions_main_min",
    "SLIDER",
    ["STR_SHZ_settings_missions_mainMissions_min", "STR_SHZ_settings_missions_mainMissions_min_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_missions"],
    [0, 10, 1, 0, false],
    true,
    {SHZ_missions_main_min = round SHZ_missions_main_min},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_missions_main_max",
    "SLIDER",
    ["STR_SHZ_settings_missions_mainMissions_max", "STR_SHZ_settings_missions_mainMissions_max_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_missions"],
    [1, 10, 1, 0, false],
    true,
    {SHZ_missions_main_max = round SHZ_missions_main_max},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_missions_side_min",
    "SLIDER",
    ["STR_SHZ_settings_missions_sideMissions_min", "STR_SHZ_settings_missions_sideMissions_min_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_missions"],
    [0, 50, 6, 0, false],
    true,
    {SHZ_missions_side_min = round SHZ_missions_side_min},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_missions_side_max",
    "SLIDER",
    ["STR_SHZ_settings_missions_sideMissions_max", "STR_SHZ_settings_missions_sideMissions_max_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_missions"],
    [1, 50, 15, 0, false],
    true,
    {SHZ_missions_side_max = round SHZ_missions_side_max},
    true
] call SHZ_fnc_addSetting;

// Music
[
    "SHZ_musicEnabled",
    "CHECKBOX",
    ["STR_SHZ_settings_music_musicEnabled", "STR_SHZ_settings_music_musicEnabled_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_music"],
    true,
    true,
    {
        if (!hasInterface) exitWith {};
        if (_this) exitWith {call SHZ_fnc_musicStartPlaylist};

        if (!isNil "SHZ_musicPlaylistEH") then {
            removeMusicEventHandler SHZ_musicPlaylistEH;
            SHZ_musicPlaylist = nil;
            SHZ_musicPlaylistEH = nil;
        };
        // NOTE: this can interrupt music from any source.
        playMusic "";
    },
    false
] call SHZ_fnc_addSetting;

// Recruits
[
    "SHZ_recruits_limit",
    "SLIDER",
    ["STR_SHZ_settings_recruits_limit", "STR_SHZ_settings_recruits_limit_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_recruits"],
    [0, 50, 6, 0, false],
    true,
    {SHZ_recruits_limit = round SHZ_recruits_limit},
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
[
    "SHZ_saveDelay",
    "SLIDER",
    ["STR_SHZ_settings_saves_saveDelay", "STR_SHZ_settings_saves_saveDelay_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_saves"],
    [60, 3600, 300, 0, false],
    true,
    {
        if (!isServer) exitWith {};
        if (isNil "SHZ_saveScript" || {scriptDone SHZ_saveScript}) exitWith {};
        terminate SHZ_saveScript;
        SHZ_saveScript = 0 spawn SHZ_fnc_saveLoop;
    },
    false
] call SHZ_fnc_addSetting;

// Self Revive
[
    "SHZ_selfRevive_minTime",
    "SLIDER",
    ["STR_SHZ_settings_selfRevive_minTime", "STR_SHZ_settings_selfRevive_minTime_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_selfRevive"],
    [0, 180, 30, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_selfRevive_duration",
    "SLIDER",
    ["STR_SHZ_settings_selfRevive_duration", "STR_SHZ_settings_selfRevive_duration_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_selfRevive"],
    [0.5, 30, 10, 1, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_selfRevive_FAKs",
    "LIST",
    ["STR_SHZ_settings_selfRevive_FAKs", "STR_SHZ_settings_selfRevive_FAKs_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_selfRevive"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [], 4],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Unflip
[
    "SHZ_unflip_duration",
    "SLIDER",
    ["STR_SHZ_settings_unflip_duration", "STR_SHZ_settings_unflip_duration_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_unflip"],
    [0, 30, 10, 0, false],
    true,
    {call SHZ_fnc_initUnflipAction},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_unflip_angle",
    "SLIDER",
    ["STR_SHZ_settings_unflip_angle", "STR_SHZ_settings_unflip_angle_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_unflip"],
    [-1, 1, 0.1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_unflip_radius",
    "SLIDER",
    ["STR_SHZ_settings_unflip_radius", "STR_SHZ_settings_unflip_radius_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_unflip"],
    [5, 50, 25, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Vehicle Wrecks
[
    "SHZ_wrecks_enabled",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_enabled", "STR_SHZ_settings_wrecks_enabled_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    true,
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_density",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_density", "STR_SHZ_settings_wrecks_density_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    [10, 100, 50, 0, false],
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_townFactor",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_townFactor", "STR_SHZ_settings_wrecks_townFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    [1, 20, 5, 1, false],
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_townFactor_distance",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_townFactor_distance", "STR_SHZ_settings_wrecks_townFactor_distance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    [100, 2500, 1000, 0, false],
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_rightHandDrive",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_rightHandDrive", "STR_SHZ_settings_wrecks_rightHandDrive_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    true,
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_safezones",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_safezones", "STR_SHZ_settings_wrecks_safezones_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    false,
    true,
    {},
    true
] call SHZ_fnc_addSetting;
[
    "SHZ_wrecks_vehicleTypes",
    "EDITBOX",
    ["STR_SHZ_settings_wrecks_vehicleTypes", "STR_SHZ_settings_wrecks_vehicleTypes_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_wrecks"],
    '["Land_Wreck_Car_F", "Land_Wreck_Car2_F", "Land_Wreck_Car3_F", "Land_Wreck_CarDismantled_F", "Land_Wreck_HMMWV_F", "Land_Wreck_Hunter_F", "Land_Wreck_Offroad_F", "Land_Wreck_Offroad2_F", "Land_Wreck_Skodovka_F", "Land_Wreck_Truck_dropside_F", "Land_Wreck_Truck_F", "Land_Wreck_Van_F"]',
    true,
    {
        SHZ_wrecks_vehicleTypes = parseSimpleArray _this;
    },
    true
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
[
    "SHZ_ambientHordeLoop_maxAltitude",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_maxAltitude", "STR_SHZ_settings_zombies_ambientHordeLoop_maxAltitude_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 500, 30, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_ignoreSafezone",
    "CHECKBOX",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_ignoreSafezone", "STR_SHZ_settings_zombies_ambientHordeLoop_ignoreSafezone_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    false,
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_speedFactor",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_speedFactor", "STR_SHZ_settings_zombies_ambientHordeLoop_speedFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [10, 1235, 130, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_engineFactor",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_engineFactor", "STR_SHZ_settings_zombies_ambientHordeLoop_engineFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 1, 0.1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_headlightsFactor",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_headlightsFactor", "STR_SHZ_settings_zombies_ambientHordeLoop_headlightsFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 1, 0.1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_flashlightFactor",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_flashlightFactor", "STR_SHZ_settings_zombies_ambientHordeLoop_flashlightFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 1, 0.05, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_townFactor",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_townFactor", "STR_SHZ_settings_zombies_ambientHordeLoop_townFactor_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 1, 0.2, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_townFactor_maxDistance",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_townFactor_maxDistance", "STR_SHZ_settings_zombies_ambientHordeLoop_townFactor_maxDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 2000, 1000, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_townFactor_minDistance",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_townFactor_minDistance", "STR_SHZ_settings_zombies_ambientHordeLoop_townFactor_minDistance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 2000, 200, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_ambientHordeLoop_minChance",
    "SLIDER",
    ["STR_SHZ_settings_zombies_ambientHordeLoop_minChance", "STR_SHZ_settings_zombies_ambientHordeLoop_minChance_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [0, 1, 0.01, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombieSide",
    "LIST",
    ["STR_SHZ_settings_zombies_zombieSide", "STR_SHZ_settings_zombies_zombieSide_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies"],
    [["independent", "opfor"], ["STR_guerrila", "STR_east"], 0],
    true,
    {SHZ_zombieSide = call compile _this},
    false
] call SHZ_fnc_addSetting;

// Zombie Loot
[
    "SHZ_zombies_loot_FAK",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_FAK", "STR_SHZ_settings_zombies_loot_FAK_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0.1, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_pills",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_pills", "STR_SHZ_settings_zombies_loot_pills_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0.02, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_magazines",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_magazines", "STR_SHZ_settings_zombies_loot_magazines_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0.25, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_magazines_soldier",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_magazines_soldier", "STR_SHZ_settings_zombies_loot_magazines_soldier_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0.5, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_magazines_count",
    "LIST",
    ["STR_SHZ_settings_zombies_loot_magazines_count", "STR_SHZ_settings_zombies_loot_magazines_count_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [], 1 - 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_magazines_count_soldier",
    "LIST",
    ["STR_SHZ_settings_zombies_loot_magazines_count_soldier", "STR_SHZ_settings_zombies_loot_magazines_count_soldier_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [], 5 - 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_weapon",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_weapon", "STR_SHZ_settings_zombies_loot_weapon_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_weapon_soldier",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_weapon_soldier", "STR_SHZ_settings_zombies_loot_weapon_soldier_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [0, 1, 0.05, 0, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_weapon_types",
    "EDITBOX",
    ["STR_SHZ_settings_zombies_loot_weapon_types", "STR_SHZ_settings_zombies_loot_weapon_types_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    '["rhs_weap_m4_carryhandle_m203", "rhs_weap_m27iar_grip", "rhs_weap_m4_carryhandle", "rhs_weap_m240B"]',
    true,
    {
        SHZ_zombies_loot_weapon_types = parseSimpleArray _this;
    },
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_weapon_magazines",
    "LIST",
    ["STR_SHZ_settings_zombies_loot_weapon_magazines", "STR_SHZ_settings_zombies_loot_weapon_magazines_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [], 4],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Zombie Framework (Ryan's Settings)

// Zombie Abilities
[
    "Ryanzombiesjumpstrength",
    "LIST",
    ["STR_SHZ_ryansettings_abilities_Ryanzombiesjumpstrength", "STR_SHZ_ryansettings_abilities_Ryanzombiesjumpstrength_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_abilities"],
    [[nil, 1, 2, 3, -1], ["STR_SHZ_ryansettings_strength_normal", "STR_SHZ_ryansettings_strength_weaker", "STR_SHZ_ryansettings_strength_evenWeaker", "STR_SHZ_ryansettings_strength_weakest", "STR_SHZ_ryansettings_disabled"], 0],
    true,
    {Ryanzombiesjump = [nil, 1] select (isNil "_this" || {_this isNotEqualTo -1})},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesjumpdemonstrength",
    "LIST",
    ["STR_SHZ_ryansettings_abilities_Ryanzombiesjumpdemonstrength", "STR_SHZ_ryansettings_abilities_Ryanzombiesjumpdemonstrength_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_abilities"],
    [[nil, 1, 2, 3, -1], ["STR_SHZ_ryansettings_strength_normal", "STR_SHZ_ryansettings_strength_weaker", "STR_SHZ_ryansettings_strength_evenWeaker", "STR_SHZ_ryansettings_strength_weakest", "STR_SHZ_ryansettings_disabled"], 0],
    true,
    {Ryanzombiesjumpdemon = [nil, 1] select (isNil "_this" || {_this isNotEqualTo -1})},
    false
] call SHZ_fnc_addSetting;

// Difficulty Settings
[
    "Ryanzombiesattackspeed",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesattackspeed", "STR_SHZ_ryansettings_difficulty_Ryanzombiesattackspeed_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [0.25, 5, 2.3, 1, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesattackdistance",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesattackdistance", "STR_SHZ_ryansettings_difficulty_Ryanzombiesattackdistance_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [1, 4, 2, 1, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesdamage",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesdamage", "STR_SHZ_ryansettings_difficulty_Ryanzombiesdamage_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [0.01, 1, 0.1, 1, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesdamagecar",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesdamagecar", "STR_SHZ_ryansettings_difficulty_Ryanzombiesdamagecar_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [0.001, 1, 0.01, 1, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesdamageair",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesdamageair", "STR_SHZ_ryansettings_difficulty_Ryanzombiesdamageair_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [0.001, 1, 0.01, 1, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "Ryanzombiesdamagetank",
    "SLIDER",
    ["STR_SHZ_ryansettings_difficulty_Ryanzombiesdamagetank", "STR_SHZ_ryansettings_difficulty_Ryanzombiesdamagetank_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_difficulty"],
    [0.001, 1, 0.005, 1, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Infection Settings
[
    "ryanzombiesinfectedchance",
    "SLIDER",
    ["STR_SHZ_ryansettings_infection_ryanzombiesinfectedchance", "STR_SHZ_ryansettings_infection_ryanzombiesinfectedchance_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_infection"],
    [0, 1, 0.1, 0, true],
    true,
    {ryanzombiesinfectedchance = _this * 100},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesinfectedrate",
    "SLIDER",
    ["STR_SHZ_ryansettings_infection_ryanzombiesinfectedrate", "STR_SHZ_ryansettings_infection_ryanzombiesinfectedrate_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_infection"],
    [0.001, 1, 0.05, 1, true],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesinfectedsymptoms",
    "LIST",
    ["STR_SHZ_ryansettings_infection_ryanzombiesinfectedsymptoms", "STR_SHZ_ryansettings_infection_ryanzombiesinfectedsymptoms_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_infection"],
    [[0.9, 0.7, 0.5], ["STR_SHZ_ryansettings_infection_symptoms_normal", "STR_SHZ_ryansettings_infection_symptoms_less", "STR_SHZ_ryansettings_infection_symptoms_none"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesinfecteddeath",
    "LIST",
    ["STR_SHZ_ryansettings_infection_ryanzombiesinfecteddeath", "STR_SHZ_ryansettings_infection_ryanzombiesinfecteddeath_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_infection"],
    [[0.9, 0.7], ["STR_SHZ_ryansettings_infectionDeath_scream", "STR_SHZ_ryansettings_infectionDeath_silent"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesantivirusduration",
    "SLIDER",
    ["STR_SHZ_ryansettings_infection_ryanzombiesantivirusduration", "STR_SHZ_ryansettings_infection_ryanzombiesantivirusduration_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_infection"],
    [10, 3600, 300, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Movement Speed Settings
[
    "ryanzombiesmovementspeedslow",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedslow", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedslow_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 1, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedslow = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedmedium",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedmedium", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedmedium_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 0.6, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedmedium = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedfast",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedfast", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedfast_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 0.7, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedfast = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeeddemon",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeeddemon", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeeddemon_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 0.6, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeeddemon = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedspider",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedspider", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedspider_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 0.5, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedspider = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedcrawler",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedcrawler", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedcrawler_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 1, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedcrawler = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedwalker",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedwalker", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedwalker_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 1, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedwalker = nil}},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesmovementspeedplayer",
    "SLIDER",
    ["STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedplayer", "STR_SHZ_ryansettings_movement_ryanzombiesmovementspeedplayer_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_movement"],
    [0.01, 10, 1.5, 0, true],
    true,
    {if (_this isEqualTo 1) then {ryanzombiesmovementspeedplayer = nil}},
    false
] call SHZ_fnc_addSetting;

// Resurrection Settings
[
    "ryanzombiesinfection",
    "LIST",
    ["STR_SHZ_ryansettings_resurrection_ryanzombiesinfection", "STR_SHZ_ryansettings_resurrection_ryanzombiesinfection_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_resurrection"],
    [[0.9, 0.7, 0.5, 0.4, 0.3, 0.1, 0.05], ["STR_SHZ_ryansettings_resurrection_fast", "STR_SHZ_ryansettings_resurrection_medium", "STR_SHZ_ryansettings_resurrection_slow", "STR_SHZ_ryansettings_resurrection_walker", "STR_SHZ_ryansettings_resurrection_demon", "STR_SHZ_ryansettings_resurrection_spider", "STR_SHZ_ryansettings_resurrection_brittle"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesinfectiontimer",
    "SLIDER",
    ["STR_SHZ_ryansettings_resurrection_ryanzombiesinfectiontimer", "STR_SHZ_ryansettings_resurrection_ryanzombiesinfectiontimer_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_resurrection"],
    [0, 300, 30, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesuniform",
    "LIST",
    ["STR_SHZ_ryansettings_resurrection_ryanzombiesuniform", "STR_SHZ_ryansettings_resurrection_ryanzombiesuniform_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_resurrection"],
    [[0.9, 0.7], ["str_lib_info_no", "str_lib_info_yes"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Miscellaneous
[
    "Ryanzombiesdamagecaliberneeded",
    "LIST",
    ["STR_SHZ_ryansettings_misc_Ryanzombiesdamagecaliberneeded", "STR_SHZ_ryansettings_misc_Ryanzombiesdamagecaliberneeded_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[nil, 1.6, 0.9, 0.1, -1], ["STR_SHZ_ryansettings_misc_caliber_veryHeavy", "STR_SHZ_ryansettings_misc_caliber_heavy", "STR_SHZ_ryansettings_misc_caliber_medium", "STR_SHZ_ryansettings_misc_caliber_light", "STR_SHZ_ryansettings_misc_caliber_disabled"], 3],
    true,
    {Ryanzombiesdisableexplodingheads = [1, nil] select (isNil "_this" || {_this isNotEqualTo -1})},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesglow",
    "LIST",
    ["STR_SHZ_ryansettings_misc_ryanzombiesglow", "STR_SHZ_ryansettings_misc_ryanzombiesglow_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[nil, 1], ["str_lib_info_no", "str_lib_info_yes"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesglowdemondisable",
    "LIST",
    ["STR_SHZ_ryansettings_misc_ryanzombiesglowdemondisable", "STR_SHZ_ryansettings_misc_ryanzombiesglowdemondisable_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[1, nil], ["str_lib_info_no", "str_lib_info_yes"], 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "RZ_HeadshotsOnly",
    "LIST",
    ["STR_SHZ_ryansettings_misc_RZ_HeadshotsOnly", "STR_SHZ_ryansettings_misc_RZ_HeadshotsOnly_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[nil, 1], ["str_lib_info_no", "str_lib_info_yes"], 0],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesdisablebleeding",
    "LIST",
    ["STR_SHZ_ryansettings_misc_ryanzombiesdisablebleeding", "STR_SHZ_ryansettings_misc_ryanzombiesdisablebleeding_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[1, nil], ["str_lib_info_no", "str_lib_info_yes"], 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesdisablemoaning",
    "LIST",
    ["STR_SHZ_ryansettings_misc_ryanzombiesdisablemoaning", "STR_SHZ_ryansettings_misc_ryanzombiesdisablemoaning_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[1, nil], ["str_lib_info_no", "str_lib_info_yes"], 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombiesdisableaggressive",
    "LIST",
    ["STR_SHZ_ryansettings_misc_ryanzombiesdisableaggressive", "STR_SHZ_ryansettings_misc_ryanzombiesdisableaggressive_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_misc"],
    [[1, nil], ["str_lib_info_no", "str_lib_info_yes"], 1],
    true,
    {},
    false
] call SHZ_fnc_addSetting;

// Max Health Settings
[
    "ryanzombieshealth",
    "LIST",
    ["STR_SHZ_ryansettings_health_ryanzombieshealth", "STR_SHZ_ryansettings_health_ryanzombieshealth_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_health"],
    [[0.7, 0.5, 0.9, 0.97], ["str_disp_default", "STR_SHZ_ryansettings_strength_stronger", "STR_SHZ_ryansettings_strength_weaker", "STR_SHZ_ryansettings_strength_weakest"], 2],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "ryanzombieshealthdemon",
    "LIST",
    ["STR_SHZ_ryansettings_health_ryanzombieshealthdemon", "STR_SHZ_ryansettings_health_ryanzombieshealthdemon_tooltip"],
    ["STR_SHZ_ryansettings", "STR_SHZ_ryansettings_health"],
    [[0.7, 0.5, 0.9, 0.97], ["str_disp_default", "STR_SHZ_ryansettings_strength_stronger", "STR_SHZ_ryansettings_strength_weaker", "STR_SHZ_ryansettings_strength_weakest"], 2],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
