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
            private _locality = [0, -2] select isDedicated;
            [_x, _units] remoteExec ["SHZ_fnc_addEscortAction", _locality, _x];
        } forEach _units;
    (end)

Author:
    thegamecracks

*/
if (isDedicated) exitWith {};

params ["_unit", ["_linked", []]];

_unit addAction [
    "Escort",
    {
        params ["_target", "_caller", "", "_arguments"];
        _arguments params ["_linked"];

        if (leader _caller isNotEqualTo _caller) exitWith {
            hint "Only your group leader can escort units!";
        };

        private _units = _linked + [_target];
        _units joinSilent _caller;
    },
    [_linked],
    6
];
