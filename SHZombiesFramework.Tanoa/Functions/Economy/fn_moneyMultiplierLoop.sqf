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
        {_moneyEarned deleteAt _x} forEach SHZ_moneyMultipliers_rates;
    }
];
private _disconnectEH = addMissionEventHandler [
    "PlayerDisconnected",
    {
        params ["", "_uid"];
        SHZ_moneyEarned deleteAt _uid;
        SHZ_startOfTripMoney deleteAt _uid;
        SHZ_moneyMultipliers_current deleteAt _uid;
    }
];

private _getCurrentMultiplier = {
    params ["_uid"];
    private _multiplier =
        SHZ_moneyMultipliers_base
        + linearConversion [20, 3, getLighting # 1, 0, SHZ_moneyMultipliers_rates_dark, true];

    private _moneyEarned = SHZ_moneyEarned getOrDefault [_uid, createHashMap];
    {
        private _tag = _x;
        private _rate = _y;
        private _money = _moneyEarned getOrDefault [_tag, 0];
        _multiplier = _multiplier + _money * _rate;
    } forEach SHZ_moneyMultipliers_rates;

    _multiplier
};

while {true} do {
    {
        private _uid = getPlayerUID _x;
        if (_uid isEqualTo "") then {continue};
        if ([_x] call SHZ_fnc_inAreaTeamSafezone isNotEqualTo []) then {
            private _moneyEarned = SHZ_moneyEarned getOrDefault [_uid, createHashMap];
            {_moneyEarned deleteAt _x} forEach SHZ_moneyMultipliers_rates;

            private _moneyStarted = SHZ_startOfTripMoney deleteAt _uid;
            if (isNil "_moneyStarted") exitWith {};

            private _moneyEnded = [_uid] call SHZ_fnc_getMoney;
            private _diff = _moneyEnded - _moneyStarted;

            if (_diff >= 1000) then {
                private _multiplier = SHZ_moneyMultipliers_current getOrDefault [_uid, SHZ_moneyMultipliers_base];
                [_diff, _multiplier] remoteExec ["SHZ_fnc_showMoneyMultiplierReset", _x];
            };
        } else {
            SHZ_startOfTripMoney set [_uid, [_uid] call SHZ_fnc_getMoney, true];
        };

        private _multiplier = [_uid] call _getCurrentMultiplier;
        SHZ_moneyMultipliers_current set [_uid, _multiplier];

        sleep random 0.1;
    } forEach allPlayers;
    sleep 30;
};

// NOTE: above loop does not exit so this will never be reached!
removeMissionEventHandler ["EntityKilled", _killedEH];
removeMissionEventHandler ["PlayerDisconnected", _disconnectEH];
