# Saves

This implements a save system for the mission using [missionProfileNamespace]
introduced in ARMA 3 v2.10. It is only meant to be used by the server.
Clients are not allowed to interact with this system directly.

Internally, all saves are stored in the `SHZ_saves` HashMap, each with a
unique string. Each save is itself a HashMap, which should only consist
of keys defined in [fn_getSaveVariableDefault.sqf]. In practice, most scripts
don't need to know about this, as they can use the [fn_getSaveVariable.sqf]
helper function to modify values, or [fn_setSaveVariable.sqf] if the value
is immutable.

If the `autosave` save variable is set to true, the server should spawn the
[fn_saveLoop.sqf] function to handle periodically saving the mission profile.

As of now, no versioning or migration process is implemented so all changes
to the save system must be backwards-compatible in order to avoid corrupting
saves after a mission update. As well, any keys that become obsolete will not
be automatically cleaned up from the mission profile.
This may change in a future update if it becomes necessary.

[missionProfileNamespace]: https://community.bistudio.com/wiki/saveMissionProfileNamespace
[fn_getSaveVariableDefault.sqf]: fn_getSaveVariableDefault.sqf
[fn_getSaveVariable.sqf]: fn_getSaveVariable.sqf
[fn_setSaveVariable.sqf]: fn_setSaveVariable.sqf
[fn_saveLoop.sqf]: fn_saveLoop.sqf
