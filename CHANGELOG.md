# Changelog

## [1.51.2] - 2025-03-01

### Fixed

- Fixed minor typos in UK faction config

## [1.51.1] - 2024-04-20

### Fixed

- Fixed minor typos in German faction config

## [1.51.0] - 2024-04-08

### Changed

- Updated faction templates to match the new version of Project BLUFOR.

## [1.50.0] - 2022-11-03
### Removed
- Removed Drongo's Air modules

## [1.49.3] - 2022-05-06
### Added
- Added various modules regarding Drongo's Air, configured by S. Pixy
  - **Exclude aircraft**: Only really relevant if someone uses a drone and even then more of just a double check to help people avoid getting confused over whether they should just use a UAV terminal or the drongos UI. Simply sync to drone placed in Eden editor.
  - **Restrict users**: Have set the minimum rank to colonel. Basically means that unless a player is assigned the rank of colonel in settings, drongos air will not pop up as an option for the player base.
  - **Hide Radar Hints**: Hides system chat messages in relation to enemy positions.
  - **Hide all communication from aircraft**: Removes system chat messages informing of friendly AI planes movements etc.

## [1.49.2] - 2022-02-13
### Changed
- Updated limited arsenal templates
  - Re-added Leshen's Bandanas after class name changes
  - Removed ACE_DeadManSwitch
  - Removed Stealth Balaclavas
- For full changes, check the diff of `00-blank.txt`

## [1.49.1] - 2021-12-07
### Changed
- Debug console: Added Zuzu, removed Abey

## [1.49.0] - 2021-11-02
### Added
- Werthers' Headless Modules

## [1.48.0] - 2021-09-03
### Added
- Added new bandanas from Leshen's bandanas and 3CB to the limited arsenal templates
- New unit tracker markers:
  - Lima (logistics): maintenance
  - X-Ray: UAV
  - Thunder: artillery
  - Hotel (FOB team): service
  - Golf (heavy support: dedicated AT, MMG etc): support
  - RTO/FAC/JTAC: recon
- Players receive a notification when respawning without a bodybag
- New factions:
  - Afghan Army by M. Aneirin
  - Hellenic Army, Egyptian Army by S. Pixy

### Changed
- Kilo, Lima and HQ will now also receive respawn wave notifications
- Assets are now notified also when a player respawns without a bodybag (previously only waves)
- Assets that are notified about respawns can be defined in `initServer.sqf`
### Fixed
- Respawn screen notifications are less likely to go off-screen on small resolutions

## [1.47.1] - 2021-05-06
### Fixed
- Removed a leftover reference to `sthudPatch` that prevented the mission launch.

## [1.47.0] - 2021-05-05
### Added
- A global flag to disable full arsenals. See [limited-arsenal-howto.md](limited-arsenal-howto.md) for details.
- Limited arsenal faction templates by Jeepers
### Fixed
- A script error when adding a rearm to an existing object

### Removed
- Shacktac UI patch

## [1.46.0] - 2021-02-23
### Changed
- Change respawn to use an invisible helipad instead of an invisible marker
  - This allows setting the respawn location somewhere else than ground level (on aircraft carriers, inside buildings)
  - This version is required if playing with the ZEUSOPS mod version v1.12.0-a4 (2021-02-23) or later, moving the respawn mid-mission will not work in older template versions after the mod update.

## [1.45.0] - 2020-12-02
### Added
- Added a fuel consumption function that can be used to increase the consumption rates of selected vehicles

## [1.44.0] - 2020-11-20
### Added
- Heal players when rearming

## [1.43.0] - 2020-08-14
### Added
- Enabled CBA Target Debugging

## [1.42.1] - 2020-08-13
### Changed
- Changed vanilla smoke grenades to BAF smoke grenades.

## [1.42.0] - 2020-08-13
### Added
- Add earplugs to default loadout.

### Changed
- Change 4x scopes in default factions to 3x or lower.
- Change amount of splints a player receives in default loadout.

### Fixed
- Fix some factions being broken because of a missing bracket.
- Fix making an object a rearm box adding the action twice instead of resetting the uses.
- Fix launcher scope not being added properly in gearHandle.

## [1.41.0] - 2020-05-08
### Added
- Add notifying an array of groups when a player respawns.

