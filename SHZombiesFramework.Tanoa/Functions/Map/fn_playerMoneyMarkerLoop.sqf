/*
Function: SHZ_fnc_playerMoneyMarkerLoop

Description:
    Periodically updates the player_money marker for each client.
    Function must be ran on server and in scheduled environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

// To optimize network traffic, we will only send updates to players
// whose money has changed or has recently connected.
private _allStates = createHashMap;
private _connectEH = addMissionEventHandler [
    "PlayerConnected",
    {
        params ["", "_uid", "", "", "_owner"];
        _thisArgs params ["_allStates"];

        private _currentPlayerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
        private _currentMoney = _currentPlayerMoney getOrDefault [_uid, 0];
        private _currentMultiplier = SHZ_moneyMultipliers_current getOrDefault [_uid, 1];

        [_currentMoney] remoteExec ["SHZ_fnc_playerMoneyMarkerCallback", _owner];
        _allStates set [_uid, [_currentMoney, _currentMultiplier]];
    },
    [_allStates]
];
private _disconnectEH = addMissionEventHandler [
    "PlayerDisconnected",
    {
        params ["", "_uid"];
        _thisArgs params ["_allStates"];
        _allStates deleteAt _uid;
    },
    [_allStates]
];

while {true} do {
    private _currentPlayerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
    {
        private _uid = getPlayerUID _x;
        if (_uid isEqualTo "") then {continue};

        private _currentState = [
            _currentPlayerMoney getOrDefault [_uid, 0],
            SHZ_moneyMultipliers_current getOrDefault [_uid, 1]
        ];
        private _lastState = _allStates getOrDefault [_uid, []];
        if (_currentState isEqualTo _lastState) then {continue};

        _currentState remoteExec ["SHZ_fnc_playerMoneyMarkerCallback", _x];
        _allStates set [_uid, _currentState];
    } forEach allPlayers;
    sleep 60;
};

// NOTE: above loop does not exit so this will never be reached!
removeMissionEventHandler ["PlayerConnected", _connectEH];
removeMissionEventHandler ["PlayerDisconnected", _disconnectEH];
