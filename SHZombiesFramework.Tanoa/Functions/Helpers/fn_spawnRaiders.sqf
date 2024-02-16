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
private _unitTypes = ["raiders"] call SHZ_fnc_lookupUnitTypes;
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, _center, [], _radius, "NONE"];
    [_unit] joinSilent _group;
    _unit setSkill ["aimingAccuracy", 0.1];
    _unit setSkill ["aimingShake", 0.1];
    _unit setSkill ["aimingSpeed", 0.1];
    _unit setSkill ["spotDistance", 0.1];
    _unit setSkill ["spotTime", 0.1];
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
