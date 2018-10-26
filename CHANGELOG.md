# Changelog

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
- Hotfix `fn_showFPS.sqf`.


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

