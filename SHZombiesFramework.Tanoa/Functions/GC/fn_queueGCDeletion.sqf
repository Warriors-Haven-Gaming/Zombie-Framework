/*
Function: SHZ_fnc_queueGCDeletion

Description:
    Schedules an array of objects to be deleted discreetly.

Parameters:
    Array objects:
        The array of objects to be deleted. The first object is used
        as the center to determine if players are present.

Examples:
    (begin example)
        [[_object1, _object2]] call SHZ_fnc_queueGCDeletion;
    (end)

Author:
    thegamecracks

*/
params ["_objects"];
if !(_objects isEqualType []) then {_objects = [_objects]};
SHZ_gcDeletionQueue pushBack _objects;
