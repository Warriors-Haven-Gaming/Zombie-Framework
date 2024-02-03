/*
Function: SHZ_fnc_moneyMultiplierLoop

Description:
    Periodically updates the money multipliers for each player.
    Function must be ran on server and in scheduled environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _killedEH = addMissionEventHandler [
    "EntityKilled",
    {
        params ["_unit"];
        private _uid = getPlayerUID _unit;
        if (_uid isEqualTo "") exitWith {};
        SHZ_moneyMultipliers_current deleteAt _uid;
        SHZ_moneyMultipliers_moneyEarned deleteAt _uid;
    }
];
private _disconnectEH = addMissionEventHandler [
    "PlayerDisconnected",
    {
        params ["", "_uid"];
        SHZ_moneyMultipliers_current deleteAt _uid;
        SHZ_moneyMultipliers_moneyEarned deleteAt _uid;
    }
];

while {true} do {
    {
        private _uid = getPlayerUID _x;
        if (_uid isEqualTo "") then {continue};
        if ([_x] call SHZ_fnc_inAreaTeamSafezone isNotEqualTo []) then {
            SHZ_moneyMultipliers_current deleteAt _uid;
            SHZ_moneyMultipliers_moneyEarned deleteAt _uid;
        } else {
            private _moneyEarned = SHZ_moneyMultipliers_moneyEarned getOrDefault [_uid, 0];
            private _multiplier = 1 + _moneyEarned * SHZ_moneyMultipliers_rate;
            SHZ_moneyMultipliers_current set [_uid, _multiplier];
        };
        sleep random 0.1;
    } forEach allPlayers;
    sleep 30;
};

// NOTE: above loop does not exit so this will never be reached!
removeMissionEventHandler ["EntityKilled", _killedEH];
removeMissionEventHandler ["PlayerDisconnected", _disconnectEH];