/*
Function: SHZ_fnc_setWeather

Description:
    Sets the weather for the map.
    Function must be executed on server.

Parameters:
    String string:
        The string to check for a suffix.
    String prefix:
        The prefix to look for.

Returns:
    Boolean

Examples:
    (begin example)
        ["foobar", "foo"] call SHZ_fnc_stringStartsWith;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

// https://community.bistudio.com/wiki/setRain
setHumidity 0.9;
forceWeatherChange;
[
    "a3\data_f\rainnormal_ca.paa",  // rainDropTexture
    1,                              // texDropCount
    0.01,                           // minRainDensity
    15,                             // effectRadius
    0.1,                            // windCoef
    2,                              // dropSpeed
    0.5,                            // rndSpeed
    0.5,                            // rndDir
    0.02,                           // dropWidth
    0.02,                           // dropHeight
    [0, 0, 0, 1],                   // dropColor
    0.1,                            // lumSunFront
    0.1,                            // lumSunBack
    5.5,                            // refractCoef
    0.3,                            // refractSaturation
    true,                           // snow
    false                           // dropColorStrong
] call BIS_fnc_setRain;
