/*
Function: SHZ_fnc_addZombieKillMoney

Description:
    Adds money to a player for a zombie kill.
    Function must be executed on server.

Parameters:
    String uid:
        The player UID to add the money to.
    Object zombie:
        The zombie that was killed.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid", "_zombie"];

if (_uid isEqualTo "") exitWith {
    diag_log text format ["%1: Passed invalid UID", _fnc_scriptName];
};
if !([_zombie] call SHZ_fnc_isZombie) exitWith {
    diag_log text format [
        "%1: Not a zombie %2 given for UID %3",
        _fnc_scriptName, _zombie, _uid
    ];
};
if (alive _zombie) exitWith {
    diag_log text format [
        "%1: Alive zombie %2 given for UID %3",
        _fnc_scriptName, _zombie, _uid
    ];
};

private _money = [10, 100] select (_zombie isKindOf "RyanZombieboss1");
[_uid, _money] call SHZ_fnc_addMoney;
