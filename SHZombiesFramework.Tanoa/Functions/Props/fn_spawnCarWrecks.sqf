/*
Function: SHZ_fnc_spawnCarWrecks

Description:
    Spawns car wrecks along roads in the given area.

Parameters:
    Position2D center:
        The area center to find roads.
    Number radius:
        The radius from the center to find roads.

Returns:
    Array
        An array of simple objects that were spawned.

Author:
    thegamecracks

*/
params ["_center", "_radius"];

private _baseDensity = 50;
private _townMaxDistance = 1000;
private _townDensityFactor = 5;
private _rightHandDrive = true;
private _wreckTypes = [
    "Land_Wreck_Car_F",
    "Land_Wreck_Car2_F",
    "Land_Wreck_Car3_F",
    "Land_Wreck_CarDismantled_F",
    "Land_Wreck_HMMWV_F",
    "Land_Wreck_Hunter_F",
    "Land_Wreck_Offroad_F",
    "Land_Wreck_Offroad2_F",
    "Land_Wreck_Skodovka_F",
    "Land_Wreck_Truck_dropside_F",
    "Land_Wreck_Truck_F",
    "Land_Wreck_Van_F"
];

private _wrecks = [];
private _roads = _center nearRoads _radius;
{
    getRoadInfo _x params ["_mapType", "_width", "_isPedestrian", "", "", "", "_begPos", "_endPos"];
    if (_isPedestrian) then {continue};
    if !(_mapType in ["ROAD", "MAIN ROAD", "TRACK"]) then {continue};

    _width = _width max 8;

    private _lengthVector = _endPos vectorDiff _begPos;
    private _lengthDir = acos (_lengthVector vectorCos [0, 1, 0]);
    private _length = vectorMagnitude _lengthVector;

    private _density = _baseDensity;
    private _town = nearestLocation [
        _begPos,
        ["Airport", "NameVillage", "NameCity", "NameCityCapital"],
        _townMaxDistance
    ];
    if (!isNull _town) then {
        private _distance = _begPos distance2D locationPosition _town;
        private _factor = linearConversion [0, _townMaxDistance, _distance, _townDensityFactor, 1, true];
        _density = _density / _factor;
    };

    for "_i" from 1 to random (_length / _density + 1) do {
        // NOTE: this could generate two vehicles beside each other,
        //       either on the same road segment or across two segments
        private _objPos = vectorLinearConversion [0, 1, random 1, _begPos, _endPos];
        private _normal = vectorNormalized _lengthVector vectorCrossProduct [0, 0, 1];
        private _normalScale = random _width - _width / 2;
        _normal = _normal vectorMultiply _normalScale;
        _objPos = _objPos vectorAdd _normal;

        private _objDir = _lengthDir + random [-180, 0, 180];
        switch (true) do {
            case (_rightHandDrive && {_normalScale < 0});
            case (!_rightHandDrive && {_normalScale > 0}): {
                _objDir = _objDir + 180;
            };
        };
        _objDir = _objDir + 180; // all the wreck types are facing the wrong way

        private _obj = createSimpleObject [selectRandom _wreckTypes, _objPos];
        _obj setDir _objDir;
        _obj setVectorUp surfaceNormal _objPos;
        _wrecks pushBack _obj;
    };
} forEach _roads;
diag_log text format ["%1 car wrecks spawned", count _wrecks];
_wrecks
