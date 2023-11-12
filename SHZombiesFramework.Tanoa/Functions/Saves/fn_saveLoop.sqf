/*
Function: SHZ_fnc_saveLoop

Description:
    Periodically saves missionProfileNamespace.
    Function must be ran on server and in scheduled environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

while {true} do {
    sleep 300;
    saveMissionProfileNamespace;
    diag_log text "Saved mission profile namespace";
};
