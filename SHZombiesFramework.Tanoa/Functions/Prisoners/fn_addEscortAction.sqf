/*
Function: SHZ_fnc_addEscortAction

Description:
    Adds an escort action to the given unit(s).
    Function must be executed on client.

Parameters:
    Object unit:
        The unit to add the capture action to.
    Array linked:
        (Optional, default [])
        An array of units to be included in the escort.
        This may include the same unit that has the action.

Examples:
    (begin example)
        [_unit] call SHZ_fnc_addEscortAction;
    (end)
    (begin example)
        _units = [_unitA, _unitB, _unitC];
        {
            [_x, _units] remoteExec ["SHZ_fnc_addEscortAction", SHZ_globalPlayerTarget, _x];
        } forEach _units;
    (end)

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

params ["_unit", ["_linked", []]];

_unit addAction [
    localize "$STR_SHZ_addEscortAction_action",
    {
        params ["_target", "_caller", "", "_arguments"];
        _arguments params ["_linked"];

        if (leader _caller isNotEqualTo _caller) exitWith {
            hint localize "$STR_SHZ_addEscortAction_notLeader";
        };

        private _units = _linked + [_target];
        _units joinSilent _caller;
    },
    [_linked],
    6,
    true,
    true,
    "",
    "alive _originalTarget && {group _originalTarget isNotEqualTo group _this}",
    3
];
