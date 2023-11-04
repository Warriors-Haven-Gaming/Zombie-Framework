/*
Function: SHZ_fnc_displayTimer

Description:
    Displays a countdown timer and returns once complete.

Parameters:
    Number duration:
        The amount of time to count down in seconds.
        If fractional, the duration will be rounded down.
    String message:
        (Optional, default "$STR_SHZ_defaultTimer")
        The message to show to the user, which can be a Structured Text template.
        Strings prefixed with a $ are automatically localized.
        The following variables are provided:
            %1: The amount of time elapsed in seconds.
            %2: The total time in seconds.
            %3: The time remaining in seconds.
    Array area:
        (Optional, default [])
        If provided, the player must remain within this area to see the timer.
    Array condition:
        (Optional, default [0, {true}])
        An array containing the arguments and function name or code to run every second.
        If the condition returns false, the timer will stop and return false.

Returns:
    Boolean
        True if timer was fully elapsed, false otherwise.

Examples:
    (begin example)
        [60] call SHZ_fnc_displayTimer;
    (end)
    (begin example)
        _area = [getPos player,50,50,0,false];
        [60, "$STR_SHZ_defaultTimer", _area, [_area,{player inArea _this}]] call SHZ_fnc_displayTimer;
    (end)

Author:
    thegamecracks

*/
params ["_duration", ["_message","$STR_SHZ_defaultTimer"], ["_area", []], ["_condition", [0, {true}]]];

_duration = floor _duration;
if (_duration <= 0) exitWith {true};
if (_message select [0,1] isEqualTo "$") then {_message = localize _message};
_condition params ["_conditionArgs", "_conditionCode"];
if (_conditionCode isEqualType "") then {_conditionCode = missionNamespace getVariable _conditionCode};

private _playerInArea = {_area isEqualTo [] || {player inArea _area}};
private _showHint = {
    if (isDedicated || {!call _playerInArea}) exitWith {};
    params ["_i"];
    hintSilent formatText [_message, _i, _duration, _duration - _i];
};

private _hasElapsed = for "_i" from 0 to _duration - 1 do {
    if !(_conditionArgs call _conditionCode) exitWith {false};
    [_i] call _showHint;
    sleep 1;
    true
};
if (_hasElapsed) then {[_duration] call _showHint};
_hasElapsed