### Changed
- Change ORBAT by adding a fourth squad to each platoon.
- Change cargo size of small fortification boxes placed with the module to 4.
- Change position, shadow color, and time length of zeus respawn wave notification.

## [1.40.0] - 2020-04-30
### Added
- Add 35 more player slots (total: 80).
- Add variables for unit tracker tracked elements.
- Add new company structure to unit tracker tracked elements.

### Changed
- Change ORBAT to be up to date with new company structure.

## [1.39.0] - 2020-04-10
### Added
- Add factions:
    - Czech army
    - Israeli army
    - Swedish army

### Changed
- Change factions gear:
    - Canadian army vest and main weapon
    - German army vest
    - Latvian army vest
    - UK army vest and main weapon
    - United nations vest

### Fixed
- Fix fortification box removing all addactions when placing or returning.
- Fix fortification box material count not updating for all players.
- Fix setting players as medic or engineer wrong.

## [1.38.0] - 2020-04-09
### Added
- A patch that fixes and extends some buggy Shacktac UI functionality:
  * ACE medics will now properly show the medic icon next to their name
  * Give ACE egineers the proper icon
  * Players with single-use AT (riflemen) or AA will no longer show up as AT

## [1.37.1] - 2020-04-09
### Fixed
- Fix Fortification box confirm and return actions appearing for every player on the caller.
- Fix 'You are not an engineer' message not appearing if the variable has never been set.
- Fix fn_giveObject in `fn_fortificationBox` not existing by initialising it.

## [1.37.0] - 2020-04-06
### Added
- Add entrenching tool to engineer loadout.
- Add custom icons for arsenal and rearm box.
- Add `fn_fortificationBox` function: Spawning a box that allows engineers to spawn fortifications.

## [1.36.0] - 2020-03-31
### Removed
- Remove PAK from medic loadout.

### Fixed
- Fix `fn_drawEditorObjects` drawing over other mapmarkers.

## [1.35.1] - 2020-03-28
### Changed
- Change rifle used by usmc from M16A3 to M16A4.

### Fixed
- Fix scope used by usmc.

## [1.35.0] - 2020-03-27
### Added
- Add factions:
    - Latvian army
    - Norwegian army
    - PMC east
    - PMC west
    - Russian msv
    - Sahrani liberation army
    - United nations (Irish)

### Fixed
- Fix infinite rearm displaying negative uses after using once.

## [1.34.0] - 2020-03-23
### Added
- Add `fn_drawEditorObjects` function: Naming triggers `drawEditorObjects_` with any suffix will draw editor placed objects in trigger area on the map.
- Add faction file system to replace gear variables in `initServer`, allowing for presets.
- Add rail attachment slot to loadouts.
- Add nightvision slot to loadouts and option in `initServer`.
- Add Load marksman option to gearBox.
- Add entrenching tool to rifleman loadout.
- Add factions:
    - Canadian army
    - French army desert
    - French army woodland
    - German army desert
    - German army woodland
    - UK army
    - US army desert
    - US army woodland
    - USMC desert
    - USMC woodland
- Add custom group management that doesn't display dead players as dead.

### Changed
- Change rearm box to only 1 rearm per box per person in `fn_gearBox`.
- Change medical supply ratio of medic role.

### Removed
- Remove CBA_settings file.

### Fixed
- Fix `initPlayerLocal` being executed before `initServer` was finished.
- Fix issue where saving your loadout does not specifically save the loaded ammo for every weapon.
- Fix gearbox module code being executed for every client when placed in the editor.

## [1.33.1] - 2020-01-16
### Added
- Add J. Abey to the list of debug console users

## [1.33.0] - 2020-01-03
### Added
- Add new ACE medical rewrite items to the default loadouts:
  * 2x tourniquets and 4x splints for all classes
  * A Personal Aid Kit and extra tourniquets and splints for the medic

### Fixed
- Use a compatible box for the default AR loadout.

### Changed
- Updated CBA settings from the server

    Contains the same settings file as the server, with all 'force force'
    lines removed. The settings on the server were updated to accommodate
    the recent ACE release v1.13.0 which included the medical rewrite.

