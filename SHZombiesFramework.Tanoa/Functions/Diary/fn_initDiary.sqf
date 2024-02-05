/*
Function: SHZ_fnc_initDiary

Description:
    Initializes all diary records.
    Function must be ran on client.

Examples:
    (begin example)
        [player] call SHZ_fnc_initDiary;
    (end)

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

call SHZ_fnc_addRecordACE;
