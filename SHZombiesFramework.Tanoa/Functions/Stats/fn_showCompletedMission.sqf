/*
Function: SHZ_fnc_showCompletedMission

Description:
    Shows the given completed mission.
    Function must be remote executed on client from the server.

Parameters:
    String name:
        The mission function's name that was completed.
    Number money:
        The amount of money earned from completing this mission.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_name", "_money"];

if (_money > 0) then {
    hint format [
        localize "$STR_SHZ_showCompletedMission_money",
        _money call SHZ_fnc_formatMoney
    ];
};
