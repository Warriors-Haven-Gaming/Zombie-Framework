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
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_magazines_count", "STR_SHZ_settings_zombies_loot_magazines_count_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [1, 10, 1, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
[
    "SHZ_zombies_loot_magazines_count_soldier",
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_magazines_count_soldier", "STR_SHZ_settings_zombies_loot_magazines_count_soldier_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [1, 10, 5, 0, false],
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
    "SLIDER",
    ["STR_SHZ_settings_zombies_loot_weapon_magazines", "STR_SHZ_settings_zombies_loot_weapon_magazines_tooltip"],
    ["STR_SHZ_settings", "STR_SHZ_settings_zombies_loot"],
    [1, 10, 4, 0, false],
    true,
    {},
    false
] call SHZ_fnc_addSetting;
