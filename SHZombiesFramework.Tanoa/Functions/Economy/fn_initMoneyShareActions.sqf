/*
Function: SHZ_fnc_initMoneyShareActions

Description:
    Adds actions for sharing money to the given unit.
    Function must be executed on client.

Parameters:
    Object unit:
        The unit to add money share actions to.

Examples:
    (begin example)
        [_unit] call SHZ_fnc_initMoneyShareActions;
    (end)

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

params ["_unit"];
if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {};
if (_unit getVariable ["SHZ_initMoneyShareActions", false] isEqualTo true) exitWith {};

if (isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
    private _moneyShare = [
        "SHZ_MoneyShare",
        localize "$STR_SHZ_initMoneyShareActions",
        "",
        {},
        {getPlayerUID _target isNotEqualTo ""},
        {},
        [],
        [0,0,0],
        3
    ] call ace_interact_menu_fnc_createAction;

    private _moneyShareAmounts =
        [250, 500, 1000, 2500, 5000, 10000]
        apply {
            [
                format ["SHZ_MoneyShare_%1", _x],
                _x call SHZ_fnc_formatMoney,
                "",
                {
                    params ["_target", "_player", "_args"];
                    _args params ["_money"];
                    [_player, _target, _money] remoteExec ["SHZ_fnc_shareMoney", 2];
                },
                {true},
                {},
                [_x],
                [0,0,0],
                3
            ] call ace_interact_menu_fnc_createAction
        };

    [_unit, 0, ["ACE_MainActions"], _moneyShare] call ace_interact_menu_fnc_addActionToObject;
    {
        [_unit, 0, ["ACE_MainActions", "SHZ_MoneyShare"], _x] call ace_interact_menu_fnc_addActionToObject;
    } forEach _moneyShareAmounts;
};

_unit setVariable ["SHZ_initMoneyShareActions", true];
