/*
Function: SHZ_fnc_addRecordGuide

Description:
    Initializes the diary records for the getting started guide.
    Function must be ran on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

player createDiarySubject [
    _fnc_scriptName,
    localize "$STR_SHZ_addRecordGuide_subject"
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordGuide_infection_title",
        "$STR_SHZ_addRecordGuide_infection_description" call SHZ_fnc_localize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordGuide_safezones_title",
        "$STR_SHZ_addRecordGuide_safezones_description" call SHZ_fnc_localize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordGuide_economy_title",
        "$STR_SHZ_addRecordGuide_economy_description" call SHZ_fnc_localize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordGuide_about_title",
        format [
            "$STR_SHZ_addRecordGuide_about_description" call SHZ_fnc_localize,
            worldName
        ]
    ]
];
