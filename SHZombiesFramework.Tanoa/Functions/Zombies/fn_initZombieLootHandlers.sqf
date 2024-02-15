/*
Function: SHZ_fnc_initZombieLootHandlers

Description:
    Initializes event handlers for zombie loot drops.
    Function must be executed on all clients and server.

Author:
    thegamecracks

*/
// This function gets called twice in singleplayer so make
// sure initialization happens once
if (!isNil "SHZ_initZombieLootHandlers") exitWith {};

addMissionEventHandler ["EntityKilled", {
    params ["_killed", "_killer", "_instigator"];
    if !([_killed] call SHZ_fnc_isZombie) exitWith {};
    if (isNull _instigator) then {_instigator = UAVControl vehicle _killer # 0};
    if (isNull _instigator) then {_instigator = _killer};
    if (isNull _instigator) exitWith {};
    if (!local _instigator) exitWith {};

    private _isSoldier = _killed isKindOf "RyanZombieB_Soldier_base_F";
    private _uniqueItems = createHashMap;
    private _addItem = {
        params ["_name", ["_count", 1]];
        _uniqueItems set [_name, (_uniqueItems getOrDefault [_name, 0]) + _count];
    };

    if (random 1 < 0.1) then {
        "FirstAidKit" call _addItem;
    };

    if (random 1 < 0.02) then {
        "RyanZombiesAntiVirusTemporary_Item" call _addItem;
    };

    if (random 1 < 0.25) then {
        private _magazines = magazines _instigator;
        _magazines append (
            // Include magazines in unit's guns
            flatten (
                weaponsItems _instigator
                apply {[_x # 4 # 0, _x # 5 # 0]}
            )
            select {_x isEqualType ""}
        );
        _magazines = _magazines arrayIntersect _magazines;
        if (count _magazines < 1) exitWith {};

        private _maxCount = [1, 5] select _isSoldier;
        for "_i" from 1 to floor random (_maxCount + 1) do {
            selectRandom _magazines call _addItem;
        };
    };

    if (_isSoldier && {random 1 < 0.05}) then {
        private _weapon = selectRandom [
            "rhs_weap_m4_carryhandle_m203",
            "rhs_weap_m27iar_grip",
            "rhs_weap_m4_carryhandle",
            "rhs_weap_m240B"
        ];
        private _config = configFile >> "CfgWeapons" >> _weapon;

        private _magazines = getArray (_config >> "magazines");
        if (count _magazines > 0) then {
            [_magazines # 0, 1 + floor random 4] call _addItem;
        };

        _weapon call _addItem;
    };

    if (count _uniqueItems < 1) exitWith {};

    private _items = _uniqueItems toArray false;
    [_killed, _items] spawn {
        scriptName "SHZ_fnc_initZombieLootHandlers_spawnLoot";
        params ["_killed", "_items"];

        // For jumping zombies, wait until their body falls down
        private _timeout = time + 5;
        waitUntil {
            sleep (0.1 + random 0.5);
            getPos _killed # 2 < 1 || {time > _timeout}
        };

        private _pos = getPosATL _killed vectorMultiply [1, 1, 0];
        if (surfaceIsWater _pos) exitWith {};

        private _holder = createVehicle ["GroundWeaponHolder", _pos, [], 0, "CAN_COLLIDE"];
        {_holder addItemCargoGlobal _x} forEach _items;
    };
}];
SHZ_initZombieLootHandlers = true;
