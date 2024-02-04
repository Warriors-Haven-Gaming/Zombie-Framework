/*
Function: SHZ_fnc_clearPylonLoadout

Description:
    Clears the pylon loadout of the given vehicle.

Parameters:
    Object vehicle:
        The vehicle to remove pylons weapons for.
        This must be local to the client calling this function.

Author:
    John Jordan, thegamecracks

*/
// Found on ARMA discord:
// https://discord.com/channels/105462288051380224/105462984087728128/1052387327504289812
params ["_vehicle"];

private _turrets = [[-1]];
private _toRemove = [];
_turrets append allTurrets _vehicle;

{
    private _turret = _x;
    private _baseWeapons = getArray ([_vehicle, _turret] call BIS_fnc_turretConfig >> "Weapons");
    private _weapons = _vehicle weaponsTurret _turret apply {toLower _x};
    // Avoiding array subtract in case there's a pylon and non-pylon copy of the same weapon
    // RHS has case bugs (zu-23 notably) so we force everything lower
    {_weapons deleteAt (_weapons find toLower _x)} forEach _baseWeapons;
    {_toRemove pushBack [_x, _turret]} forEach _weapons;
} forEach _turrets;

{_vehicle removeWeaponTurret _x} forEach _toRemove;
