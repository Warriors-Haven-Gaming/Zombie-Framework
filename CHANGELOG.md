# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [0.13.1] - 2024-02-22

### Added

- Kajman gunship to shopkeeper for 20000 BP

### Changed

- Make some QoL tweaks to the base, by @ZenoVoid
- Replace ammo and repair trucks with their armed equivalents
- Play sound for other purchase failures beside insufficient funds

### Fixed

- Zombie jump strength being unintentionally reduced
- Player loadouts being reset when joining in multiplayer
- Some blufor patrols not being hidden from map
- Locality of AI recruits not being transferred to players properly

## [0.13.0] - 2024-02-16

### Added

- Completely new base layout, courtesy of @ZenoVoid
  - Fog is now much less dense, with areas only near sea level having thick fog
  - View distance cap has been increased to 2km
  - Object view distance is now unlocked so players can adjust it to their liking
  - Add four plane shopkeepers at airports since the new base cannot support planes
  - Add two boat shopkeepers to the map
- New cars to vehicle shopkeeper:
  - Unarmed humvee for 2000 BP
  - Ammo/Fuel/Repair trucks for 5000 BP
- Custom loot scripts to replace Ryan's zombie loot module
  - Zombies will now drop magazines that you're carrying
- New message when vehicle purchases cannot be spawned due to obstructions

### Changed

- Save player loadout when exiting arsenal (singleplayer excempted)

### Fixed

- Vanilla "Unlock vehicle" action not re-appearing if the owner rejoins
- "Unflip vehicle" action not showing up after respawning
- Vanilla "Share Points" action not showing on players after they respawn
- Prevent shopkeepers from being targeted and killed by zombies
- Unintentionally saving on death in singleplayer, even with autosave disabled
- Log spam due to type error in garbage collector
- Improve MP reliability with Secure Intel mission

## [0.12.6] - 2024-02-14

Some changes have been omitted from this summary.
For more details, see the [0.12.6] full changelog.

### Added

- New items for shopkeepers:
  - RHSUSF Ammo Crate for 2000 BP
  - Xi'an VTOL for 30000 BP
