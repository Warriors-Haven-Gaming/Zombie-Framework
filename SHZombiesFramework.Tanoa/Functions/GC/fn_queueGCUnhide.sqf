/*
Function: SHZ_fnc_queueGCUnhide

Description:
    Schedules an array of objects to be unhidden discreetly.

Parameters:
    Array objects:
        The array of objects to be unhidden. The first object is used
        as the center to determine if players are present.

Examples:
    (begin example)
        [[_tree1, _tree2]] call SHZ_fnc_queueGCUnhide;
    (end)

Author:
    thegamecracks

*/
params ["_objects"];
if !(_objects isEqualType []) then {_objects = [_objects]};
SHZ_gcUnhideQueue pushBack _objects;
