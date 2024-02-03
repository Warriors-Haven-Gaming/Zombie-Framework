/*
Function: SHZ_fnc_showBuyAIRecruitLimit

Description:
    Shows that the player has reached their recruit limit.
    Function must be remote executed on client from the server.

Parameters:
    Number limit:
        The maximum number of AI allowed in the player's group.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_limit"];
hint format [localize "$STR_SHZ_showBuyAIRecruitLimit", _limit];
