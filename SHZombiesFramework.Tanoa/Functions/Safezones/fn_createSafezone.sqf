/*
Function: SHZ_fnc_createSafezone

Description:
    Creates a safezone marker.

Parameters:
    Array area:
        The safezone area in the format [center, a, b, angle, isRectangle].
        Similar to the format used for inArea except that c is ignored.
    Boolean local:
        (Optional, default false)
        If true, the marker will be local to the client.
        Recommended to enable this for network optimization if you need
        to customize the marker.

Returns:
    String
        The name of the marker created, or an empty string if unsuccessful.

Author:
    thegamecracks

*/
params ["_area", ["_local", false]];
[["SHZ_safezone_"], _area, _local] call SHZ_fnc_createAreaMarker
