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
    },
    [],
    1.5,
    true,
    true,
    "",
    "true",
    3
];

private _items = [] call SHZ_fnc_lookupShopkeeperCatalog;
{
    values _y params keys _y;
    _obj addAction [
        format ["Buy %1 ($%2)", _displayName, _cost], // TODO: localize
        {
            params ["_target", "_caller", "", "_arguments"];
            private _context = _target getVariable "SHZ_shopkeeper_context";
            [_caller, _arguments, _context] remoteExec ["SHZ_fnc_requestToBuyItem", 2];
        },
        _x,
        1.5,
        true,
        true,
        "",
        "true",
        3
    ];
} forEach _items;
