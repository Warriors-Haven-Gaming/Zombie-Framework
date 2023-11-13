/*
Function: SHZ_fnc_addParticipantHandler

Description:
    Adds a Killed event handler to a unit that appends players
    to an array. Helpful for determining the participants in a mission.
    This can be stacked multiple times for the same unit and can also
    be passed directly as a callback for SHZ_fnc_hordeSpawn.

Parameters:
    Object unit:
        The unit to add event handlers to.
    Array participants:
        The array that will contain all players.

Author:
    thegamecracks

*/
params ["_unit", "_participants"];

private _arrays = _unit getVariable "SHZ_participants";
if (isNil "_arrays") then {
    _arrays = [];
    _unit setVariable ["SHZ_participants", _arrays];
};
_arrays pushBack _participants;

if (isNil {_unit getVariable "SHZ_participants_ehIDs"}) then {
    private _killedEH = _unit addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator"];
        // UAV/UGV player operated road kill?
        if (isNull _instigator) then {_instigator = UAVControl vehicle _killer # 0};
        // player driven vehicle road kill?
        if (isNull _instigator) then {_instigator = _killer};
        if (isNull _instigator || {!isPlayer _instigator}) exitWith {};
        {
            _x pushBackUnique _instigator;
        } forEach (_unit getVariable "SHZ_participants");
    }];
    _unit setVariable ["SHZ_participants_ehIDs", [_killedEH]];
};
