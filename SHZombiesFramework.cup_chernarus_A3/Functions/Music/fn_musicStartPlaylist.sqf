/*
Function: SHZ_fnc_musicStartPlaylist

Description:
    Runs a local music playlist in the background.
    The music playlist can be updated by changing the SHZ_musicPlaylist
    array.

Author:
    thegamecracks

*/
if (isNil "SHZ_musicPlaylist" || {SHZ_musicPlaylist isEqualTo []}) then {
    SHZ_musicPlaylist = [
        "Music_Theme_Contact",
        "Music_FreeRoam_Battle_Alien",
        "Music_FreeRoam_Russian_Theme",
        "Music_FreeRoam_Suspended_Loop_01",
        "Music_FreeRoam_Tension_Loop_01",
        "OM_Music01",
        "OM_Music02",
        "OM_Music03"
    ] call BIS_fnc_arrayShuffle;
};

if (
    isNil "SHZ_musicPlaylistEH"
    || {getEventHandlerInfo SHZ_musicPlaylistEH params [["_exists", false]]; !_exists}
) then {
    private _ehID = addMusicEventHandler ["MusicStop", {
        if (count SHZ_musicPlaylist < 1) exitWith {};
        _music = SHZ_musicPlaylist deleteAt 0;
        SHZ_musicPlaylist pushBack _music;
        playMusic _music;
    }];
    SHZ_musicPlaylistEH = ["MusicStop", _ehID];
    // For testing purposes, disable with `removeMusicEventHandler SHZ_musicPlaylistEH`.
    // If for whatever reason we need to stop the playlist in code, consider
    // writing a new function to stop the playlist.
};

playMusic (SHZ_musicPlaylist select -1);
