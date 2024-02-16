/*
Function: SHZ_fnc_initZombieSettings

Description:
    Initializes settings for zombies.
    This should run in initPlayerLocal.sqf and initServer.sqf
    to override any modules present in the mission.

Author:
    thegamecracks

*/
if (!isNil "SHZ_initZombieSettings") exitWith {};

// ===== Zombie Abilities =====

// Roaming:
//   Allows zombies to roam around their position.
//   nil  1
//   Off On
Ryanzombieslogicroam = 1;
Ryanzombieslogicroamdemon = 1;
// Feeding:
//   Allows zombies to feed on the dead bodies of their targets.
//   nil  1
//   Off On
Ryanzombiesfeed = 1;
Ryanzombiesfeeddemon = nil;
// Jumping:
//   Allows zombies to leap into the air at their targets.
//   nil  1
//   Off On
Ryanzombiesjump = 1;
Ryanzombiesjumpdemon = 1;
// Jumping Strength:
//      nil      1           2       3
//   Normal Weaker Even Weaker Weakest
Ryanzombiesjumpstrength = nil;
Ryanzombiesjumpdemonstrength = nil;
// Vehicle Throwing:
//   Allows zombies to throw cars at their targets (empty or occupied).
//   nil  1
//   Off On
Ryanzombiescanthrow = 1;
Ryanzombiescanthrowdemon = 1;
// Vehicle Throwing Distance:
//   The maximum distance from the vehicle to the target allowed for throwing.
Ryanzombiescanthrowdistance = 5;
Ryanzombiescanthrowdistancedemon = 10;
// Vehicle Throwing Strength:
//   nil     -1      1           2       3                   4
//   Off Normal Weaker Even Weaker Weakest Ridiculously Strong
Ryanzombiescanthrowstrength = 3;
Ryanzombiescanthrowdemonstrength = 3;
// Car Alarms:
//   Adds a chance for car alarms to go off when thrown.
RZ_VehicleAlarmsEnabled = false;
// Tank Throwing:
//   Allows zombies to throw tanks at their targets (empty or occupied).
//   nil  1
//   Off On
Ryanzombiescanthrowtank = nil;
Ryanzombiescanthrowtankdemon = 1;
// Tank Throwing Distance:
//   The maximum distance from the tank to the target allowed for throwing.
Ryanzombiescanthrowtankdistance = 5;
Ryanzombiescanthrowtankdistancedemon = 10;
// Tank Throwing Strength:
//   nil     -1      1           2       3                   4
//   Off Normal Weaker Even Weaker Weakest Ridiculously Strong
Ryanzombiescanthrowtankstrength = nil;
Ryanzombiescanthrowtankdemonstrength = 3;

// ===== Difficulty Settings =====

// Attack Speed:
Ryanzombiesattackspeed = 2.3;
// Attack Distance:
Ryanzombiesattackdistance = 2;
// Attack Damage (Humans):
Ryanzombiesdamage = 0.1;
// Attack Damage (Cars):
Ryanzombiesdamagecar = 0.01;
// Attack Damage (Aircraft):
Ryanzombiesdamageair = 0.01;
// Attack Damage (Tanks):
Ryanzombiesdamagetank = 0.005;
// Knockback (Humans):
Ryanzombiesattackstrenth = 0.002;
// Knockback (Cars):
Ryanzombiesdamagecarstrenth = 0;
// Knockback (Aircrafts):
Ryanzombiesdamageairstrenth = 0;
// Knockback (Tanks):
Ryanzombiesdamagetankstrenth = 0;

// ===== Infection Settings =====

// Infection Chance:
//   The chance in percentage a victim will become infected
//   if attacked by a zombie.
ryanzombiesinfectedchance = 10;
// Infection Rate:
//   The percentage of infection applied to the victim each minute.
ryanzombiesinfectedrate = 0.05;
// Immunity:
//   This isn't really a setting, but units can be marked as immune with:
//     _unit setVariable ["ryanzombiesimmunity", true, true];
//   Note however that immunity will be lost if the target dies,
//   or if "ryanzombiesinfected" is set back to 0.
// Infection Symptoms:
//   Infected units can show symptoms or be unknowingly infected.
//      0.9  0.7  0.5
//   Normal Less None
ryanzombiesinfectedsymptoms = 0.9;

// Infection Death:
//   The sound infected units will make if they die from infection.
//      0.9    0.7
//   Scream Silent
ryanzombiesinfecteddeath = 0.9;

// Antivirus Pills Duration:
//   Duration in seconds the consumer is immune to infection and its symptoms.
ryanzombiesantivirusduration = 300;

