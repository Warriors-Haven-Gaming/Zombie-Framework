/*
Function: SHZ_fnc_addRecordCredits

Description:
    Initializes the diary records for mission credits.
    Function must be ran on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

player createDiarySubject [_fnc_scriptName, localize "$STR_SHZ_addRecordCredits_subject"];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordCredits_authors_title",
        "$STR_SHZ_addRecordCredits_authors_description" call SHZ_fnc_localize
    ]
];
