/*
Function: SHZ_fnc_showBuyVehicleObstruction

Description:
    Shows that the vehicle spawn is obstructed.
    Function must be remote executed on client from the server.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
hint localize "$STR_SHZ_showBuyVehicleObstruction";
playSoundUI ["a3\missions_f_beta\data\sounds\firing_drills\checkpoint_not_clear.wss"];
