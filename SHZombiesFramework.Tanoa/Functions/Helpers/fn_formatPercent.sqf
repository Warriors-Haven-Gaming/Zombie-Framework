/*
Function: SHZ_fnc_formatPercent

Description:
    Formats the given percentage into a string.

Parameters:
    Number percentage:
        The percentage in the range [0, 1].

Returns:
    String

Examples:
    (begin example)
        [0.123] call SHZ_fnc_formatMoney;
    (end)
    (begin example)
        0.456 call SHZ_fnc_formatMoney;
    (end)

Author:
    thegamecracks

*/
params ["_percentage"];
format ["%1%%", floor (_percentage * 100)]
