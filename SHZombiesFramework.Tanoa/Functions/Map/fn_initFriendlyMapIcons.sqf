/*
Function: SHZ_fnc_initFriendlyMapIcons

Description:
    Sets up the custom friendly map icons.

Author:
    Zenovoid, thegamecracks

*/
waitUntil {sleep 1; !isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_display"];

    private _mapScale = ctrlMapScale _display;
    private _iconScale = linearConversion [0.01, 0.15, _mapScale, 16, 20, true];
    private _textMinMapScale = 0.062;
    private _lineMinMapScale = 0.175;

    // Separate units from vehicles
    private _allUnits = units side player;
    private _standaloneUnits = [];
    private _vehicles = [];
    {
        private _vehicle = objectParent _x;
        if (!isNull _vehicle) then {
            _vehicles pushBackUnique _vehicle;
        } else {
            _standaloneUnits pushBack _x;
        };
    } forEach _allUnits;

    // Draw unit icons
    {
        private _config = configFile >> "CfgVehicles" >> typeOf _x;
        private _side = side _x;
        private _textScale = 0.03;
        private _text = if (_mapScale <= _textMinMapScale) then {name _x} else {
            _textScale = 0.06;
            if (_x isEqualTo leader _x) then {groupId group _x} else {""}
        };
        _display drawIcon [
            getText (_config >> "icon"),
            [_side] call BIS_fnc_sideColor,
            getPosWorldVisual _x,
            _iconScale,
            _iconScale,
            getDirVisual _x,
            _text,
            1,
            _textScale,
            "TahomaB",
            "right"
        ];
    } forEach _standaloneUnits;

    // Draw unit lines
    if (_mapScale < _lineMinMapScale) then {
        private _getUnitPos = {
            params ["_unit"];
            private _vehicle = objectParent _unit;
            if (!isNull _vehicle) then {getPosWorldVisual _vehicle} else {getPosWorldVisual _unit}
        };
        {
            _display drawLine [
                _x call _getUnitPos,
                leader _x call _getUnitPos,
                [1,1,1,0.6]
            ];
        } forEach _allUnits;
    };

    // Draw vehicle icons
    {
        private _config = configFile >> "CfgVehicles" >> typeOf _x;
        private _side = side effectiveCommander _x;
        private _pos = getPosWorldVisual _x;
        private _text = if (_mapScale > _textMinMapScale) then {
            groupId group effectiveCommander _x
        } else {
            private _commander = effectiveCommander _x;
            private _crew = crew _x;
            format [
                "%1 (%2)",
                getText (_config >> "displayName"),
                // _crew apply {
                //     if (isPlayer _x) then {name _x} else {
                //         format ["%1 [AI]", name _x]
                //     }
                // } joinString ", "
                if (count _crew < 2) then {name _commander} else {
                    format ["%1 + %2", name _commander, count _crew - 1]
                }
            ]
        };
        _display drawIcon [
            getText (_config >> "icon"),
            [_side] call BIS_fnc_sideColor,
            _pos,
            _iconScale,
            _iconScale,
            getDirVisual _x,
            _text,
            1,
            0.03,
            "TahomaB",
            "right"
        ];
    } forEach _vehicles;

    // Draw group icons
    // {
    //     private _pos = getPosWorldVisual leader _x vectorAdd [10, 10, 0];
    //     private _config = configFile >> "CfgGroupIcons" >> _x getVariable ["ZEN_groupIcon","b_inf"];
    //     private _grpInfoText = _x getVariable ["ZEN_groupInfoText", groupId _x];
    //     _display drawIcon [
    //         getText (_config >> "icon"),
    //         getArray (_config >> "color") apply {call compile _x},
    //         _pos,
    //         _iconScale,
    //         _iconScale,
    //         0,
    //         _grpInfoText,
    //         1,
    //         0.03,
    //         "TahomaB",
    //         "right"
    //     ];
    // } forEach groups side player;
}];
