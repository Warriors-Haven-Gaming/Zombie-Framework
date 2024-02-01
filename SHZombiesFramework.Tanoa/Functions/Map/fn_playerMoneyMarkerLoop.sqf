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
private _lastPlayerMoney = createHashMap;
private _connectEH = addMissionEventHandler [
    "PlayerConnected",
    {
        params ["", "_uid", "", "", "_owner"];
        _thisArgs params ["_lastPlayerMoney"];

        private _currentPlayerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
        private _currentMoney = _currentPlayerMoney getOrDefault [_uid, 0];

        [_currentMoney] remoteExec ["SHZ_fnc_playerMoneyMarkerCallback", _owner];
        _lastPlayerMoney set [_uid, _currentMoney];
    },
    [_lastPlayerMoney]
];
private _disconnectEH = addMissionEventHandler [
    "PlayerDisconnected",
    {
        params ["", "_uid"];
        _thisArgs params ["_lastPlayerMoney"];
        _lastPlayerMoney deleteAt _uid;
    },
    [_lastPlayerMoney]
];

while {true} do {
    private _currentPlayerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
    {
        private _uid = getPlayerUID _x;
        if (_uid isEqualTo "") then {continue};

        private _currentMoney = _currentPlayerMoney getOrDefault [_uid, 0];
        private _lastMoney = _lastPlayerMoney getOrDefault [_uid, -1];
        if (_currentMoney isEqualTo _lastMoney) then {continue};

        [_currentMoney] remoteExec ["SHZ_fnc_playerMoneyMarkerCallback", _x];
        _lastPlayerMoney set [_uid, _currentMoney];
    } forEach allPlayers;
    sleep 60;
};

// NOTE: above loop does not exit so this will never be reached!
removeMissionEventHandler ["PlayerConnected", _connectEH];
removeMissionEventHandler ["PlayerDisconnected", _disconnectEH];