- New action for refunding purchases from a shopkeeper within 2 minutes (#13)
- Vanilla action for sharing points between players (#4)
- New action for unflipping vehicles
- Mostly reliable friendly fire immunity from AI recruits
- [Pylon Manager](https://steamcommunity.com/sharedfiles/filedetails/?id=1867660876) configuration
  - Players can only rearm near a truck or service station

### Changed

- Increase point multiplier rates for killing zombies when outside of vehicles
- Exclude mission rewards from point multipliers
- Extend night-time point multipliers to cover dawn/dusk
- Main mission improvements:
  - When main mission is completed, generate a temporary safezone around that area
  - Main missions can now spawn at city capitals (i.e. Georgetown)
- Increase participation range of Rescue Civilians mission to 100m around the occupied building
- Delete AI recruits when there are no players/non-recruits left in their group
- Persist player loadouts after dying and then rejoining the game
  - KNOWN BUG: As of now this only applies to dying, and not players exiting the arsenal with a new loadout.
- Reduce number of damaged vehicles that spawn across the map

### Fixed

- Players being immune to conventional damage (bullets, explosions, etc.) after being revived
- End-of-trip points message not taking multipliers into account
- Main mission appearing inside safezones where zombies can't spawn
  - However, side missions that generate temporary safezones can still overlap the main mission
- Damaged vehicle spawns not being critically damaged
- Player callouts not always being muted properly

## [0.12.5] - 2024-02-11

### Added

- New vehicles for shopkeeper:
  - Blackhawk for 2000 BP
  - Humvee CROWS/M2 for 4000 BP
  - Stryker CROWS/M2 for 5000 BP
  - Armed Huey for 10000 BP
  - M1 Abrams for 10000 BP
  - CH-53 Super Stallion for 12000 BP
  - C-130J (Cargo) for 15000 BP
- New aircraft channel for pilot communications

### Changed

- Reduce ambient zombies for performance
  - Should make main AO a bit easier as well
- More aggressively garbage collect dead bodies and vehicle wrecks
- Increase M-ATV price to 5000 BP
- Increase Chinook price to 7000 BP
- Reduce overcast and fog a bit
- Double points multiplier to 20% every 500 BP
- Reduce accuracy of raiders
- Automatically assign main mission to players once it starts
- Disable callouts for AI recruits
- Reduce max spawn radius of hordes for Secure Intel

### Fixed

- Players being able to re-escort captured civilians
- Eject incapacitated players out of vehicles to avoid getting teleported to origin
- Try to heal players when incapacitated to prevent zombies executing them

## [0.12.4] - 2024-02-09

### Added

- Self-revive action for incapacitated players
  - Action appears after 30 seconds
  - Consumes 4 first aid kits upon usage (including modded first aid)
- Getting Started guide in map journal
- More ACE tips in map journal
- Vanilla action for unlocking vehicle purchases when ACE is not loaded
- Show points earned when returning to base with 1000+ BP
- Internal documentation to help developer onboarding

### Changed

- Increase M2 Bradley price to 15000 BP for balancing
- Increase damage against tanks from 0.2% to 0.5%
- Allow AI recruits to earn points for the owning player

### Fixed

- Artillery vehicle not appearing on server due to misconfigured locality
- Slightly improve damage negation of friendly fire at base

## [0.12.3] - 2024-02-06

### Added

- Supply Shopkeeper for buying containers and crates
  - Explosives Box for 300 BP
  - Grenades Box for 300 BP
  - Huron Ammo/Fuel/Medical/Repair Container for 1000 BP
  - Flexible Fuel Tank for 1500 BP
  - RHSUSAF Equipment/Launchers/Weapons Crate for 2000 BP
  - Vehicle Ammo Cube for 2000 BP
- Randomly spawn damaged vehicles across map for players to recover

### Changed

- Reduce revive time to 3 seconds
- Reduce garbage collection distance of zombies to 300m
  - Should make ambient zombies re-appear more often
- Tweak night-time points multiplier to more closely match night time
- Switch out SARC Medic at the AI Shopkeeper for Corpsman
- After sharing money with another player, show the new total for the receiving player
- Remove toolkit requirement for ACE Full Repair by default
- Include HE-FRAG and shotgun shells in M1 Abrams at base

### Fixed

- Reward notification not showing when completing main mission
- Player respawn causing some mission rewards to not be given
- Points multiplier not being updated when player is near base
- Missing watch in respawn loadout
- Players being able to recruit 1 AI over the limit

## [0.12.2] - 2024-02-05

### Added

- Various map changes from ZenoVoid
- Up to +50% points multiplier during night time
- Custom script to make zombies stop chasing players once out of sight for enough time
- Medic unit for AI shopkeeper (200 BP)
- ACE-specific features:
  - Points sharing for players using the ACE interaction menu
  - ACE-specific guide to map journal
  - Chat message when purchased vehicle is locked with ACE

### Changed

- Reduce zombie density around towns
- Reduce chance of demons at main mission
- Reduce zombie attraction from flashlights
- Reduce zombie/demon speeds
- Reduce distance at which zombies will focus on throwing vehicles to 5m
- Turn off vehicle knockback from zombie attacks
- Replace RHS marine respawn loadouts with one custom loadout by ZenoVoid
- Increase camouflage for players to compensate for AI ignoring fog
- Increase vibrance of friendly map icons

## [0.12.1] - 2024-02-03

### Changed

- Increase points multiplier rate to 10% every 500 BP
- Disable global channel

## Fixed

- Points multiplier being shown as a bare "x" when first connecting
- Really fix blufor AI not being able to contribute to main mission

## [0.12.0] - 2024-02-02

### Added

- New vehicles to who is now the Vehicle Shopkeeper:
  - MH-6M Little Bird for 2000 BP
  - CH-47F Chinook for 4000 BP
  - UGV Stomper RCWS for 5000 BP
  - UCAV Sentinel for 10000 BP
  - Armed Blackfish for 30000 BP
  - AH-64D for 20000 BP
- New AI Shopkeeper with limit of 6 AI per squad:
  - Rifleman for 100 BP
  - Autorifleman (M249/M27) for 150 BP
  - Breacher for 150 BP
  - Marksman for 150 BP
  - Sniper for 150 BP
  - Engineer for 200 BP
  - Grenadier for 200 BP
- Automatic vehicle refunds if they explode right after being purchased
- Points multiplier that increases as you gain points without returning to base
- Lock vehicle purchases with a key if ACE is loaded
- Default CBA settings for ACE
- New slots dedicated to Fire Support and UAV Operator

### Changed

- Re-priced Blackfoot to 20000 BP
- Re-priced Gryphon to 25000 BP
- Randomize the starting time of day
- Mute player callouts
- Mute civilian callouts within Rescue Civilians mission
- Disable VOIP over side channel

### Fixed

- AI kills not being counted towards main mission
- Some task icons occasionally showing underground/above ground
- Increase required space for vehicle shopkeeper to avoid purchases colliding

## [0.11.0] - 2024-02-01

### Added

- New main mission: Clear Region
- Team safezone at base to prevent friendly fire
- New shopkeeper items:
  - Quadbike for 1000 BP
  - M-ATV for 3500 BP
  - M2 Bradley for 5000 BP
  - AH-6M for 10000 BP
  - Blackfoot for 17500 BP
  - Gryphon for 27500 BP
- Show current BP on top-right of map
- Add BP reward to all missions

### Changed

- Rename currency to BP (blood points)
- Increase zombie/demon jump height

### Fixed

- BP being improperly formatted in player/game stats

## [0.10.0] - 2024-01-31

### Added

- New mission: Hunt Demons
- New mission: Assist Soldiers
- Initial implementation of economy and shopkeeper systems
  - For now, the shopkeeper only offers $150 pills
- New loading screen picture

### Changed

- Improve localization support for existing code

### Fixed

- Dramatically improve spawn position algorithm for hordes
  - Previously zombies were very likely to spawn inside buildings or rocks
- Attempt to get zombies unstuck when needed
- Rescue Civilians mission failure being counted as completed
- Spawners occasionally not activating due to improper Z heights

## [0.9.0] - 2024-01-29

### Added

- New base layout by Zenovoid ⭐⭐⭐⭐⭐
- Snowing / falling ashes weather

### Changed

- Allow zombies to throw empty vehicles

### Fixed

- Mission tasks sometimes appearing at origin or otherwise overly inaccurate locations
- Properly garbage collect zombies near safezones with blufor AI
- Prevent civilians from attacking blufor
- Don't render map icons for blufor Logic entities

## [0.8.0] - 2024-01-29

### Added

- New mission: Rescue Civilians

### Changed

- Concentrate loitering zombies around villages and cities
- Tweak fog density / decay
  - Fog should generally be less dense with less thickness at higher peaks of Tanoa
- Don't spawn car wrecks in safezones

### Fixed

- Loitering zombies appearing more slowly when most blufor units are in safezones
- Remove duplicate version text in init messages
- Improper checking of water when generating the Clear Raiders mission
- Various issues with spawning compositions

## [0.7.0] - 2023-11-14

### Added

- Automatic mission spawns (restarting no longer required)
- Record player death statistics
- Give enemies flashlights in Clear Raiders mission
- Show version in mission briefing name

### Fixed

- Admin actions not being available on player-hosted servers
- Friendly icons showing civilians when dead/incapacitated

## [0.6.1] - 2023-11-13

### Added

- Admin action for forcing save
- Admin action to toggle autosaving

### Fixed

- Zombie kills being tracked for AI
- Clear Zombies mission not tracking participants correctly

## [0.6.0] - 2023-11-13

### Added

- Initial work on custom save system
  - Zombie kills and mission completions are tracked per-user and per-save
  - Stats can be viewed at base via a whiteboard
  - No ability to switch between saves, for now

### Fixed

- Wind strength limiting fog to 90%
- Disable built-in saving to prevent missions from breaking
- Clear Zombies mission ending before its last horde can spawn in
- Mission cleanup taking 30s longer than normal

## [0.5.14] - 2023-11-09

### Changed

- Improve Clear Zombies mission
  - Increase spawner hordes for players to fight off
  - Prevent ambient hordes from spawning
  - Generate 400m safezone after completion, lasting 30min

### Fixed

- Actually fix dead zombies being respawned by spawners

## [0.5.13] - 2023-11-09

### Changed

- Lock command channel to group leaders

### Fixed

- Car wrecks being placed inside bridges when near terrain
- Zombie/raider groups not being automatically deleted
- Clear Raiders task possibly being reassigned to null leader
- Base vehicles not being unlocked for all players

## [0.5.12] - 2023-11-08

### Fixed

- Improve car wrecks positioning to avoid floating above terrain

## [0.5.11] - 2023-11-08

### Changed

- Increase vehicle icon/text scale when zoomed out

## [0.5.10] - 2023-11-08

### Changed

- Place group icons offset from leader
- Increase vibrance of group icons

## [0.5.9] - 2023-11-08

### Added

- Garbage collection of loot after 5 minutes

### Fixed

- Raider locations not being properly randomized
- Arsenal box being destructible

## [0.5.8] - 2023-11-08

### Added

- Draw group icons beside leaders on map when zoomed out
- Draw leader lines under unit icons

## [0.5.7] - 2023-11-08

### Changed

- Enable debug console for logged-in admin

### Fixed

- Dead zombies being respawned by spawner
- Secure Intel being completed for other clients/dedicated server when interrupting download

## [0.5.6] - 2023-11-07

### Changed

- Allow spawners to recover deleted zombies

## [0.5.5] - 2023-11-07

### Changed

- Prevent garbage collection around all blufor units
- Enable engineer/explosive specialist/medic traits for players
- Increase stealth coefficients for players

### Fixed

- 5 player slots missing from lobby
- Load factor not being updated for Join-In-Progress players

## [0.5.3] - 2023-11-07

### Changed

- Increase minimum altitude for ambient hordes to 30m

### Fixed

- Mission compositions being incorrectly simulated on multiplayer clients

## [0.5.2] - 2023-11-07

### Added

- Discreet deletion of mission objects and terrain restoration

### Fixed

- Clear Raiders mission being repeatedly un-assigned after leader changes

## [0.5.1] - 2023-11-07

### Added

- More cars and helicopters at base for players to use

### Changed

- Increase vehicle abandonment distance to 500m
- Decrease revive time to 10s with 2x medic factor
- Turn on notifications for vehicle respawns

### Fixed

- Friendly map icons not loading consistently
- Intel laptop action missing for JIP players
- Simulation not being enabled for intel building

## [0.5.0] - 2023-11-06

### Added

- Generate car wrecks along roads to make car traversal harder,
  especially near villages and cities

### Fixed

- Colors of friendly icons on map not matching the unit's side

## [0.4.0] - 2023-11-06

### Added

- Show custom friendly icons on map
- New mission: Clear Raiders

### Changed

- Scale quantity of ambient hordes based on player count, movement, and lighting
- Reduce zombie detection distance from 1km to 100m to make escaping them easier

## [0.3.0] - 2023-11-04

### Added

- 50 playable units for multiplayer
- Ambient horde dynamic scaling based on player movement
- Player loadout persistence on death
- Player loadout randomization at start of gamemode

### Changed

- Increase player load capacity by 25%
- Disable player AI in multiplayer

## [0.2.0] - 2023-11-04

### Added

- Ambient hordes with safezones
- Garbage collection for zombies

### Changed

- Use glocks and flashlights for unit loadouts

## [0.1.0] - 2023-11-04

### Added

- 50% chance of loitering horde at Secure Intel

### Changed

- Persist Secure Intel download progress when interrupted
- Only show Secure Intel interrupt message for nearby players

### Fixed

- Dynamic simulation being broken when hordes are spawned in unscheduled environment

## [0.1.0] - 2023-11-03

This marks the first prototype of the zombie framework! The gamemode itself
is pretty barebones, having only four playable RHSUSAF units and two mission
types with five of each being randomly generated at the start.

![](https://raw.githubusercontent.com/Warriors-Haven-Gaming/Zombie-Framework/467565bcc53ef701fc7f89dac938033e806d8f1a/docs/images/banner.jpg)

[Unreleased]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.13.1...main
[0.13.1]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.13.0...v0.13.1
[0.13.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.6...v0.13.0
[0.12.6]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.5...v0.12.6
[0.12.5]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.4...v0.12.5
[0.12.4]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.3...v0.12.4
[0.12.3]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.2...v0.12.3
[0.12.2]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.12.1...v0.12.2
[0.12.1]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/ac754302e47b1bfcebb9ea20f0f675296a0c25c7...v0.12.1
[0.12.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.6.1...v0.7.0
[0.6.1]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.14...v0.6.0
[0.5.14]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.13...v0.5.14
[0.5.13]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.12...v0.5.13
[0.5.12]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.11...v0.5.12
[0.5.11]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.10...v0.5.11
[0.5.10]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.9...v0.5.10
[0.5.9]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.8...v0.5.9
[0.5.8]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.7...v0.5.8
[0.5.7]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.6...v0.5.7
[0.5.6]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.5...v0.5.6
[0.5.5]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.3...v0.5.5
[0.5.3]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.2...v0.5.3
[0.5.2]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/Warriors-Haven-Gaming/Zombie-Framework/releases/tag/v0.1.0
