/*
Function: SHZ_fnc_initShopkeeper

Description:
    Initializes the given object as a shopkeeper.

Parameters:
    Object obj:
        The object to initialize.

Author:
    thegamecracks

*/
params ["_obj"];

_obj addAction [
    localize "$STR_SHZ_initShopkeeper_viewMoney",
    {
        params ["", "_caller"];
        [_caller] remoteExec ["SHZ_fnc_viewMoney", 2];
    }
];
