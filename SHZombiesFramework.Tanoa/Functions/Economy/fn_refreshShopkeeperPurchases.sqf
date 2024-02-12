/*
Function: SHZ_fnc_refreshShopkeeperPurchases

Description:
    Removes any outdated entries from SHZ_shopkeeperPurchases.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

{
    private _netId = _x;
    private _purchases = SHZ_shopkeeperPurchases get _x;
    private _shopkeeper = _netId call BIS_fnc_objectFromNetId;
    if (isNull _shopkeeper) then {
        SHZ_shopkeeperPurchases deleteAt _netId;
        continue;
    };

    private _purchasesToRemove = [];
    {
        if (_x call SHZ_fnc_isShopkeeperPurchaseValid) then {continue};
        _purchasesToRemove pushBack _forEachIndex;
    } forEach _purchases;
    {_purchases deleteAt _x} forEachReversed _purchasesToRemove;
} forEach keys SHZ_shopkeeperPurchases;
