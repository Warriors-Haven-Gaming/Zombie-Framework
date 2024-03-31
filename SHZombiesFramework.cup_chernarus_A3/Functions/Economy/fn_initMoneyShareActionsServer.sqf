/*
Function: SHZ_fnc_initMoneyShareActionsServer

Description:
    Adds server event handlers to manage money sharing actions.
    Function must be executed on server.

Examples:
    (begin example)
        call SHZ_fnc_initMoneyShareActionsServer;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

addMissionEventHandler ["HandleDisconnect", {
    params ["_unit"];
    remoteExec ["", (_unit call BIS_fnc_netId) + ":SHZ_moneyShare"];
    false
}];
