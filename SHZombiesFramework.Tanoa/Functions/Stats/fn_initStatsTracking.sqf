/*
Function: SHZ_fnc_initStatsTracking

Description:
    Initializes event handlers for tracking game statistics.
    Function must be ran on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

// Track zombie/enemy kills
addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer", "_instigator"];
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

    if ([_killed] call SHZ_fnc_isZombie) exitWith {
        private _kills = ["zombieKills"] call SHZ_fnc_getSaveVariable;
        _kills set [_uid, (_kills getOrDefault [_uid, 0]) + 1];
        [_uid, _killed] call SHZ_fnc_addZombieKillMoney;
    };

    if ([side group _instigator, side group _killed] call BIS_fnc_sideIsEnemy) exitWith {
        [_uid, 10, true, true] call SHZ_fnc_addMoney;
    };
}];

// Track player deaths
addMissionEventHandler ["EntityKilled", {
    params ["_killed"];
    if (!isPlayer [_killed]) exitWith {};

    private _uid = getPlayerUID _killed;
    if (_uid isEqualTo "") exitWith {};

    // If they're close to the origin they probably just joined... thanks Arma
    if (_killed distance2D [0,0,0] < 50) exitWith {};
    private _respawn = [_killed] call SHZ_fnc_nearestRespawnPosition;
    if (_respawn isEqualTo []) exitWith {};
    if (_killed distance2D _respawn < 500) exitWith {};

    private _deaths = ["playerDeaths"] call SHZ_fnc_getSaveVariable;
    _deaths set [_uid, (_deaths getOrDefault [_uid, 0]) + 1];
}];