## [1.32.0] - 2019-10-16
### Added
- 1 Use launcher for riflemen.
- Load grenadier option in `fn_gearBox`.

### Fixed
- Fix engineer receiving toolkit.

### Removed
- Teamleader no longer gets AT rocket or rifle ammo in their backpack.

## [1.31.1] - 2019-09-15
### Fixed
- Renamed `fn_mapFunctionalities` but didn't change the call in initPlayerLocal.

## [1.31.0] - 2019-09-14
### Added
- Map marker for zeuses with respawn information.
- Line under respawn position 3d marker when close to it to show exact location.

### Changed
- Renamed `fn_mapButtons` to `fn_mapFunctionalities` and refactored the code to use sub-functions.

## [1.30.1] - 2019-09-08
### Fixed
- Spectator death messages not showing the correct time.

## [1.30.0] - 2019-09-07
### Added
- Respawn position 3d marker for zeuses, marker alpha dependant on distance, but always visible.

### Changed
- Respawn position map marker not updated frequently enough.
- Slimmed down cfgFunctions in `description.ext`.

### Removed
- Remnants of force bodybag and force respawn wave.

## [1.29.1] - 2019-09-07
### Fixed
- `fn_coverMap` breaking when calling it a second time to adjust.

## [1.29.0] - 2019-09-05
### Added
- First time loading a default loadout will save that loadout.

### Changed
- Cargo size of arsenal/rearm boxes are now 4, regardless of the box used.
- Spawning arsenal/rearm boxes uses different syntax, to facilitate zeus modules.

### Removed
- Force Respawn Wave map button for zeuses.
- Force Bodybag map button for zeuses, replaced with a zeus module.
- Ability to move the Respawn location on the map, replaced with a zeus module.
- Unit tracker effects, because they were unused and made the function unnecessarily complicated.

### Fixed
- Players would receive map and/or watch on respawn, even when not present in saved loadout.

## [1.28.0] - 2019-07-30
### Changed
- Move map buttons to bottom left because terrain size is not always included in config.

## [1.27.0] - 2019-07-29
### Changed
- Merged orbats into single orbat module.
- Toggle grass marker is now spawned by code.
- Server performance marker is now at the same spot as orbat.
- Default covermap size is now 4000 instead of 4096.

## [Version 26 Hotfix] - 2019-07-05
### Fixed
- Typo in `fn_unitTracker` causing an error.

## [Version 26] - 2019-06-30
### Added
- Debug console for staff members

## [Version 25 Hotfix] - 2019-06-30
### Fixed
- AT Riflemen wouldn't spawn with launcher because of typo.

## [Version 25] - 2019-06-26
### Changed
- Covermap now has a marker on the map on which the covermap is based.
- Covermap is not editable in `initServer` anymore.

## [Version 24 Hotfix 2] - 2019-06-23
### Fixed
- Units did not receive headgear because of typo.

## [Version 24 Hotfix] - 2019-06-23
### Fixed
- `fn_coverMap` initial placement bug.
- `W`, `Y`, `Z` autobodybagging bug.
### Removed
- BIS coverMap module.

## [Version 24] - 2019-06-23
### Added
- New function `fn_coverMap` to replace vanilla covermap. Editable during gameplay.
- Autobodybag if player in group with groupId starting with `W`, `Y`, or `Z`.
### Changed
- Editable variables for gear, unitcolor and covermap are now in `initServer`, and editable during gameplay.

## [Version 23] - 2019-06-10
### Changed
- Binoculars for gearStart instead of just leader role.

## [Version 22] - 2019-04-07
### Added
- Backpack and a toolkit to the engineer loadout.

### Changed
- Made engineers able to repair vehicles anywhere with a toolkit.

## [Version 21] - 2019-03-27
### Changed
- Updated CBA settings after VCOM update.

## [Version 20] - 2019-03-26
### Added
- VCOM settings to the CBA settings.

### Fixed
- The visible Zeus bug when using TFAR 1.0.

## [Version 19] - 2019-01-07
### Removed
- Backpack contents of rifleman.

### Fixed
- Engineer assignment.

## [Version 18] - 2019-01-05
### Changed
- Increased epinephrine amount of default medic.

