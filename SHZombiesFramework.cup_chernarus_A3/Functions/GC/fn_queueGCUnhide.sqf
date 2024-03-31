/*
Function: SHZ_fnc_queueGCUnhide

Description:
    Schedules an array of objects to be unhidden discreetly.

Parameters:
    Array objects:
        The array of objects to be unhidden. The first object is used
        as the center to determine if players are present.
    Number minDistance:
        (Optional, default SHZ_gcUnhideDistance)
        The first object's minimum distance to other players before
        objects can be unhidden.

Examples:
    (begin example)
        [[_tree1, _tree2]] call SHZ_fnc_queueGCUnhide;
    (end)
    (begin example)
        [[_tree1, _tree2], 1000] call SHZ_fnc_queueGCUnhide;
    (end)

Author:
    thegamecracks

*/
params ["_objects", ["_minDistance", SHZ_gcUnhideDistance]];
if !(_objects isEqualType []) then {_objects = [_objects]};
SHZ_gcUnhideQueue pushBack [_objects, _minDistance];
