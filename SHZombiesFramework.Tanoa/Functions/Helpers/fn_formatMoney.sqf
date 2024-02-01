/*
Function: SHZ_fnc_formatMoney

Description:
    Formats the given amount of money into a string.

Parameters:
    Number money:
        The amount of money to be formatted.

Returns:
    String

Examples:
    (begin example)
        [5000] call SHZ_fnc_formatMoney;
    (end)
    (begin example)
        1234 call SHZ_fnc_formatMoney;
    (end)

Author:
    thegamecracks

*/
params ["_money"];
private _sign = "";
if (_money < 0) then {_sign = "-"; _money = -_money};
_money = [_money] call BIS_fnc_numberText;
_money = _money splitString " " joinString ","; // TODO: change separator based on locale
format ["%1%2 BP", _sign, _money];