### Removed
- Colors per faction in unitTracker.
- IFA fire for effect artillery.
- mission.sqm's for every terrain.

### Fixed
- Respawn timer message.

## [Version 17] - 2018-09-16
### Changed
- Lowered damage threshold to 2.5.

### Removed
- Player bodies despawning after disconnect.

### Fixed
- The death notifications.

## [Version 16] - 2018-09-10
### Added
- Two more mod slots.

### Changed
- Medical settings (lowered death timer, increased damage threshold).
- The default loadouts (TL's get colored smokes and a filled backpack, riflemen get a filled backpack).
- The death notifications.

## [Version 15 Hotfix] - 2018-08-19
### Added
- Dariyah template.

## [Version 15] - 2018-08-05
### Added
- A gearSnitch, which will tell the executer who has suspicious items.

### Changed
- Medical system by adding ACE revive.
- The default gear in the gearhandle.

## [Version 15 Hotfix] - 2018-06-15
### Fixed
- Fixes to bodybagging.

## [Version 14] - 2018-07-04
### Added
- Effects to `fn_unitTracker` (updateInterval, updateIntervalDeviation, alphaMinimum, alphaMaximum, flickerOnDuration, flickerOnDurationDeviation, flickerOffDuration, flickerOffDurationDeviation).
- An editor-placing option to the `fn_gearBox`. Put
    ```sqf
    [2, this] spawn ZO_fnc_gearBox;
    ```
    in the init of an ammobox to make it a gear box.

### Changed
- Restructured `fn_unitTracker` (previously called `fn_dynamicGroupsMarkers`.
- Everyone gets GPSes, and GPSes are required to see the unitTracker markers.

## [Version 13] - 2018-06-24
### Removed
- Unnecessary file.

### Fixed
- Bodybagging sometimes not working.
- Horrible nightvision settings.

## [Version 12] - 2018-05-20
### Changed
- Forced `STHud_Settings_Occlusion` to false.

### Fixed
- Waves not triggering bugs.
- Gear loading now not properly removing and adding everything.

## [Version 11 Hotfix] - 2018-05-12
### Added
- Lythium template.

### Removed
- Kunduz template.

### Fixed
- Hotfix `fn_showFPS`.

## [Version 11] - 2018-05-07
### Added
- Teamleaders get binos by default.
- Waves trigger automatically every 7 to 8 minutes.
- Zeuses get notified when a wave is triggered.
- Zeuses now have the options to 'FORCE RESPAWN WAVE', 'FORCE BODYBAG', and 'TOGGLE RESPAWN' (turning auto respawning and auto waves on/off).

### Changed
- Un-forced ace goggles effects, and made it none by default.
- Autoriflemen get 2x scopes by default.

### Fixed
- Items in the bino slot now get properly saved and loaded.

## [Version 10 Hotfix 2] - 2018-05-05
### Fixed
- forcebodybagging.

## [Version 10 Hotfix] - 2018-04-25
### Fixed
- Loading the default presets from gearBox.

## [Version 10] - 2018-04-22
### Added
- More roles to the `fn_gearHandle` (AT Rifleman and Teamleader).

### Changed
- Lower ace-cookoff time.
- Un-force ace viewdistance limit.
- 'SAVE loadout for rearm' now saves your whole loadout.
- 'REARM' is now called on respawn if you have a loadout saved.

### Removed
- The rearm-plus box. It shouldn't be used. Use either the start box or the rearm box.

### Fixed
- Some ace ballistics regarding zeroing.

## [Version 9] - 2018-04-15
### Added
- Yemplates for Al Rayak, Malden 2035 and Kunduz (including 2 bases).

### Changed
- Un-forced some settings in CBA settings.
- Can't handcuff friendlies anymore.
- Explosives don't explode on defusal anymore.
- Replaced `fn_gearStart` with `fn_gearBox` and `fn_gearHandle`.

### Removed
- Some unused functions (`fn_gearInsurgent`, `fn_halo`, `fn_restrictedGear`, `fn_standardLoadouts`) and `fn_halo` soundfile.

### `fn_gearHandle`:
Like the zeus used to have to do in the gearStart, the zeus needs to define some gear in the `fn_gearHandle` (as seen [here](https://prnt.sc/j5kkbs)).

### `fn_gearBox`:
The zeus can put down one for three boxes:
- A box with the 'SAVE loadout for rearm'-action (which saves the contents of your containers + launcher), 4 basic loadout actions (autorifleman, engineer, medic & rifleman) derived from the gear defined in the `fn_gearHandle` (and yes, loading medic or engineer actually sets you as one), and both arsenals (as seen [here](http://prntscr.com/j5nyeb)).
- A box with the 'REARM'-action, which loads up the saved loadout, without resetting your radio or radiobackpack (as seen [here](http://prntscr.com/j5nilb)).
- A box with the 'REARM'-action, and both arsenals (not necessary, just there in case there will be a scenario in which it will).

```sqf
// START USAGE:
[0, player] spawn ZO_fnc_gearBox;

// REARM USAGE:
[1, player] spawn ZO_fnc_gearBox;

// REARM-PLUS USAGE:
[2, player] spawn ZO_fnc_gearBox;
```

## [Version 8] - 2018-03-16
### Added
- Moveable spawn.

## [Version 7] - 2018-02-12
### Added
- Templates for Isla Abramia, Isla Duala, Isla Panthera, Isla Panthera (winter), and Tembelan Island.

### Changed
- Reinforcement waves can now be called by any zeus, instead of by the platoonleader.
- All zeuses now get a notification when any zeus has called a reinforcement wave.

### Fixed
- ACE ranging.
- Bug where respawntimer went back to 20 minutes.

## [Version 6] - 2018-02-04
### Changed
- Respawntimer reduced to 15 minutes.
- Microdagr view full instead of nothing.
- Quick mount settings not forced anymore.

### Removed
- AI unconsciousness.
- Unnecessary STUI restrictions removed.

## [Version 5] - 2018-01-20
### Changed
- Removed all the non-vanilla modules and setup all the addon settings. Besides loading them into the scenario, they are also forced via the cba\_settings.sqf file in the mission folder. (I haven't tested if this fixes any issues, neither have I tested if this at all works. Curious to hear what the result is.)
- Changed some settings from what we previously had in our ace settings (because I thought it might make sense):
  * Cookoff is still on, but it only takes 50% of the time it did before.
  * Anyone can repair a vehicle to a certain amount with a toolkit, only near a repair vehicle/facility, you can bring it to full with a kit (no need for engineers anymore).
  * Increased map gestures range slightly.
  * AI unconsciousness 50/50.

## [Version 4] - 2017-10-27
### Changed
- Small update to fix `fn_handleRespawn`.

## [Version 3] - 2017-09-24
### Added
- The wave respawn system. (By default, players will respawn after 20 minutes, or with the next wave (when body bagged). The platoonleader can - just like the toggle grass - call for a respawnwave, which will respawn all bagged players.)
- `fn_standardLoadouts`, which will spawn a ammobox with a get standard loadouts addaction on it. The box will be spawned around whoever calls it (yes, it also works with zeus). It adds 30 standard loadouts to your Arsenal saved loadouts. Note: Local execute, else it will spawn a box for every single person!

### Removed
- ACE gforce. (no more going unconscious as jetpilot.)
- `fn_sandstorm` and all accompanying files. (makes the templates 500KB instead of 3000KB.)

## [Version 2] - 2017-09-03
### Changed
- Disabled ACE hearing.

### Removed
- ACEX modules to remove that from @ZEUSOPS.
- The headless clients.

## [Version 1 Hotfix] - 2017-07-21
### Changed
- The `ZO_fnc_gearStart` now also gives a radio, bodybag, and earplugs.

### Fixed
- `ZO_fnc_dynamicGroupsMarkers` are fixed, and now have Whiskey in it.

## [Version 1] - 2017-07-20
### Added
- A new function `ZO_fnc_restrictedGear`
- Templates for Lythium and Fallujah.

### Fixed
- A bug where the zeus can't get back in after leaving.

The function `ZO_fnc_restrictedGear` allows you to check who all has a specific item. If you'd like to check who all has a GPS, you run the following command in the debug console with local exec:
```sqf
"ItemGPS" spawn ZO_fnc_restrictedGear;
```

Note that running it with global exec, everyone will see who has the specific item. Also note that the item is caps sensitive.

