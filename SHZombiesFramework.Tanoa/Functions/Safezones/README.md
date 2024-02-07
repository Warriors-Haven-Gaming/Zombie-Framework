# Safezones

Safezones are area markers that prevent other mission mechanics from applying
inside them. They are prefixed with `SHZ_safezone`, and exhibit behaviours like:

- Preventing ambient zombies from spawning
- Preventing car wrecks from spawning (only matters for pre-placed safezones)
- Preventing damaged vehicles from spawning (only matters for pre-placed safezones)

Missions can use the [fn_createSafezone.sqf] helper function to create safezones
in different areas.

## Team Safezones

Team safezones are a separate type of area marker generally used to designate a base.
They are prefixed with `SHZ_team_safezone`, and exhibit behaviours like:

- [fn_initTeamSafezoneHandlers.sqf]:
    Providing immunity to friendly fire from players
- [fn_moneyMultiplierLoop.sqf]:
    Resetting money multipliers earned by players
- [fn_addVehicleRefund.sqf]:
    Refunding recently purchased vehicles that explode in the safezone

Note that because `SHZ_team_safezone` is not a superstring of `SHZ_safezone`,
regular safezone behaviours don't apply to team safezones and must be manually
overlapped with two markers.

[fn_createSafezone.sqf]: fn_createSafezone.sqf
[fn_initTeamSafezoneHandlers.sqf]: fn_initTeamSafezoneHandlers.sqf
[fn_moneyMultiplierLoop.sqf]: fn_moneyMultiplierLoop.sqf
[fn_addVehicleRefund.sqf]: fn_addVehicleRefund.sqf
