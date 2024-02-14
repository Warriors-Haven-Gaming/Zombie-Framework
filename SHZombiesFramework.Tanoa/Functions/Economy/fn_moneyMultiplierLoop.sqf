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

        private _moneyEarned = SHZ_moneyEarned getOrDefault [_uid, createHashMap];
        {_moneyEarned deleteAt _x} forEach ["NORMAL", "ON_FOOT"];
    }
];
private _disconnectEH = addMissionEventHandler [
    "PlayerDisconnected",
    {
        params ["", "_uid"];
        SHZ_moneyEarned deleteAt _uid;
        SHZ_moneyMultipliers_current deleteAt _uid;
    }
];

while {true} do {
    {
        private _uid = getPlayerUID _x;
        if (_uid isEqualTo "") then {continue};
        if ([_x] call SHZ_fnc_inAreaTeamSafezone isNotEqualTo []) then {
            private _moneyEarned = SHZ_moneyEarned deleteAt _uid;
            if (isNil "_moneyEarned") exitWith {};

            private _money = _moneyEarned getOrDefault ["NORMAL", 0];
            if (_money < 1000) exitWith {};

            private _multiplier = SHZ_moneyMultipliers_current getOrDefault [_uid, 1];
            [_money, _multiplier] remoteExec ["SHZ_fnc_showMoneyMultiplierReset", _x];
        };

        private _moneyEarned = SHZ_moneyEarned getOrDefault [_uid, createHashMap];
        private _multiplier =
            1
            + (_moneyEarned getOrDefault ["NORMAL", 0]) * SHZ_moneyMultipliers_rate_normal
            + (_moneyEarned getOrDefault ["ON_FOOT", 0]) * SHZ_moneyMultipliers_rate_onFoot
            + linearConversion [20, 3, getLighting # 1, 0, 0.5, true];
        SHZ_moneyMultipliers_current set [_uid, _multiplier];

        sleep random 0.1;
    } forEach allPlayers;
    sleep 30;
};

// NOTE: above loop does not exit so this will never be reached!
removeMissionEventHandler ["EntityKilled", _killedEH];
removeMissionEventHandler ["PlayerDisconnected", _disconnectEH];
