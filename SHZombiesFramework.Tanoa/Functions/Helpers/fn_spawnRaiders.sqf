/*
Function: SHZ_fnc_spawnRaiders

Description:
    Spawns raiders at the given position.

Parameters:
    Number quantity:
        The number of raiders to spawn.
    PositionATL center:
        The position at which raiders will spawn around.
    Number radius:
        The radius around the position at which raiders will spawn around.
    Boolean flashlights:
        Decides if the raiders will spawn with flashlights.

Returns:
    Group
        The group that was spawned in.

Author:
    thegamecracks

*/
params ["_quantity", "_center", "_radius", "_flashlights"];

private _group = createGroup opfor;
private _unitTypes = [
    "I_C_Soldier_Para_7_F",
    "I_C_Soldier_Para_2_F",
    "I_C_Soldier_Para_3_F",
    "I_C_Soldier_Para_1_F",
    "I_L_Criminal_SG_F",
    "I_L_Looter_Rifle_F",
    "I_L_Looter_Pistol_F",
    "I_L_Looter_SG_F",
    "I_C_Soldier_Bandit_4_F"
];
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, _center, [], _radius, "NONE"];
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;
    if (_flashlights) then {
        _unit addPrimaryWeaponItem "acc_flashlight";
        _unit addHandgunItem "acc_flashlight_pistol";
        _unit enableGunLights "ForceOn";
    };
};
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
_group
