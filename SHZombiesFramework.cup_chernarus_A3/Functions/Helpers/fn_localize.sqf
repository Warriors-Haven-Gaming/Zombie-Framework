/*
Function: SHZ_fnc_localize

Description:
    Localizes and cleans up a string.
    This is meant to help improve legibility of entries in stringtable.xml,
    allowing writers using a simple text editor to take advantage of whitespace.

Parameters:
    String stringName:
        The string to be localized. Strings starting with "$" are supported.

Returns:
    String

Author:
    thegamecracks

*/
params ["_stringName"];

private _string = localize _stringName;
_string = trim _string;
_string = _string regexReplace ["\s{2,}", " "];
_string = _string regexReplace ["<br/>\s+", "<br/>"];
_string
