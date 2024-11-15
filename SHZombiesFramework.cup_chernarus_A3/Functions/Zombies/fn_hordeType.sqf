/*
Function: SHZ_fnc_hordeType

Description:
    Returns an array of zombie classnames for one or more given horde types.

Parameters:
    Array | String types:
        One or more horde types to return. Can be any of:
            "aaf"
            "civilians"
            "csat"
            "fia"
            "ldf"
            "nato"
            "angry"
            "calm"
            "crawlers"
            "shamblers"
            "shooters"
            "walkers"
            "bloaters"
            "corrupted"
            "leapers"
            "screamers"
            "smashers"
            "mixed" (all non-special types)
            "specials" (all specials except smashers)
        Note that classnames are not de-duplicated.
        If none of the types are valid, an empty array is returned.

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {_this = [_this]};

private _resolvedTypes = _this apply {
    switch (_x) do {
        case "aaf": {["Zombie_G_Crawler_AAF", "Zombie_G_Shambler_AAF", "Zombie_G_RA_AAF", "Zombie_G_RC_AAF", "Zombie_G_Shooter_AAF", "Zombie_G_Walker_AAF"]};
        case "civilians": {["Zombie_G_Crawler_Civ", "Zombie_G_Shambler_Civ", "Zombie_G_RA_Civ", "Zombie_G_RC_Civ", "Zombie_G_Walker_Civ"]};
        case "csat": {["Zombie_G_Crawler_CSAT", "Zombie_G_Shambler_CSAT", "Zombie_G_RA_CSAT", "Zombie_G_RC_CSAT", "Zombie_G_Shooter_CSAT", "Zombie_G_Walker_CSAT"]};
        case "fia": {["Zombie_G_Crawler_FIA", "Zombie_G_Shambler_FIA", "Zombie_G_RA_FIA", "Zombie_G_RC_FIA", "Zombie_G_Shooter_FIA", "Zombie_G_Walker_FIA"]};
        case "ldf": {["Zombie_G_Crawler_LDF", "Zombie_G_Shambler_LDF", "Zombie_G_RA_LDF", "Zombie_G_RC_LDF", "Zombie_G_Shooter_LDF", "Zombie_G_Walker_LDF"]};
        case "nato": {["Zombie_G_Crawler_NATO_P", "Zombie_G_Shambler_NATO_P", "Zombie_G_RA_NATO_P", "Zombie_G_RC_NATO_P", "Zombie_G_Shooter_NATO_P", "Zombie_G_Walker_NATO_P"]};

        case "angry": {["Zombie_G_RA_AAF", "Zombie_G_RA_Civ", "Zombie_G_RA_CSAT", "Zombie_G_RA_FIA", "Zombie_G_RA_LDF", "Zombie_G_RA_NATO_P"]};
        case "calm": {["Zombie_G_RC_AAF", "Zombie_G_RC_Civ", "Zombie_G_RC_CSAT", "Zombie_G_RC_FIA", "Zombie_G_RC_LDF", "Zombie_G_RC_NATO_P"]};
        case "crawlers": {["Zombie_G_Crawler_AAF", "Zombie_G_Crawler_Civ", "Zombie_G_Crawler_CSAT", "Zombie_G_Crawler_FIA", "Zombie_G_Crawler_LDF", "Zombie_G_Crawler_NATO_P"]};
        case "shamblers": {["Zombie_G_Shambler_AAF", "Zombie_G_Shambler_Civ", "Zombie_G_Shambler_CSAT", "Zombie_G_Shambler_FIA", "Zombie_G_Shambler_LDF", "Zombie_G_Shambler_NATO_P"]};
        case "shooters": {["Zombie_G_Shooter_AAF", "Zombie_G_Shooter_CSAT", "Zombie_G_Shooter_FIA", "Zombie_G_Shooter_LDF", "Zombie_G_Shooter_NATO_P"]};
        case "walkers": {["Zombie_G_Walker_AAF", "Zombie_G_Walker_Civ", "Zombie_G_Walker_CSAT", "Zombie_G_Walker_FIA", "Zombie_G_Walker_LDF", "Zombie_G_Walker_NATO_P"]};

        case "bloaters": {["Zombie_Special_GREENFOR_Boomer"]};
        case "corrupted": {["WBK_SpecialZombie_Corrupted_1"]};
        case "leapers": {["Zombie_Special_GREENFOR_Leaper_1", "Zombie_Special_GREENFOR_Leaper_2"]};
        case "screamers": {["Zombie_Special_GREENFOR_Screamer"]};
        case "smashers": {["WBK_SpecialZombie_Smasher_1"]};

        case "mixed": {["angry", "calm", "crawlers", "shamblers", "shooters", "walkers"] call SHZ_fnc_hordeType};
        case "specials": {["bloaters", "corrupted", "leapers", "screamers"] call SHZ_fnc_hordeType};
        default {[]};
    };
};
flatten _resolvedTypes
