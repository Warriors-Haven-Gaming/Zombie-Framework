/*
Function: SHZ_fnc_isShopkeeperPurchaseValid

Description:
    Checks if the given shopkeeper purchase is valid.

Parameters:
    Number purchaseTime:
        The time at which the vehicle was purchased.
    Object vehicle:
        The vehicle that was purchased.

Author:
    thegamecracks

*/
params ["_purchaseTime", "_vehicle"];
if (time > _purchaseTime + SHZ_refundShopkeeperPurchase_maxTime) exitWith {false};
if (!alive _vehicle) exitWith {false};
true
