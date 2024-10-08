/*
Function: SHZ_fnc_selfReviveConditionProgress

Description:
    Checks if the self-revive action can progress.
    See SHZ_fnc_selfReviveLoop for more details.

Author:
    thegamecracks

*/
params ["", "_caller"];

private _nFAKs = {
    _x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"
} count items _caller;
private _nMissing = SHZ_selfRevive_FAKs - _nFAKs;

if (_nMissing > 0) exitWith {
    50 cutText [
        format [
            localize "$STR_SHZ_selfReviveConditionProgress_noFirstAidKits",
            SHZ_selfRevive_FAKs,
            _nMissing
        ],
        "PLAIN",
        0.5
    ];
    false
};
true
