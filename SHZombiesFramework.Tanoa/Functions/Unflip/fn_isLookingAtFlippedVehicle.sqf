/*
Function: SHZ_fnc_isLookingAtFlippedVehicle

Description:
    Checks if the player is looking at a vehicle that can be unflipped.

Returns:
    Boolean

Author:
    thegamecracks

*/
getCursorObjectParams params ["_vehicle", "", "_distance"];
if (!alive _vehicle) exitWith {false};
if (_distance > 2) exitWith {false};
if (["LandVehicle", "Reammobox_F"] findIf {_vehicle isKindOf _x} isEqualTo -1) exitWith {false};
private _angle = surfaceNormal getPosASL _vehicle vectorDotProduct vectorUp _vehicle;
_angle < 0.1
