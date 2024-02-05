/*
Function: SHZ_fnc_addRecordACE

Description:
    Initializes the diary records for ACE-related mechanics.
    Function must be ran on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) exitWith {};

player createDiarySubject [_fnc_scriptName, localize "$STR_SHZ_addRecordACE_subject"];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordACE_moneyShare_title",
        "$STR_SHZ_addRecordACE_moneyShare_description" call SHZ_fnc_localize
    ]
];
if (isClass (configFile >> "CfgPatches" >> "ace_vehiclelock")) then {
    player createDiaryRecord [
        _fnc_scriptName,
        [
            localize "$STR_SHZ_addRecordACE_vehicleLocking_title",
            "$STR_SHZ_addRecordACE_vehicleLocking_description" call SHZ_fnc_localize
        ]
    ];
};
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordACE_pylons_title",
        "$STR_SHZ_addRecordACE_pylons_description" call SHZ_fnc_localize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordACE_servicing_title",
        "$STR_SHZ_addRecordACE_servicing_description" call SHZ_fnc_localize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_SHZ_addRecordACE_basics_title",
        "$STR_SHZ_addRecordACE_basics_description" call SHZ_fnc_localize
    ]
];
