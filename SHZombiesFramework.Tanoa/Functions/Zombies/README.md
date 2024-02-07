# Zombies

This contains functions involved in spawning most of the zombies in the mission.

Missions will most of the time be using either [fn_hordeSpawn.sqf] to spawn
a single horde, or [fn_hordeSpawnLoop.sqf] to create a horde spawner within
an area. Both scripts can accept one or more "horde types", defined in
[fn_hordeType.sqf], which dictates what unit types will be spawned.

> [!NOTE]
> While Zombies and Demons has their own spawner module, we want our missions
> to be procedurally generated, and trying to use 3DEN Editor modules from
> within scripts is inconvenient. More importantly, their spawner's
> implementation is not very efficient and will significantly worsen server
> performance when many spawners are involved. We've written our own spawner
> function to make the fewest area checks possible to minimize their
> performance impact, along with providing many parameters for customizability.
> See [fn_hordeSpawnLoop.sqf]'s docstring for more details.

[fn_hordeSpawn.sqf]: fn_hordeSpawn.sqf
[fn_hordeSpawnLoop.sqf]: fn_hordeSpawnLoop.sqf
[fn_hordeType.sqf]: fn_hordeType.sqf
