# Economy

This contains the functions for handling player economy. Internally we call
this currency "money", but the terminology presented to players can be changed
in [fn_formatMoney.sqf] and [stringtable.xml].

## Basics

The fundamental function to this economy system is [fn_addMoney.sqf],
which adds (or subtracts) money from a player. As of now, there is no
equivalent getter function; money must be retrieved by looking up the
`playerMoney` save variable.

For security/reliability, money is tracked entirely on the server using
our [Saves] system. Clients cannot know how much money they have unless it
is either requested from the server by remote executing one of our functions
like [fn_viewMoney.sqf], or it is sent by the server like in [fn_playerMoneyMarkerLoop.sqf].
Clients should never assume the net worth they are given is up-to-date with
the server.

## Shopkeepers

The shopkeeper objects are initialized separately in [Props/fn_initShopkeeper.sqf],
but they rely on several functions defined here. The main function involved
is [fn_lookupShopkeeperCatalog.sqf], which defines all the items that can
be purchased. Each item has a unique identifier and contains basic information
about each item like:

- `_displayName`:
    The localized name of the item shown to the player.
- `_category`:
    The item this is categorized under, useful for filtering.
- `_cost`:
    The cost of the item to be purchased.
- `_functionName`:
    The function to be called by the server when the item is being purchased.
    As convention, function names should be prefixed with "buy", for example
    `SHZ_fnc_buyAIRecruit`.

To purchase an item, the client should remote execute [fn_requestToBuyItem.sqf]
on the server with the shopkeeper object and the item ID that they're purchasing.

### Context

Shopkeeper objects should define a `SHZ_shopkeeper_context` to be passed to
[fn_requestToBuyItem.sqf]. This context can be used by the item's functions
to help determine who to give an inventory item, or where to spawn a vehicle.

These keys are conventionally defined by shopkeeper contexts:

- `_vehicleSpawn`:
    The Position2D where vehicles should be spawned.
- `_vehicleSpawnDir`:
    The bearing at which vehicle spawns should be facing.
- `_vehicleSpawnRadius`:
    The maximum radius allowed for vehicle spawns.

[fn_requestToBuyItem.sqf] will also include the following keys in the context:

- `_shopkeeper`:
    The shopkeeper object that the item is being purchased from.
- `_player`:
    The player unit making the purchase.
- `_item`:
    The HashMap of the item being purchased.
- `_itemID`:
    The ID of the item being purchased.
- `_money`:
    The amount of money the player currently has before the purchase.

[fn_formatMoney.sqf]: ../Helpers/fn_formatMoney.sqf
[stringtable.xml]: ../../stringtable.xml
[fn_addMoney.sqf]: fn_addMoney.sqf
[Saves]: ../Saves/
[fn_viewMoney.sqf]: fn_viewMoney.sqf
[fn_playerMoneyMarkerLoop.sqf]: ../Map/fn_playerMoneyMarkerLoop.sqf
[Props/fn_initShopkeeper.sqf]: ../Props/fn_initShopkeeper.sqf
[fn_lookupShopkeeperCatalog.sqf]: fn_lookupShopkeeperCatalog.sqf
[fn_requestToBuyItem.sqf]: fn_requestToBuyItem.sqf
