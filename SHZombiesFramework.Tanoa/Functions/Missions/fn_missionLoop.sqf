/*
Function: SHZ_fnc_missionLoop

Description:
    Periodically spawns missions.

Author:
    thegamecracks

*/
private _functions = [
    "SHZ_fnc_msnClearDemons",
    "SHZ_fnc_msnClearRaiders",
    "SHZ_fnc_msnClearZombies",
    "SHZ_fnc_msnDownloadIntel",
    "SHZ_fnc_msnRescueCivilians"
];
private _minScripts = 6;
private _maxScripts = 15;
// NOTE: above variables could be parameterized

_functions = _functions select {
    private _predicate = missionNamespace getVariable [_x + "PreCondition", {true}];
    [] call _predicate
};

private _functionCounts = createHashMapFromArray (_functions apply {[_x, 0]});
private _scripts = [];
private _countActiveScripts = {
    {
        if (scriptDone _x) then {_scripts deleteAt _forEachIndex};
    } forEachReversed _scripts;
    count _scripts
};
private _refreshFunctionCounts = {
    /* Ensures that function counts don't go out of bounds. */
    private _counts = values _functionCounts;
    if (selectMax _counts < 1000) exitWith {};
    private _min = selectMin _counts;
    {_functionCounts set [_x, _y - _min]} forEach _functionCounts;
};
private _selectRandomFunction = {
    /* Selects a random mission function to be spawned. */
    call _refreshFunctionCounts;
    private _total = 0;
    {_total = _total + _y} forEach _functionCounts;

    private _functionChances = createHashMapFromArray (
        // Bias towards missions that haven't been spawned as much
        _functionCounts apply {
            private _chance = 1 - _y / (_total max 1);
            [_x, _chance]
        }
    );
    private _selected = keys _functionChances selectRandomWeighted values _functionChances;
    _functionCounts set [_selected, (_functionCounts get _selected) + 1];
    _selected
};

while {true} do {
    private _nScripts = call _countActiveScripts;
    if (_nScripts < _minScripts) then {
        for "_i" from 1 to (_maxScripts - _nScripts) do {
            private _function = call _selectRandomFunction;
            private _script = [] spawn (missionNamespace getVariable _function);
            _scripts pushBack _script;
            sleep (1 + random 4);
        };
    };
    sleep (60 + random 120);
};
