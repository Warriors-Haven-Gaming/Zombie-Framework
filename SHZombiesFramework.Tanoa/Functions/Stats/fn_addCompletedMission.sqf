/*
Function: SHZ_fnc_addCompletedMission

Description:
    Records a completed mission.
    Function must be ran on server.

Parameters:
    String name:
        The mission function's name that was completed.
        Usually this should be `_fnc_scriptName`.
    Array participants:
        An array of players or UIDs that participated in the mission.
        Duplicates will be ignored.
    Number money:
        The amount of money to reward each participant.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_name", "_participants", "_money"];

private _allMissionsCompleted = ["allMissionsCompleted"] call SHZ_fnc_getSaveVariable;
_allMissionsCompleted set [_name, (_allMissionsCompleted getOrDefault [_name, 0]) + 1];

private _missionsCompleted = ["missionsCompleted"] call SHZ_fnc_getSaveVariable;
{
    private _player = objNull;
    private _uid = "";

    if (_x isEqualType "") then {
        _uid = _x;
        _player = _x call BIS_fnc_getUnitByUID;
    } else {
        _player = _x;
        _uid = getPlayerUID _x;
    };

    if (_uid isEqualTo "") then {continue};
    _missionsCompleted set [_uid, (_missionsCompleted getOrDefault [_uid, 0]) + 1];
    [_uid, _money, ["MISSION"]] call SHZ_fnc_addMoney;

    if (!isNull _player) then {
        [_name, _money] remoteExec ["SHZ_fnc_showCompletedMission", _player];
    };
} forEach (_participants arrayIntersect _participants);
