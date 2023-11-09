/*
Function: SHZ_fnc_randomSafezoneID

Description:
    Generates a random safezone marker ID not in use.
    Note that this can potentially return a duplicate string if
    multiple calls are made to this function without a marker being
    created for each one. As such, running this in unscheduled environment
    alongside the marker creation would be preferable.
    See also: SHZ_fnc_createSafezone

Returns:
    String
        A unique marker name, or an empty string if unsuccessful.

Author:
    thegamecracks

*/
private _marker = "";
for "_i" from 1 to 100 do {
    private _id = format ["SHZ_safezone_%1", [6] call SHZ_fnc_randomString];
    if (markerColor _id isEqualTo "") exitWith {_marker = _id};
};
_marker
