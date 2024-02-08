/*
Function: SHZ_fnc_initDiary

Description:
    Initializes all diary records.
    Function must be ran on client.

Examples:
    (begin example)
        call SHZ_fnc_initDiary;
    (end)

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

call SHZ_fnc_addRecordGuide;
call SHZ_fnc_addRecordACE;
call SHZ_fnc_addRecordCredits;
