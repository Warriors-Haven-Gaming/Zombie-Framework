/*
Function: SHZ_fnc_initStatsTracking

Description:
    Initializes event handlers for tracking game statistics.
    Function must be ran on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer", "_instigator"];
    if !([_killed] call SHZ_fnc_isZombie) exitWith {};
	if (isNull _instigator) then {
        // UAV/UGV player operated road kill
        _instigator = UAVControl vehicle _killer # 0;
    };
	if (isNull _instigator) then {
        // player driven vehicle road kill
        _instigator = _killer;
    };
    if (isNull _instigator || {!isPlayer _instigator}) exitWith {};

    private _uid = getPlayerUID _instigator;
    if (_uid isEqualTo "") exitWith {};

    private _kills = ["zombieKills"] call SHZ_fnc_getSaveVariable;
    _kills set [_uid, (_kills getOrDefault [_uid, 0]) + 1];
}];
