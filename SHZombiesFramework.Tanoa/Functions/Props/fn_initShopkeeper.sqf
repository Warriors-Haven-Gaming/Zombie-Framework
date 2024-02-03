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

private _catalog = [] call SHZ_fnc_lookupShopkeeperCatalog;

private _selectedItems = keys _catalog;
if (count _categories > 0) then {
    _selectedItems = _selectedItems select {
        private _item = _catalog get _x;
        private _category = _item get "_category";
        _category in _categories
    };
};

private _itemOrder = _selectedItems apply {
    private _item = _catalog get _x;
    [_item get "_cost", _item get "_displayName", _x]
};
_itemOrder sort true;

{
    private _itemID = _x # 2;
    private _item = _catalog get _itemID;
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
