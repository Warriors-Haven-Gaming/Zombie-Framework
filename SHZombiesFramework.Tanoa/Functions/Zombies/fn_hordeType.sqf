/*
Function: SHZ_fnc_hordeType

Description:
    Returns an array of zombie classnames for one or more given horde types.

Parameters:
    Array | String types:
        One or more horde types to return. Can be any of:
            "fastCivilians"
            "fastSoldiers"
            "mediumCivilians"
            "mediumSoldiers"
            "slowCivilians"
            "slowSoldiers"
            "walkerCivilians"
            "walkerSoldiers"
            "demons"
            "spiders"
            "crawlers"
            "mixed" (all above types except demons)
            "mixedStanding" (all fast, medium, slow, and walker zombies)
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
        case "fastCivilians": {["RyanZombieC_man_1", "RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F", "RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F", "RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F", "RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes", "RyanZombieC_Nikos", "RyanZombie15", "RyanZombie16", "RyanZombie17", "RyanZombie18", "RyanZombie19", "RyanZombie20", "RyanZombie21", "RyanZombie22", "RyanZombie23", "RyanZombie24", "RyanZombie25", "RyanZombie26", "RyanZombie27", "RyanZombie28", "RyanZombie29", "RyanZombie30", "RyanZombie31", "RyanZombie32"]};
        case "fastSoldiers": {["RyanZombieB_Soldier_02_f", "RyanZombieB_Soldier_02_f_1", "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_03_f", "RyanZombieB_Soldier_03_f_1", "RyanZombieB_Soldier_03_f_1_1", "RyanZombieB_Soldier_04_f", "RyanZombieB_Soldier_04_f_1", "RyanZombieB_Soldier_04_f_1_1", "RyanZombieB_Soldier_lite_F", "RyanZombieB_Soldier_lite_F_1"]};
        case "mediumCivilians": {["RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium", "RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium", "RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium", "RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium", "RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium", "RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium", "RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium", "RyanZombie15medium", "RyanZombie16medium", "RyanZombie17medium", "RyanZombie18medium", "RyanZombie19medium", "RyanZombie20medium", "RyanZombie21medium", "RyanZombie22medium", "RyanZombie23medium", "RyanZombie24medium", "RyanZombie25medium", "RyanZombie26medium", "RyanZombie27medium", "RyanZombie28medium", "RyanZombie29medium", "RyanZombie30medium", "RyanZombie31medium", "RyanZombie32medium"]};
        case "mediumSoldiers": {["RyanZombieB_Soldier_02_fmedium", "RyanZombieB_Soldier_02_f_1medium", "RyanZombieB_Soldier_02_f_1_1medium", "RyanZombieB_Soldier_03_fmedium", "RyanZombieB_Soldier_03_f_1medium", "RyanZombieB_Soldier_03_f_1_1medium", "RyanZombieB_Soldier_04_fmedium", "RyanZombieB_Soldier_04_f_1medium", "RyanZombieB_Soldier_04_f_1_1medium", "RyanZombieB_Soldier_lite_Fmedium", "RyanZombieB_Soldier_lite_F_1medium"]};
        case "slowCivilians": {["RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow", "RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow", "RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow", "RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow", "RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow", "RyanZombie15slow", "RyanZombie16slow", "RyanZombie17slow", "RyanZombie18slow", "RyanZombie19slow", "RyanZombie20slow", "RyanZombie21slow", "RyanZombie22slow", "RyanZombie23slow", "RyanZombie24slow", "RyanZombie25slow", "RyanZombie26slow", "RyanZombie27slow", "RyanZombie28slow", "RyanZombie29slow", "RyanZombie30slow", "RyanZombie31slow", "RyanZombie32slow"]};
        case "slowSoldiers": {["RyanZombieB_Soldier_02_fslow", "RyanZombieB_Soldier_02_f_1slow", "RyanZombieB_Soldier_02_f_1_1slow", "RyanZombieB_Soldier_03_fslow", "RyanZombieB_Soldier_03_f_1slow", "RyanZombieB_Soldier_03_f_1_1slow", "RyanZombieB_Soldier_04_fslow", "RyanZombieB_Soldier_04_f_1slow", "RyanZombieB_Soldier_04_f_1_1slow", "RyanZombieB_Soldier_lite_Fslow", "RyanZombieB_Soldier_lite_F_1slow"]};
        case "walkerCivilians": {["RyanZombieC_man_1Walker", "RyanZombieC_man_polo_1_FWalker", "RyanZombieC_man_polo_2_FWalker", "RyanZombieC_man_polo_4_FWalker", "RyanZombieC_man_polo_5_FWalker", "RyanZombieC_man_polo_6_FWalker", "RyanZombieC_man_p_fugitive_FWalker", "RyanZombieC_man_w_worker_FWalker", "RyanZombieC_scientist_FWalker", "RyanZombieC_man_hunter_1_FWalker", "RyanZombieC_man_pilot_FWalker", "RyanZombieC_journalist_FWalker", "RyanZombieC_OrestesWalker", "RyanZombieC_NikosWalker", "RyanZombie15walker", "RyanZombie16walker", "RyanZombie17walker", "RyanZombie18walker", "RyanZombie19walker", "RyanZombie20walker", "RyanZombie21walker", "RyanZombie22walker", "RyanZombie23walker", "RyanZombie24walker", "RyanZombie25walker", "RyanZombie26walker", "RyanZombie27walker", "RyanZombie28walker", "RyanZombie29walker", "RyanZombie30walker", "RyanZombie31walker", "RyanZombie32walker"]};
        case "walkerSoldiers": {["RyanZombieB_Soldier_02_fWalker", "RyanZombieB_Soldier_02_f_1Walker", "RyanZombieB_Soldier_02_f_1_1Walker", "RyanZombieB_Soldier_03_fWalker", "RyanZombieB_Soldier_03_f_1Walker", "RyanZombieB_Soldier_03_f_1_1Walker", "RyanZombieB_Soldier_04_fWalker", "RyanZombieB_Soldier_04_f_1Walker", "RyanZombieB_Soldier_04_f_1_1Walker", "RyanZombieB_Soldier_lite_FWalker", "RyanZombieB_Soldier_lite_F_1Walker"]};
        case "demons": {["RyanZombieboss1", "RyanZombieboss2", "RyanZombieboss3", "RyanZombieboss4", "RyanZombieboss5", "RyanZombieboss6", "RyanZombieboss7", "RyanZombieboss8", "RyanZombieboss9", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12", "RyanZombieboss13", "RyanZombieboss14", "RyanZombieboss15", "RyanZombieboss16", "RyanZombieboss17", "RyanZombieboss18", "RyanZombieboss19", "RyanZombieboss20", "RyanZombieboss21", "RyanZombieboss22", "RyanZombieboss23", "RyanZombieboss24", "RyanZombieboss25", "RyanZombieboss26", "RyanZombieboss27", "RyanZombieboss28", "RyanZombieboss29", "RyanZombieboss30", "RyanZombieboss31", "RyanZombieboss32"]};
        case "spiders": {["RyanZombieSpider1", "RyanZombieSpider2", "RyanZombieSpider3", "RyanZombieSpider4", "RyanZombieSpider5", "RyanZombieSpider6", "RyanZombieSpider7", "RyanZombieSpider8", "RyanZombieSpider9", "RyanZombieSpider10", "RyanZombieSpider11", "RyanZombieSpider12", "RyanZombieSpider13", "RyanZombieSpider14", "RyanZombieSpider15", "RyanZombieSpider16", "RyanZombieSpider17", "RyanZombieSpider18", "RyanZombieSpider19", "RyanZombieSpider20", "RyanZombieSpider21", "RyanZombieSpider22", "RyanZombieSpider23", "RyanZombieSpider24", "RyanZombieSpider25", "RyanZombieSpider26", "RyanZombieSpider27", "RyanZombieSpider28", "RyanZombieSpider29", "RyanZombieSpider30", "RyanZombieSpider31", "RyanZombieSpider32"]};
        case "crawlers": {["RyanZombieCrawler1", "RyanZombieCrawler2", "RyanZombieCrawler3", "RyanZombieCrawler4", "RyanZombieCrawler5", "RyanZombieCrawler6", "RyanZombieCrawler7", "RyanZombieCrawler8", "RyanZombieCrawler9", "RyanZombieCrawler10", "RyanZombieCrawler11", "RyanZombieCrawler12", "RyanZombieCrawler13", "RyanZombieCrawler14", "RyanZombieCrawler15", "RyanZombieCrawler16", "RyanZombieCrawler17", "RyanZombieCrawler18", "RyanZombieCrawler19", "RyanZombieCrawler20", "RyanZombieCrawler21", "RyanZombieCrawler22", "RyanZombieCrawler23", "RyanZombieCrawler24", "RyanZombieCrawler25", "RyanZombieCrawler26", "RyanZombieCrawler27", "RyanZombieCrawler28", "RyanZombieCrawler29", "RyanZombieCrawler30", "RyanZombieCrawler31", "RyanZombieCrawler32"]};
        case "mixed": {flatten (call SHZ_fnc_hordeTypeList - ["demons"] apply {_x call SHZ_fnc_hordeType})};
        case "mixedStanding": {flatten (call SHZ_fnc_hordeTypeList - ["demons", "spiders", "crawlers"] apply {_x call SHZ_fnc_hordeType})};
        default {[]};
    };
};
flatten _resolvedTypes