// WARNING: do not add an Infection Settings module as this script will repeat twice!
if (hasInterface) then {
	player execVM "\ryanzombies\antivirus\item_handler.sqf";
};

// ===== Loot Settings =====
// We have custom loot drops so this should always be disabled
ryanzombiesAllLoot = nil;

// ===== Movement Speed Settings =====

// (nil for default speed)
// Slow Zombies:
ryanzombiesmovementspeedslow = nil;
// Medium Zombies:
ryanzombiesmovementspeedmedium = 0.6;
// Fast Zombies:
ryanzombiesmovementspeedfast = 0.7;
// Demon Zombies:
ryanzombiesmovementspeeddemon = 0.6;
// Spider Zombies:
ryanzombiesmovementspeedspider = 0.5;
// Crawler Zombies:
ryanzombiesmovementspeedcrawler = nil;
// Walker Zombies:
ryanzombiesmovementspeedwalker = nil;
// Player Zombies:
ryanzombiesmovementspeedplayer = 1.5;

// ===== Resurrection Settings =====

// Resurrect as:
//   Victims will resurrect into the selected zombie type.
//    0.9    0.7  0.5    0.4   0.3    0.1    0.05
//   Fast Medium Slow Walker Demon Spider Brittle
ryanzombiesinfection = 0.9;
// Resurrection Timer:
//   The time it takes after the victim has died to resurrect.
ryanzombiesinfectiontimer = 30;
// Force Add Uniform:
//   Forces the victims to resurrect with the victims uniform,
//   however this stops the custom animations from working.
//   0.9 0.7
//    No Yes
ryanzombiesuniform = 0.9;

// ===== Zombie Settings =====

// Civilian Attacks:
//   Allows zombies to attack civilian targets.
//   nil  1
//   Off On
ryanzombiescivilianattacks = nil;
// Delete Dead Bodies:
//   Allows zombie bodies to be deleted after death.
//   nil  1
//   Off On
ryanzombiesdelete = 1;
// Detection Distance:
//   The max distance at which zombies will chase targets.
//   Despite the name, this doesn't actually affect the zombie's "detection"
//   ability which is dependent on Arma's spotting skill and group knowledge.
ryanzombieslimit = 500;
// Head Decapitation:
//   Defines what weapon type is required for decapitation.
//   nil: Very Heavy Weapons (.408 & Beyond)
//   1.6: Heavy Weapons (7.62mm & Beyond)
//   0.9: Medium Weapons (6.5mm & Beyond)
//   0.1: Light Weapons (9mm & Beyond)
Ryanzombiesdamagecaliberneeded = 0.1;
//     1 nil
//   Off  On
Ryanzombiesdisableexplodingheads = nil;
// Glowing Eyes:
//   Allows zombie eyes to glow red.
//   nil  1
//   Off On
ryanzombiesglow = nil;
//   Allows demon eyes to glow red.
//     1 nil
//   Off  On
ryanzombiesglowdemondisable = nil;
// Headshots Only:
//   Defines if headshots are needed to kill zombies.
//   nil  1
//   Off On
RZ_HeadshotsOnly = nil;
// Bleeding:
//   Allows zombies and targets to bleed when hit, injured or infected.
//     1 nil
//   Off  On
ryanzombiesdisablebleeding = nil;
// Invincibility:
//   Allows zombies to be invincible.
//   nil  1
//   Off On
Ryanzombiesinvincible = nil;
Ryanzombiesinvincibledemon = nil;
// Zombie Sounds:
//   The sounds zombies will make.
//       nil      1
//   Default Silent
ryanzombiesdisablemoaning = nil;
ryanzombiesdisableaggressive = nil;
// Jumping Sounds:
//   The sounds zombies will make while jumping.
//       nil      1
//   Default Silent
ryanzombiesdisablejumping = nil;
// Starting Animation:
//   Doesn't actually have any effect since SHZ_fnc_zombieInit
//   always plays the animation.
ryanzombiesstartinganim = nil;
// Initialization Script:
//   Whether ryan's zombie behaviour will be used.
//   See ryanzombies/zombie.sqf and ryanzombies/functions/fn_preinit.sqf
//   for more information.
//   As of now, we don't have custom zombie behaviour.
//     1 nil
//   Off  On
ryanzombiesdisablescript = nil;

// ==== Deletion Settings =====
// We have custom garbage collection so this should always be disabled
ryanzombiesdeletion = nil;
ryanzombiesdeletiondemons = nil;

// ===== Max Health Settings =====

// Zombie Max Health:
//   Changes the max health of the zombies.
//     0.7      0.5    0.9    0.97
// Default Stronger Weaker Weakest
ryanzombieshealth = 0.9;
ryanzombieshealthdemon = 0.9;

SHZ_initZombieSettings = true;
