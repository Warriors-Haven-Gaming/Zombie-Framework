/*
Function: SHZ_fnc_initShopkeeper

Description:
    Initializes the given object as a shopkeeper.

Parameters:
    Object obj:
        The object to initialize.
    Array categories:
        (Optional, default [])
        The categories of items the shopkeeper can offer.
        If set to an empty array, all items are offerred.

Author:
    thegamecracks

*/
params ["_obj", ["_categories", []]];

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
if (count _categories > 0) then {
    private _skipped =
        keys _items
        select {
            private _item = _items get _x;
            private _category = _item get "_category";
            !(_category in _categories)
        };
    {_items deleteAt _x} forEach _skipped;
};
private _itemOrder = _items apply {[_y get "_cost", _y get "_displayName", _x]};
_itemOrder sort true;
{
    private _itemID = _x # 2;
    private _item = _items get _itemID;
    values _item params keys _item;
    _obj addAction [
        format ["Buy %1 (%2)", _displayName, _cost call SHZ_fnc_formatMoney], // TODO: localize
        {
            params ["_target", "_caller", "", "_arguments"];
            private _context = _target getVariable "SHZ_shopkeeper_context";
            [_target, _caller, _arguments, _context] remoteExec ["SHZ_fnc_requestToBuyItem", 2];
        },
        _itemID,
        1.5,
        true,
        true,
        "",
        "true",
        3
    ];
} forEach _itemOrder;
