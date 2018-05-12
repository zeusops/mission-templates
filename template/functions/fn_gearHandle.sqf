/*
	@file_name: fn_gearHandle.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//             EDITABLE VARIABLES             //
////////////////////////////////////////////////

_uniform = "rhs_uniform_FROG01_d";
_vest = "rhsusf_spc_patchless_radio";
_backpack = "rhsusf_assault_eagleaiii_coy";
_headgear = "rhsusf_lwh_helmet_marpatd";

_radio = "tf_anprc152";

_backpackLeader = "tf_rt1523g_big_bwmod_tropen";
_weaponMain = ["rhs_weap_m4a1_blockII_bk", "30Rnd_556x45_Stanag_Tracer_Red", "optic_MRCO"]; // format: [ gun, ammo, sight ]
_weaponAR = ["rhs_weap_m249_pip_L", "rhs_200rnd_556x45_M_SAW", "optic_MRCO"]; // format: [ gun, ammo, sight ]
_weaponLauncher = ["launch_MRAWS_olive_F", "MRAWS_HEAT_F", ""]; // format: [ gun, ammo, sight ]

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_gearLoad = {
	_loadout = missionNameSpace getVariable "playerGear";
	
	if (_loadout isEqualTo []) exitWith {cutText ["You don't have any loadout saved!", "PLAIN"];};
	
	// remove current container contents
	removeAllItems player;
	{player removeMagazine _x} forEach (magazines player);
	
	
	
	
	
	// Give all items if they dont have it already
	if ((_loadout select 0 select 0) != (uniform player)) then {
		player forceAddUniform (_loadout select 0 select 0);
	};
	if ((_loadout select 0 select 1) != (vest player)) then {
		player addVest (_loadout select 0 select 1);
	};
	if ((_loadout select 0 select 2) != (backpack player)) then {
		player addBackpack (_loadout select 0 select 2);
	};
	if ((_loadout select 0 select 3) != (headgear player)) then {
		player addHeadgear (_loadout select 0 select 3);
	};
	if ((_loadout select 0 select 4) != (goggles player)) then {
		player addGoggles (_loadout select 0 select 4);
	};
	if ((_loadout select 0 select 5) != (hmd player)) then {
		player linkItem (_loadout select 0 select 5);
	};
	if ((_loadout select 0 select 6) != (binocular player)) then {
		player addWeapon (_loadout select 0 select 6);
	};
	{
		if (!(_x in (assignedItems player))) then {
			player linkItem _x;
		}
	} foreach (_loadout select 1);
	
	// load uniform contents to make sure you get the right ammunition in your weapons
	{
		player addItemToUniform _x;
	} foreach (_loadout select 2);
	
	// load vest contents to make sure you get the right ammunition in your weapons
	{
		player addItemToVest _x;
	} foreach (_loadout select 3);
	
	// load backpack contents to make sure you get the right ammunition in your weapons
	{
		player addItemToBackpack _x;
	} foreach (_loadout select 4);
	
	
	
	
	
	// copy primary info over
	_primary = [];
	{
		_primary pushback _x;
	} foreach (_loadout select 5);
	
	// load primary plus attachments
	player addWeapon (_primary select 0);
	{
		player addPrimaryWeaponItem _x;
	} foreach _primary;
	
	// copy secondary info over
	_secondary = [];
	{
		_secondary pushback _x;
	} foreach (_loadout select 6);
	
	// load secondary plus attachments
	player addWeapon (_secondary select 0);
	{
		player addSecondaryWeaponItem _x;
	} foreach _secondary;
	
	// copy secondary info over
	_handgun = [];
	{
		_handgun pushback _x;
	} foreach (_loadout select 7);
	
	// load secondary plus attachments
	player addWeapon (_handgun select 0);
	{
		player addHandgunItem _x;
	} foreach _handgun;
	
	
	
	
	
	// remove current container contents to this time actually fill up the containers
	removeAllItems player;
	{player removeMagazine _x} forEach (magazines player);
	
	
	
	
	
	// load uniform contents
	{
		player addItemToUniform _x;
	} foreach (_loadout select 2);
	
	// load vest contents
	{
		player addItemToVest _x;
	} foreach (_loadout select 3);
	
	// load backpack contents
	{
		player addItemToBackpack _x;
	} foreach (_loadout select 4);
};

fn_gearLoadout = {
	_loadout = _this;
	
	switch (_loadout) do {
		case "AT RIFLEMAN": {
			[] call fn_gearStart;
			
			// give rifleman gear
			player addItemToVest (_weaponMain select 1);
			player addWeapon (_weaponMain select 0);
			player addPrimaryWeaponItem (_weaponMain select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 16 do {player addItemToVest (_weaponMain select 1)};
			player addBackpack _backpack;
			player addItemToBackpack (_weaponLauncher select 1);
			player addWeapon (_weaponLauncher select 0);
			player addSecondaryWeaponItem (_weaponLauncher select 2);
			for "_i" from 1 to 3 do {player addItemToBackpack (_weaponLauncher select 1)};
			
			// set to non-medic and non-engineer
			player setVariable ["Ace_medical_medicClass", 0];
			player setUnitTrait ["Engineer", false];
		};
		
		case "AUTORIFLEMAN": {
			[] call fn_gearStart;
			
			// give AR gear
			player addItemToVest (_weaponAR select 1);
			player addWeapon (_weaponAR select 0);
			player addPrimaryWeaponItem (_weaponAR select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 8 do {player addItemToVest (_weaponAR select 1)};
			player addBackpack _backpack;
			for "_i" from 1 to 3 do {player addItemToBackpack (_weaponAR select 1)};
			
			// set to non-medic and non-engineer
			player setVariable ["Ace_medical_medicClass", 0];
			player setUnitTrait ["Engineer", false];
		};
		
		case "ENGINEER": {
			[] call fn_gearStart;
			
			// give rifleman gear
			player addItemToVest (_weaponMain select 1);
			player addWeapon (_weaponMain select 0);
			player addPrimaryWeaponItem (_weaponMain select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 16 do {player addItemToVest (_weaponMain select 1)};
			
			// set to non-medic and engineer
			player setVariable ["Ace_medical_medicClass", 0];
			player setUnitTrait ["Engineer", true];
		};
		
		case "MEDIC": {
			[] call fn_gearStart;
			
			// give medic gear
			player addItemToVest (_weaponMain select 1);
			player addWeapon (_weaponMain select 0);
			player addPrimaryWeaponItem (_weaponMain select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 16 do {player addItemToVest (_weaponMain select 1)};
			player addBackpack _backpack;
			for "_i" from 1 to 8 do {
				player addItemToBackpack "ACE_bloodIV";
				player addItemToBackpack "ACE_epinephrine";
				for "_i" from 1 to 4 do {player addItemToBackpack "ACE_morphine"};
				for "_i" from 1 to 8 do {player addItemToBackpack "ACE_fieldDressing"};
			};
			
			// set to medic and non-engineer
			player setVariable ["Ace_medical_medicClass", 1];
			player setUnitTrait ["Engineer", false];
		};
		
		case "RIFLEMAN": {
			[] call fn_gearStart;
			
			// give rifleman gear
			player addItemToVest (_weaponMain select 1);
			player addWeapon (_weaponMain select 0);
			player addPrimaryWeaponItem (_weaponMain select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 16 do {player addItemToVest (_weaponMain select 1)};
			
			// set to non-medic and non-engineer
			player setVariable ["Ace_medical_medicClass", 0];
			player setUnitTrait ["Engineer", false];
		};
		
		case "TEAMLEADER": {
			[] call fn_gearStart;
			
			// give leader gear
			player addItemToVest (_weaponMain select 1);
			player addWeapon (_weaponMain select 0);
			player addPrimaryWeaponItem (_weaponMain select 2);
			for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
			for "_i" from 1 to 16 do {player addItemToVest (_weaponMain select 1)};
			player addBackpack _backpackLeader;
			player linkItem "itemGPS";
			player addWeapon "Binocular";
			
			// set to non-medic and non-engineer
			player setVariable ["Ace_medical_medicClass", 0];
			player setUnitTrait ["Engineer", false];
		};
	};
};

fn_gearSave = {
	_items = [];
	_linkedItems = [];
	
	_uniform = [];
	_vest = [];
	_backpack = [];
	
	_primary = [];
	_secondary = [];
	_handgun = [];
	
	// save loose items
	_items pushback (uniform player);
	_items pushback (vest player);
	_items pushback (backpack player);
	_items pushback (headgear player);
	_items pushback (goggles player);
	_items pushback (hmd player);
	_items pushback (binocular player);
	
	// save linked items
	_linkedItems = (assignedItems player);
	
	// save uniform contents
	{
		_uniform pushback _x;
	} foreach (uniformItems player);
	
	// save vest contents
	{
		_vest pushback _x;
	} foreach (vestItems player);
	
	// save backpack contents
	{
		_backpack pushback _x;
	} foreach (backpackItems player);
	
	// save primary plus attachments
	_primary pushback (primaryWeapon player);
	{
		_primary pushback _x;
	} foreach (primaryWeaponItems player);
	
	// save secondary plus attachments
	_secondary pushback (secondaryWeapon player);
	{
		_secondary pushback _x;
	} foreach (secondaryWeaponItems player);
	
	// save pistol plus attachments
	_handgun pushback (handgunWeapon player);
	{
		_handgun pushback _x;
	} foreach (handgunItems player);
	
	// save loadout
	_loadout = [_items, _linkedItems, _uniform, _vest, _backpack, _primary, _secondary, _handgun];
	missionNameSpace setVariable ["playerGear", _loadout, false];
};

fn_gearStart = {
	removeAllWeapons player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeAllAssignedItems player;
	removeGoggles player;
	
	player linkItem _radio;
	player linkItem "ItemMap";
	player linkItem "ItemCompass";
	player linkItem "ItemWatch";
	
	player forceAddUniform _uniform;
	player addItemToUniform "ACE_bodyBag";
	for "_i" from 1 to 8 do {
		player addItemToUniform "ACE_morphine";
		for "_i" from 1 to 2 do {player addItemToUniform "ACE_fieldDressing"};
	};
	
	player addVest _vest;
	player addHeadgear _headgear;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

_request = (_this select 0);

switch (_request) do {
	// gear start
	case 0: {
		[] call fn_gearStart;
	};
	
	// gear loadout
	case 1: {
		_loadout = (_this select 1);
		_loadout call fn_gearLoadout;
	};
	
	// save gear
	case 2: {
		[] call fn_gearSave;
	};
	
	// rearm from save
	case 3: {
		[] call fn_gearLoad;
	};
};