/*
    @file_name: fn_TTT.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_hint = {
    hintSilent ( _this);
};

fn_startingText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>Starting: %1</t>",
        _this
    ]));
};

fn_preparingText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are </t><t font='PuristaBold' size='1.6' align='left' color='#999999'>UNKNOWN</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Preparing: %1</t><br />
        <br />
        <t font='PuristaBold' color='#999999' align='left'>Notes:</t><br />
        <t align='left'>- Do not exit the map area</t><br />
        <t align='left'>- Weapons can be found in buildings</t>",
        _this
    ]));
};

fn_innocentText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are </t><t font='PuristaBold' size='1.6' align='left' color='#88ff88'>INNOCENT</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Normal time: %1</t><br />
        <br />
        <t font='PuristaBold' color='#88ff88' align='left'>Notes:</t><br />
        <t align='left'>- Kill all traitors</t><br />
        <t align='left'>- Do not exit the map area</t><br />
        <t align='left'>- Weapons can be found in buildings</t>",
        _this
    ]));
};

fn_innocentText2 = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are </t><t font='PuristaBold' size='1.6' align='left' color='#88ff88'>INNOCENT</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Overtime: ∞</t><br />
        <br />
        <t font='PuristaBold' color='#88ff88' align='left'>Notes:</t><br />
        <t align='left'>- Kill all traitors</t><br />
        <t align='left'>- You can see all players</t>",
        _this
    ]));
};

fn_detectiveText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are the </t><t font='PuristaBold' size='1.6' align='left' color='#8888ff'>DETECTIVE</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Normal time: %1</t><br />
        <br />
        <t font='PuristaBold' color='#8888ff' align='left'>Notes:</t><br />
        <t align='left'>- Kill all traitors</t><br />
        <t align='left'>- Do not exit the map area</t><br />
        <t align='left'>- Weapons can be found in buildings</t>",
        _this
    ]));
};

fn_detectiveText2 = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are </t><t font='PuristaBold' size='1.6' align='left' color='#8888ff'>DETECTIVE</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Overtime: ∞</t><br />
        <br />
        <t font='PuristaBold' color='#8888ff' align='left'>Notes:</t><br />
        <t align='left'>- Kill all traitors</t><br />
        <t align='left'>- You can see all players</t>",
        _this
    ]));
};

fn_traitorText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are a </t><t font='PuristaBold' size='1.6' color='#ff8888' align='left'>TRAITOR</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Normal time: %1</t><br />
        <br />
        <t font='PuristaBold' color='#ff8888' align='left'>Notes:</t><br />
        <t align='left'>- Kill all innocents (incl. detectives)</t><br />
        <t align='left'>- Do not exit the map area</t><br />
        <t align='left'>- Weapons can be found in buildings</t><br />
        <br />
        <t font='PuristaBold' color='#ff8888' align='left'>Traitors:</t>
        <t align='left'>%2</t>",
        (_this select 0),
        (_this select 1)
    ]));
};

fn_traitorText2 = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>You are a </t><t font='PuristaBold' size='1.6' color='#ff8888' align='left'>TRAITOR</t><br />
        <br />
        <t font='PuristaBold' size='1.6' align='left'>Overtime: ∞</t><br />
        <br />
        <t font='PuristaBold' color='#ff8888' align='left'>Notes:</t><br />
        <t align='left'>- Kill all innocents (incl. detectives)</t><br />
        <t align='left'>- You can see all players</t><br />
        <br />
        <t font='PuristaBold' color='#ff8888' align='left'>Traitors:</t>
        <t align='left'>%1</t>",
        (_this select 0)
    ]));
};

fn_endingText = {
    hintSilent (parseText (format[
        "<t font='PuristaBold' size='1.6' align='left'>Ending: %1</t>",
        _this
    ]));
};

fn_endGameTextT = {
    titleText ["<t font='PuristaBold' size='6' color='#ff8888'>Traitors win</t><br/><t font='PuristaBold' size='2' color='#ffffff'>All innocents are dead</t></br>", "PLAIN", -1, false, true]; titleFadeOut (missionNamespace getVariable "TTT_timeLimitEnding");
};

fn_endGameTextI = {
    titleText ["<t font='PuristaBold' size='6' color='#88ff88'>Innocents win</t><br/><t font='PuristaBold' size='2' color='#ffffff'>All traitors are dead</t></br>", "PLAIN", -1, false, true]; titleFadeOut (missionNamespace getVariable "TTT_timeLimitEnding");
};

fn_gameTextStarting = {
    _time = (missionNamespace getVariable "TTT_timeLimitStarting");
    while {_time > 0} do {
        _timeString = ([((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring);
        _timeString remoteExec ["fn_startingText", allPlayers];

        _time = _time - 1;
        sleep 1;
    };
    missionNamespace setVariable ["TTT_startingDone", true];
};

fn_gameTextPreparing = {
    _time = (missionNamespace getVariable "TTT_timeLimitPreparing");
    while {_time > 0} do {
        _timeString = ([((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring);
        _timeString remoteExec ["fn_preparingText", allPlayers];

        _time = _time - 1;
        sleep 1;
    };
    missionNamespace setVariable ["TTT_preparingDone", true];
};

fn_gameTextEnding = {
    _time = (missionNamespace getVariable "TTT_timeLimitEnding");
    while {_time >= 0} do {
        _timeString = ([((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring);
        _timeString remoteExec ["fn_endingText", allPlayers];

        _time = _time - 1;
        sleep 1;
    };
};

fn_gameText = {
    _time = (missionNamespace getVariable "TTT_timeLimit");

    while {_time > 0 && (missionNamespace getVariable "TTT_gameOngoing")} do {
        _timeString = ([((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring);
        _innocents = (missionNamespace getVariable "TTT_innocents");
        _detective = (missionNamespace getVariable "TTT_detective");
        _traitors = (missionNamespace getVariable "TTT_traitors");
        _timeString remoteExec ["fn_innocentText", _innocents];
        _timeString remoteExec ["fn_detectiveText", _detective];
        _traitorString = " ";
        {
            if (_traitorString == " ") then {
                _traitorString = _traitorString + (name _x);
            } else {
                _traitorString = _traitorString + ", " + (name _x);
            };
        } foreach _traitors;
        [_timeString, _traitorString] remoteExec ["fn_traitorText", _traitors];

        _time = (missionNamespace getVariable "TTT_timeLeft") - 1;
        missionNamespace setVariable ["TTT_timeLeft", _time, true];
        sleep 1;
    };

    // Start overtime if timelimit reached
    if (_time <= 0) then {
        missionNamespace setVariable ["TTT_overtime", true, true];
        "OVERTIME" remoteExec ["fn_playerUnitTracker", allPlayers];
    };

    while {(missionNamespace getVariable "TTT_gameOngoing") && (missionNamespace getVariable "TTT_overtime")} do {
        _innocents = (missionNamespace getVariable "TTT_innocents");
        _traitors = (missionNamespace getVariable "TTT_traitors");
        _detective = (missionNamespace getVariable "TTT_detective");
        [] remoteExec ["fn_innocentText2", _innocents];
        [] remoteExec ["fn_detectiveText2", _detective];
        _traitorString = " ";
        {
            if (_traitorString == " ") then {
                _traitorString = _traitorString + (name _x);
            } else {
                _traitorString = _traitorString + ", " + (name _x);
            };
        } foreach _traitors;
        [_traitorString] remoteExec ["fn_traitorText2", _traitors];
        sleep 1;
    };
};

fn_handleGame = {
    _innocents = (missionNamespace getVariable "TTT_innocents");
    _detective = (missionNamespace getVariable "TTT_detective");
    _traitors = (missionNamespace getVariable "TTT_traitors");

    "INNOCENT" remoteExec ["fn_playerUnitTracker", _innocents];
    "DETECTIVE" remoteExec ["fn_playerUnitTracker", _detective];
    "TRAITOR" remoteExec ["fn_playerUnitTracker", _traitors];

    while {(missionNamespace getVariable "TTT_gameOngoing")} do {
        _innocents = (missionNamespace getVariable "TTT_innocents");
        _detective = (missionNamespace getVariable "TTT_detective");
        _traitors = (missionNamespace getVariable "TTT_traitors");

        [_detective, "#(rgb,8,8,3)color(0,0.1,0.2,1)"] remoteExec ["fn_setTexture"];

        // end if all innocents dead
        if (_innocents findIf {alive _x} == -1 && !alive _detective) then {
            [] spawn fn_gameTextEnding;
            [] remoteExec ["fn_endGameTextT", allPlayers];
            missionNamespace setVariable ["TTT_gameOngoing", false, true];
            "STOP" call ZO_fnc_TTT;
        } else {
            // end if all traitors dead
            if (_traitors findIf {alive _x} == -1) then {
                [] spawn fn_gameTextEnding;
                [] remoteExec ["fn_endGameTextI", allPlayers];
                missionNamespace setVariable ["TTT_gameOngoing", false, true];
                "STOP" call ZO_fnc_TTT;
            };
        };

        sleep 0.05;
    };
};

fn_lootSpawner = {
    _objects = nearestObjects [(getMarkerPos "coverMapAreaCenter"), ["Static"], (getMarkerSize "coverMapAreaCenter") select 0];
    _buildings = [];
    _lootPositions = [];

    // find buildings
    {
        _objectPositions = [_x] call BIS_fnc_buildingPositions;

        if (count _objectPositions > 0) then {
            _buildings pushback _objectPositions;
        };
    } foreach _objects;

    // find positions
    {
        _x call {
            _buildingPositions = _this;

            {
                if (true) then {
                    _lootPositions pushback _x;
                };
            } foreach _buildingPositions;
        };
    } foreach _buildings;

    _weaponandammoArray = [["rhs_weap_ak74m_npz","rhs_30Rnd_545x39_AK"],["rhs_weap_aks74n_2_npz","rhs_30Rnd_545x39_AK"],["rhs_weap_asval_npz","rhs_20rnd_9x39mm_SP5"],["hgun_PDW2000_F","30Rnd_9x21_Mag"],["rhs_weap_hk416d10","30Rnd_556x45_Stanag"],["rhs_weap_kar98k","rhsgref_5Rnd_792x57_kar98k"],["UK3CB_BAF_L115A3_BL","UK3CB_BAF_338_5Rnd"],["UK3CB_BAF_L128A1","UK3CB_BAF_12G_Slugs"],["UK3CB_BAF_L85A2","30Rnd_556x45_Stanag"],["UK3CB_BAF_L86A2","30Rnd_556x45_Stanag"],["rhs_weap_m16a4_carryhandle","30Rnd_556x45_Stanag"],[""],[""],["rhs_weap_m27iar","30Rnd_556x45_Stanag"],["rhs_weap_m4a1_carryhandle","30Rnd_556x45_Stanag"],["rhs_weap_sr25","rhsusf_20Rnd_762x51_m993_Mag"],["rhs_weap_m38_rail","rhsgref_5Rnd_762x54_m38"],["rhs_weap_mosin_sbr","rhsgref_5Rnd_762x54_m38"],["SMG_02_F","30Rnd_9x21_Mag"],["rhs_weap_svdp_wd_npz","rhs_10Rnd_762x54mmR_7N1"],["SMG_01_F","30Rnd_45ACP_Mag_SMG_01"],["srifle_DMR_01_F","10Rnd_762x54_Mag"],["rhs_weap_vss_npz","rhs_10rnd_9x39mm_SP5"],["rhs_weap_pb_6p9","rhs_mag_9x18_8_57N181S"],["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder"],["hgun_ACPC2_F","9Rnd_45ACP_Mag"],["hgun_Pistol_heavy_01_F","11Rnd_45ACP_Mag"],["rhsusf_weap_glock17g4","rhsusf_mag_17Rnd_9x19_JHP"],["UK3CB_BAF_L131A1","UK3CB_BAF_9_17Rnd"],["rhsusf_weap_m9","rhsusf_mag_15Rnd_9x19_JHP"],["rhs_weap_makarov_pm","rhs_mag_9x18_8_57N181S"]];
    _itemsArray = [["rhs_30Rnd_545x39_AK", 3],["rhs_30Rnd_545x39_AK", 3],["rhs_20rnd_9x39mm_SP5", 3],["30Rnd_9x21_Mag", 3],["30Rnd_556x45_Stanag", 3],["30Rnd_556x45_Stanag", 3],["30Rnd_556x45_Stanag", 3],["30Rnd_556x45_Stanag", 3],["rhsgref_5Rnd_792x57_kar98k", 3],["UK3CB_BAF_338_5Rnd", 3],["UK3CB_BAF_12G_Slugs", 3],["30Rnd_556x45_Stanag", 3],["30Rnd_556x45_Stanag", 3],["rhsusf_20Rnd_762x51_m993_Mag", 3],["30Rnd_556x45_Stanag", 3],["rhsusf_50Rnd_762x51", 3],["rhs_200rnd_556x45_M_SAW", 3],["30Rnd_556x45_Stanag", 3],["30Rnd_556x45_Stanag", 3],["rhsusf_20Rnd_762x51_m993_Mag", 3],["rhsgref_5Rnd_762x54_m38", 3],["rhsgref_5Rnd_762x54_m38", 3],["rhs_30Rnd_762x39mm_Savz58", 3],["30Rnd_9x21_Mag", 3],["rhs_10Rnd_762x54mmR_7N1", 3],["30Rnd_45ACP_Mag_SMG_01", 3],["10Rnd_762x54_Mag", 3],["rhs_10rnd_9x39mm_SP5", 3],["rhs_mag_9x18_8_57N181S", 3],["6Rnd_45ACP_Cylinder", 3],["9Rnd_45ACP_Mag", 3],["11Rnd_45ACP_Mag", 3],["rhsusf_mag_17Rnd_9x19_JHP", 3],["UK3CB_BAF_9_17Rnd", 3],["rhsusf_mag_15Rnd_9x19_JHP", 3],["rhs_mag_9x18_8_57N181S", 3]];
    _itemArray = ["optic_Aco","rhsusf_acc_T1_low","rhsusf_acc_T1_low_fwd","rhsusf_acc_ACOG_USMC","optic_Arco","optic_DMS","rhsusf_acc_g33_xps3_flip","optic_LRPS","rhsusf_acc_compm4","optic_Holosight","optic_SOS","optic_MRCO","optic_Hamr","UK3CB_BAF_SUIT","rhsusf_acc_eotech_xps3","rhsusf_acc_nt4_black","UK3CB_BAF_Silencer_L85","muzzle_snds_H"];
    _uniformArray = ["U_B_CombatUniform_mcam","UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DPMT","UK3CB_BAF_U_CombatUniform_DPMW","UK3CB_BAF_U_CombatUniform_MTP","rhs_uniform_cu_ocp","rhs_uniform_cu_ucp","U_B_CTRG_1","rhs_uniform_FROG01_d","rhs_uniform_FROG01_wd","U_B_FullGhillie_sard","rhs_uniform_g3_blk","U_BG_Guerrilla_6_1"];
    _vestArray = ["rhs_6b23_digi","rhs_6b23_digi_6sh92","rhsgref_6b23_khaki_rifleman","rhs_6sh92_digi","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_Chestrig_blk","V_Chestrig_rgr","rhsusf_iotv_ocp_Rifleman","rhsusf_iotv_ucp_Rifleman","V_HarnessO_brn","UK3CB_BAF_V_Osprey_DDPM2","UK3CB_BAF_V_Osprey_DPMT2","UK3CB_BAF_V_Osprey_DPMW2","UK3CB_BAF_V_Osprey_Rifleman_A","V_TacVestIR_blk","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_rgr","rhsusf_spc","rhsusf_spc_patchless_radio","V_TacVest_blk","V_TacVest_camo","PLA_B04_RF_D","PLA_B04_RF"];
    _helmetArray = ["rhs_6b26_green","rhs_6b27m_digi","rhs_6b28_green","rhs_6b28","rhs_6b47","rhsusf_ach_bare","rhsusf_ach_bare_tan","rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_ucp","Afghan_03Hat","Afghan_04Hat","rhs_altyn_novisor","rhs_altyn_visordown","H_HelmetSpecO_blk","H_HelmetSpecO_ocamo","H_Bandanna_gry","H_Bandanna_khk","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","UK3CB_BAF_H_Boonie_DDPM","UK3CB_BAF_H_Boonie_DPMT","UK3CB_BAF_H_Boonie_DPMW","rhs_Booniehat_digi","UK3CB_BAF_H_Boonie_MTP","H_Booniehat_oli","rhs_booniehat2_marpatd","rhs_booniehat2_marpatwd","rhs_Booniehat_ocp","rhs_Booniehat_ucp","H_Cap_blk","H_Cap_grn","H_Cap_oli","H_HelmetB","H_HelmetSpecB","rhs_fieldcap_digi","UK3CB_BAF_H_Mk6_DDPM_A","UK3CB_BAF_H_Mk6_DPMT_A","UK3CB_BAF_H_Mk6_DPMW_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Scrim_A","H_HelmetB_light","rhsusf_lwh_helmet_marpatd","rhsusf_lwh_helmet_marpatwd","rhsgref_helmet_M1_bare","rhsgref_M56","rhsusf_mich_bare","rhsusf_mich_helmet_marpatd","rhsusf_mich_helmet_marpatwd","H_MilCap_gry","rhsusf_protech_helmet","H_Shemag_olive","H_ShemagOpen_khk","rhs_ssh68","H_StrawHat","rhs_tsh4","rhs_8point_marpatd","rhs_8point_marpatwd","UK3CB_BAF_H_Wool_Hat","","",""];
    _backpackArray = ["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_rgr","B_AssaultPack_khk","B_AssaultPack_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_oli","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_oli","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_sgg","B_TacticalPack_blk","B_TacticalPack_rgr","B_TacticalPack_oli","rhs_sidor","rhsusf_assault_eagleaiii_coy","rhsusf_assault_eagleaiii_ocp","rhsusf_assault_eagleaiii_ucp"];
    _lootArray = [_weaponandammoArray, _itemsArray, _itemArray, _uniformArray, _vestArray, _helmetArray, _backpackArray];

    _lootDrops = [];
    // spawn drops
    {
        _spawnType = selectRandom [0, 0, 0, 1, 2, 2, 2, 4, 4]; // 0=weaponandammo, 1=items, 2=item, 3=uniform, 4=vest, 5=helmet, 6=backpack, 7=nothing
        _lootDrop = "groundweaponholder" createVehicle _x;

        if (_spawnType != 7) then {
            loot = selectRandom (_lootArray select _spawnType);
        };

        switch (_spawnType) do {
            case 0: {
                _lootCount = selectRandom [1, 2];
                _lootDrop addWeaponCargoGlobal [(loot select 0),1];
                _lootDrop addItemCargoGlobal [(loot select 1), _lootCount];
                _lootDrop setPos [_x select 0, _x select 1, (_x select 2)];
            };

            case 1: {
                _lootCount = 1 + round (random ((loot select 1)-1));
                _lootDrop addItemCargoGlobal [(loot select 0), _lootCount];
                _lootDrop setPos [_x select 0, _x select 1, (_x select 2)];
            };

            case 2;
            case 3;
            case 4;
            case 5: {
                _lootDrop addItemCargoGlobal [loot, 1];
                _lootDrop setPos [_x select 0, _x select 1, (_x select 2)];
            };

            case 6: {
                _lootDrop addBackpackCargoGlobal [loot, 1];
                _lootDrop setPos [_x select 0, _x select 1, (_x select 2)];
            };
        };

        _lootDrops pushback _lootDrop;
    } foreach _lootPositions;

    missionNamespace setVariable ["TTT_lootDrops", _lootDrops, true];
};

fn_makeTeams = {
    // Fetch alive players
    _innocents = [];
    {
        if (alive _x) then { _innocents pushback _x; };
    } foreach allPlayers;

    // Select traitors from the innocents
    _traitors = [];
    for "_i" from 1 to (round((count _innocents) * (missionNamespace getVariable "TTT_traitorRate"))) do {
        _innocentsLeft = count _innocents;
        _traitors pushback (_innocents deleteAt (round random (_innocentsLeft - 1)));
    };

    // Select detective
    _detective = objNull;
    if (count _innocents > 0) then {
        _innocentsLeft = count _innocents;
        _detective = (_innocents deleteAt (round random (_innocentsLeft - 1)));
    };

    missionNamespace setVariable ["TTT_innocents", _innocents, true];
    missionNamespace setVariable ["TTT_traitors", _traitors, true];
    missionNamespace setVariable ["TTT_detective", _detective, true];
};

fn_playerHandleRespawn = {
    // waiting for death
    while {alive player} do {
        _pos = position player;
        _center = (getMarkerPos "coverMapAreaCenter");
        _size = (getMarkerSize "coverMapAreaCenter");

        if ((_pos select 0) < ((_center select 0)-(_size select 0)) || (_pos select 0) > ((_center select 0)+(_size select 0)) || (_pos select 1) < ((_center select 1)-(_size select 1)) || (_pos select 1) > ((_center select 1)+(_size select 1))) then {
            player setDamage (damage player + 0.05);
            "colorCorrections" ppEffectEnable true;
            "colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.0, 0.0, 0.0, 0.0], [1, 0, 0, 0.75], [0.9, 0.9, 0.9, 0.0]];
            "colorCorrections" ppEffectCommit 0.5;
            cutText ["Return to the battlefield!", "PLAIN", 0.3];
        } else {
            "colorCorrections" ppEffectEnable true;
            "colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1], [0.0, 0.0, 0.0, 0.0]];
            "colorCorrections" ppEffectCommit 0.5;
            cutText ["", "PLAIN", 0.3];
        };
        sleep 0.5;
    };

    // Reset color corrections
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1], [0.0, 0.0, 0.0, 0.0]];
    "colorCorrections" ppEffectCommit 0.5;

    if (player in (missionNamespace getVariable "TTT_traitors")) then {
        [player, "#(rgb,8,8,3)color(0.3,0,0,1)"] remoteExec ["fn_setTexture"];
    };
    if (player in (missionNamespace getVariable "TTT_innocents")) then {
        [player, "#(rgb,8,8,3)color(0,0.2,0,1)"] remoteExec ["fn_setTexture"];
    };
};

fn_playerGearLock = {
    _controls = [];
    {
        _controls pushback _x
    } foreach [
        6331, // uniform
        6381, // vest
        6191 // backpack
        //6240, // helmet
        //6211, // map
        //6212, // compass
        //6213, // clock
        //6214 // radio
        //6216 // goggles
        //610 // weapon
        //633 // items in uniform
        //638 // items in vest
        //6192 // items in backpack
        //621 // scope
        //632 // items on ground
    ];

    while {true} do
    {
        while {!(isNull (findDisplay 602))} Do
        {
            {
                ctrlEnable [_x, false];
            } foreach _controls;
        };

        waitUntil {!(isNull (findDisplay 602));};
    };
};

fn_playerHandleCoverMap = {
    _center = (getMarkerPos "coverMapAreaCenter");
    _size = (getMarkerSize "coverMapAreaCenter");

    fn_inCoverMap = {
        (((_this select 0) >= ((_center select 0) - (_size select 0))) &&
        ((_this select 0) <= ((_center select 0) + (_size select 0))) &&
        ((_this select 1) >= ((_center select 1) - (_size select 1))) &&
        ((_this select 1) <= ((_center select 1) + (_size select 1))))
    };

    _locLeft = [((_center select 0) - (_size select 0)), ((getPos player) select 1)];
    _locRight = [((_center select 0) + (_size select 0)), ((getPos player) select 1)];
    _locBot = [((getPos player) select 0), ((_center select 1) - (_size select 1))];
    _locTop = [((getPos player) select 0), ((_center select 1) + (_size select 1))];
    _disLeft = (getPos player) distance _locLeft;
    _disRight = (getPos player) distance _locRight;
    _disBot = (getPos player) distance _locBot;
    _disTop = (getPos player) distance _locTop;
    if (_disLeft < 20) then {
        _alphaLine = linearConversion [10, 20, _disLeft, 1, 0, true];

        // Find line locations
        _locmin7 = [(_locLeft select 0), (round (_locLeft select 1)) - 7, 0];
        _locmin65 = [(_locLeft select 0), (round (_locLeft select 1)) - 6.5, 0];
        _locmin6 = [(_locLeft select 0), (round (_locLeft select 1)) - 6, 0];
        _locmin55 = [(_locLeft select 0), (round (_locLeft select 1)) - 5.5, 0];
        _locmin5 = [(_locLeft select 0), (round (_locLeft select 1)) - 5, 0];
        _locmin45 = [(_locLeft select 0), (round (_locLeft select 1)) - 4.5, 0];
        _locmin4 = [(_locLeft select 0), (round (_locLeft select 1)) - 4, 0];
        _locmin35 = [(_locLeft select 0), (round (_locLeft select 1)) - 3.5, 0];
        _locmin3 = [(_locLeft select 0), (round (_locLeft select 1)) - 3, 0];
        _locmin25 = [(_locLeft select 0), (round (_locLeft select 1)) - 2.5, 0];
        _locmin2 = [(_locLeft select 0), (round (_locLeft select 1)) - 2, 0];
        _locmin15 = [(_locLeft select 0), (round (_locLeft select 1)) - 1.5, 0];
        _locmin1 = [(_locLeft select 0), (round (_locLeft select 1)) - 1, 0];
        _locmin05 = [(_locLeft select 0), (round (_locLeft select 1)) - 0.5, 0];
        _loc = [(_locLeft select 0), (round (_locLeft select 1)), 0];
        _locplus05 = [(_locLeft select 0), (round (_locLeft select 1)) + 0.5, 0];
        _locplus1 = [(_locLeft select 0), (round (_locLeft select 1)) + 1, 0];
        _locplus15 = [(_locLeft select 0), (round (_locLeft select 1)) + 1.5, 0];
        _locplus2 = [(_locLeft select 0), (round (_locLeft select 1)) + 2, 0];
        _locplus25 = [(_locLeft select 0), (round (_locLeft select 1)) + 2.5, 0];
        _locplus3 = [(_locLeft select 0), (round (_locLeft select 1)) + 3, 0];
        _locplus35 = [(_locLeft select 0), (round (_locLeft select 1)) + 3.5, 0];
        _locplus4 = [(_locLeft select 0), (round (_locLeft select 1)) + 4, 0];
        _locplus45 = [(_locLeft select 0), (round (_locLeft select 1)) + 4.5, 0];
        _locplus5 = [(_locLeft select 0), (round (_locLeft select 1)) + 5, 0];
        _locplus55 = [(_locLeft select 0), (round (_locLeft select 1)) + 5.5, 0];
        _locplus6 = [(_locLeft select 0), (round (_locLeft select 1)) + 6, 0];
        _locplus65 = [(_locLeft select 0), (round (_locLeft select 1)) + 6.5, 0];
        _locplus7 = [(_locLeft select 0), (round (_locLeft select 1)) + 7, 0];

        // Draw lines if not outside area
        if (_locmin7 call fn_inCoverMap) then {
            drawLine3D [_locmin7, [(_locmin7 select 0), (_locmin7 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin65 call fn_inCoverMap) then {
            drawLine3D [_locmin65, [(_locmin65 select 0), (_locmin65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin6 call fn_inCoverMap) then {
            drawLine3D [_locmin6, [(_locmin6 select 0), (_locmin6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin55 call fn_inCoverMap) then {
            drawLine3D [_locmin55, [(_locmin55 select 0), (_locmin55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin5 call fn_inCoverMap) then {
            drawLine3D [_locmin5, [(_locmin5 select 0), (_locmin5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin45 call fn_inCoverMap) then {
            drawLine3D [_locmin45, [(_locmin45 select 0), (_locmin45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin4 call fn_inCoverMap) then {
            drawLine3D [_locmin4, [(_locmin4 select 0), (_locmin4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin35 call fn_inCoverMap) then {
            drawLine3D [_locmin35, [(_locmin35 select 0), (_locmin35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin3 call fn_inCoverMap) then {
            drawLine3D [_locmin3, [(_locmin3 select 0), (_locmin3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin25 call fn_inCoverMap) then {
            drawLine3D [_locmin25, [(_locmin25 select 0), (_locmin25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin2 call fn_inCoverMap) then {
            drawLine3D [_locmin2, [(_locmin2 select 0), (_locmin2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin15 call fn_inCoverMap) then {
            drawLine3D [_locmin15, [(_locmin15 select 0), (_locmin15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin1 call fn_inCoverMap) then {
            drawLine3D [_locmin1, [(_locmin1 select 0), (_locmin1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin05 call fn_inCoverMap) then {
            drawLine3D [_locmin05, [(_locmin05 select 0), (_locmin05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_loc call fn_inCoverMap) then {
            drawLine3D [_loc, [(_loc select 0), (_loc select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus05 call fn_inCoverMap) then {
            drawLine3D [_locplus05, [(_locplus05 select 0), (_locplus05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus1 call fn_inCoverMap) then {
            drawLine3D [_locplus1, [(_locplus1 select 0), (_locplus1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus15 call fn_inCoverMap) then {
            drawLine3D [_locplus15, [(_locplus15 select 0), (_locplus15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus2 call fn_inCoverMap) then {
            drawLine3D [_locplus2, [(_locplus2 select 0), (_locplus2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus25 call fn_inCoverMap) then {
            drawLine3D [_locplus25, [(_locplus25 select 0), (_locplus25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus3 call fn_inCoverMap) then {
            drawLine3D [_locplus3, [(_locplus3 select 0), (_locplus3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus35 call fn_inCoverMap) then {
            drawLine3D [_locplus35, [(_locplus35 select 0), (_locplus35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus4 call fn_inCoverMap) then {
            drawLine3D [_locplus4, [(_locplus4 select 0), (_locplus4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus45 call fn_inCoverMap) then {
            drawLine3D [_locplus45, [(_locplus45 select 0), (_locplus45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus5 call fn_inCoverMap) then {
            drawLine3D [_locplus5, [(_locplus5 select 0), (_locplus5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus55 call fn_inCoverMap) then {
            drawLine3D [_locplus55, [(_locplus55 select 0), (_locplus55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus6 call fn_inCoverMap) then {
            drawLine3D [_locplus6, [(_locplus6 select 0), (_locplus6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus65 call fn_inCoverMap) then {
            drawLine3D [_locplus65, [(_locplus65 select 0), (_locplus65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus7 call fn_inCoverMap) then {
            drawLine3D [_locplus7, [(_locplus7 select 0), (_locplus7 select 1), 10], [1,0,0,_alphaLine]];
        };
    };
    if (_disRight < 20) then {
        _alphaLine = linearConversion [10, 20, _disRight, 1, 0, true];

        // Find line locations
        _locmin7 = [(_locRight select 0), (round (_locRight select 1)) - 7, 0];
        _locmin65 = [(_locRight select 0), (round (_locRight select 1)) - 6.5, 0];
        _locmin6 = [(_locRight select 0), (round (_locRight select 1)) - 6, 0];
        _locmin55 = [(_locRight select 0), (round (_locRight select 1)) - 5.5, 0];
        _locmin5 = [(_locRight select 0), (round (_locRight select 1)) - 5, 0];
        _locmin45 = [(_locRight select 0), (round (_locRight select 1)) - 4.5, 0];
        _locmin4 = [(_locRight select 0), (round (_locRight select 1)) - 4, 0];
        _locmin35 = [(_locRight select 0), (round (_locRight select 1)) - 3.5, 0];
        _locmin3 = [(_locRight select 0), (round (_locRight select 1)) - 3, 0];
        _locmin25 = [(_locRight select 0), (round (_locRight select 1)) - 2.5, 0];
        _locmin2 = [(_locRight select 0), (round (_locRight select 1)) - 2, 0];
        _locmin15 = [(_locRight select 0), (round (_locRight select 1)) - 1.5, 0];
        _locmin1 = [(_locRight select 0), (round (_locRight select 1)) - 1, 0];
        _locmin05 = [(_locRight select 0), (round (_locRight select 1)) - 0.5, 0];
        _loc = [(_locRight select 0), (round (_locRight select 1)), 0];
        _locplus05 = [(_locRight select 0), (round (_locRight select 1)) + 0.5, 0];
        _locplus1 = [(_locRight select 0), (round (_locRight select 1)) + 1, 0];
        _locplus15 = [(_locRight select 0), (round (_locRight select 1)) + 1.5, 0];
        _locplus2 = [(_locRight select 0), (round (_locRight select 1)) + 2, 0];
        _locplus25 = [(_locRight select 0), (round (_locRight select 1)) + 2.5, 0];
        _locplus3 = [(_locRight select 0), (round (_locRight select 1)) + 3, 0];
        _locplus35 = [(_locRight select 0), (round (_locRight select 1)) + 3.5, 0];
        _locplus4 = [(_locRight select 0), (round (_locRight select 1)) + 4, 0];
        _locplus45 = [(_locRight select 0), (round (_locRight select 1)) + 4.5, 0];
        _locplus5 = [(_locRight select 0), (round (_locRight select 1)) + 5, 0];
        _locplus55 = [(_locRight select 0), (round (_locRight select 1)) + 5.5, 0];
        _locplus6 = [(_locRight select 0), (round (_locRight select 1)) + 6, 0];
        _locplus65 = [(_locRight select 0), (round (_locRight select 1)) + 6.5, 0];
        _locplus7 = [(_locRight select 0), (round (_locRight select 1)) + 7, 0];

        // Draw lines if not outside area
        if (_locmin7 call fn_inCoverMap) then {
            drawLine3D [_locmin7, [(_locmin7 select 0), (_locmin7 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin65 call fn_inCoverMap) then {
            drawLine3D [_locmin65, [(_locmin65 select 0), (_locmin65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin6 call fn_inCoverMap) then {
            drawLine3D [_locmin6, [(_locmin6 select 0), (_locmin6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin55 call fn_inCoverMap) then {
            drawLine3D [_locmin55, [(_locmin55 select 0), (_locmin55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin5 call fn_inCoverMap) then {
            drawLine3D [_locmin5, [(_locmin5 select 0), (_locmin5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin45 call fn_inCoverMap) then {
            drawLine3D [_locmin45, [(_locmin45 select 0), (_locmin45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin4 call fn_inCoverMap) then {
            drawLine3D [_locmin4, [(_locmin4 select 0), (_locmin4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin35 call fn_inCoverMap) then {
            drawLine3D [_locmin35, [(_locmin35 select 0), (_locmin35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin3 call fn_inCoverMap) then {
            drawLine3D [_locmin3, [(_locmin3 select 0), (_locmin3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin25 call fn_inCoverMap) then {
            drawLine3D [_locmin25, [(_locmin25 select 0), (_locmin25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin2 call fn_inCoverMap) then {
            drawLine3D [_locmin2, [(_locmin2 select 0), (_locmin2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin15 call fn_inCoverMap) then {
            drawLine3D [_locmin15, [(_locmin15 select 0), (_locmin15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin1 call fn_inCoverMap) then {
            drawLine3D [_locmin1, [(_locmin1 select 0), (_locmin1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin05 call fn_inCoverMap) then {
            drawLine3D [_locmin05, [(_locmin05 select 0), (_locmin05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_loc call fn_inCoverMap) then {
            drawLine3D [_loc, [(_loc select 0), (_loc select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus05 call fn_inCoverMap) then {
            drawLine3D [_locplus05, [(_locplus05 select 0), (_locplus05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus1 call fn_inCoverMap) then {
            drawLine3D [_locplus1, [(_locplus1 select 0), (_locplus1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus15 call fn_inCoverMap) then {
            drawLine3D [_locplus15, [(_locplus15 select 0), (_locplus15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus2 call fn_inCoverMap) then {
            drawLine3D [_locplus2, [(_locplus2 select 0), (_locplus2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus25 call fn_inCoverMap) then {
            drawLine3D [_locplus25, [(_locplus25 select 0), (_locplus25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus3 call fn_inCoverMap) then {
            drawLine3D [_locplus3, [(_locplus3 select 0), (_locplus3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus35 call fn_inCoverMap) then {
            drawLine3D [_locplus35, [(_locplus35 select 0), (_locplus35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus4 call fn_inCoverMap) then {
            drawLine3D [_locplus4, [(_locplus4 select 0), (_locplus4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus45 call fn_inCoverMap) then {
            drawLine3D [_locplus45, [(_locplus45 select 0), (_locplus45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus5 call fn_inCoverMap) then {
            drawLine3D [_locplus5, [(_locplus5 select 0), (_locplus5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus55 call fn_inCoverMap) then {
            drawLine3D [_locplus55, [(_locplus55 select 0), (_locplus55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus6 call fn_inCoverMap) then {
            drawLine3D [_locplus6, [(_locplus6 select 0), (_locplus6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus65 call fn_inCoverMap) then {
            drawLine3D [_locplus65, [(_locplus65 select 0), (_locplus65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus7 call fn_inCoverMap) then {
            drawLine3D [_locplus7, [(_locplus7 select 0), (_locplus7 select 1), 10], [1,0,0,_alphaLine]];
        };
    };
    if (_disBot < 20) then {
        _alphaLine = linearConversion [10, 20, _disBot, 1, 0, true];

        // Find line locations
        _locmin7 = [(round (_locBot select 0)) - 7, (_locBot select 1), 0];
        _locmin65 = [(round (_locBot select 0)) - 6.5, (_locBot select 1), 0];
        _locmin6 = [(round (_locBot select 0)) - 6, (_locBot select 1), 0];
        _locmin55 = [(round (_locBot select 0)) - 5.5, (_locBot select 1), 0];
        _locmin5 = [(round (_locBot select 0)) - 5, (_locBot select 1), 0];
        _locmin45 = [(round (_locBot select 0)) - 4.5, (_locBot select 1), 0];
        _locmin4 = [(round (_locBot select 0)) - 4, (_locBot select 1), 0];
        _locmin35 = [(round (_locBot select 0)) - 3.5, (_locBot select 1), 0];
        _locmin3 = [(round (_locBot select 0)) - 3, (_locBot select 1), 0];
        _locmin25 = [(round (_locBot select 0)) - 2.5, (_locBot select 1), 0];
        _locmin2 = [(round (_locBot select 0)) - 2, (_locBot select 1), 0];
        _locmin15 = [(round (_locBot select 0)) - 1.5, (_locBot select 1), 0];
        _locmin1 = [(round (_locBot select 0)) - 1, (_locBot select 1), 0];
        _locmin05 = [(round (_locBot select 0)) - 0.5, (_locBot select 1), 0];
        _loc = [(round (_locBot select 0)), (_locBot select 1), 0];
        _locplus05 = [(round (_locBot select 0)) + 0.5, (_locBot select 1), 0];
        _locplus1 = [(round (_locBot select 0)) + 1, (_locBot select 1), 0];
        _locplus15 = [(round (_locBot select 0)) + 1.5, (_locBot select 1), 0];
        _locplus2 = [(round (_locBot select 0)) + 2, (_locBot select 1), 0];
        _locplus25 = [(round (_locBot select 0)) + 2.5, (_locBot select 1), 0];
        _locplus3 = [(round (_locBot select 0)) + 3, (_locBot select 1), 0];
        _locplus35 = [(round (_locBot select 0)) + 3.5, (_locBot select 1), 0];
        _locplus4 = [(round (_locBot select 0)) + 4, (_locBot select 1), 0];
        _locplus45 = [(round (_locBot select 0)) + 4.5, (_locBot select 1), 0];
        _locplus5 = [(round (_locBot select 0)) + 5, (_locBot select 1), 0];
        _locplus55 = [(round (_locBot select 0)) + 5.5, (_locBot select 1), 0];
        _locplus6 = [(round (_locBot select 0)) + 6, (_locBot select 1), 0];
        _locplus65 = [(round (_locBot select 0)) + 6.5, (_locBot select 1), 0];
        _locplus7 = [(round (_locBot select 0)) + 7, (_locBot select 1), 0];

        // Draw lines if not outside area
        if (_locmin7 call fn_inCoverMap) then {
            drawLine3D [_locmin7, [(_locmin7 select 0), (_locmin7 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin65 call fn_inCoverMap) then {
            drawLine3D [_locmin65, [(_locmin65 select 0), (_locmin65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin6 call fn_inCoverMap) then {
            drawLine3D [_locmin6, [(_locmin6 select 0), (_locmin6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin55 call fn_inCoverMap) then {
            drawLine3D [_locmin55, [(_locmin55 select 0), (_locmin55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin5 call fn_inCoverMap) then {
            drawLine3D [_locmin5, [(_locmin5 select 0), (_locmin5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin45 call fn_inCoverMap) then {
            drawLine3D [_locmin45, [(_locmin45 select 0), (_locmin45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin4 call fn_inCoverMap) then {
            drawLine3D [_locmin4, [(_locmin4 select 0), (_locmin4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin35 call fn_inCoverMap) then {
            drawLine3D [_locmin35, [(_locmin35 select 0), (_locmin35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin3 call fn_inCoverMap) then {
            drawLine3D [_locmin3, [(_locmin3 select 0), (_locmin3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin25 call fn_inCoverMap) then {
            drawLine3D [_locmin25, [(_locmin25 select 0), (_locmin25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin2 call fn_inCoverMap) then {
            drawLine3D [_locmin2, [(_locmin2 select 0), (_locmin2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin15 call fn_inCoverMap) then {
            drawLine3D [_locmin15, [(_locmin15 select 0), (_locmin15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin1 call fn_inCoverMap) then {
            drawLine3D [_locmin1, [(_locmin1 select 0), (_locmin1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin05 call fn_inCoverMap) then {
            drawLine3D [_locmin05, [(_locmin05 select 0), (_locmin05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_loc call fn_inCoverMap) then {
            drawLine3D [_loc, [(_loc select 0), (_loc select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus05 call fn_inCoverMap) then {
            drawLine3D [_locplus05, [(_locplus05 select 0), (_locplus05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus1 call fn_inCoverMap) then {
            drawLine3D [_locplus1, [(_locplus1 select 0), (_locplus1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus15 call fn_inCoverMap) then {
            drawLine3D [_locplus15, [(_locplus15 select 0), (_locplus15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus2 call fn_inCoverMap) then {
            drawLine3D [_locplus2, [(_locplus2 select 0), (_locplus2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus25 call fn_inCoverMap) then {
            drawLine3D [_locplus25, [(_locplus25 select 0), (_locplus25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus3 call fn_inCoverMap) then {
            drawLine3D [_locplus3, [(_locplus3 select 0), (_locplus3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus35 call fn_inCoverMap) then {
            drawLine3D [_locplus35, [(_locplus35 select 0), (_locplus35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus4 call fn_inCoverMap) then {
            drawLine3D [_locplus4, [(_locplus4 select 0), (_locplus4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus45 call fn_inCoverMap) then {
            drawLine3D [_locplus45, [(_locplus45 select 0), (_locplus45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus5 call fn_inCoverMap) then {
            drawLine3D [_locplus5, [(_locplus5 select 0), (_locplus5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus55 call fn_inCoverMap) then {
            drawLine3D [_locplus55, [(_locplus55 select 0), (_locplus55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus6 call fn_inCoverMap) then {
            drawLine3D [_locplus6, [(_locplus6 select 0), (_locplus6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus65 call fn_inCoverMap) then {
            drawLine3D [_locplus65, [(_locplus65 select 0), (_locplus65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus7 call fn_inCoverMap) then {
            drawLine3D [_locplus7, [(_locplus7 select 0), (_locplus7 select 1), 10], [1,0,0,_alphaLine]];
        };
    };
    if (_disTop < 20) then {
        _alphaLine = linearConversion [10, 20, _disTop, 1, 0, true];

        // Find line locations
        _locmin7 = [(round (_locTop select 0)) - 7, (_locTop select 1), 0];
        _locmin65 = [(round (_locTop select 0)) - 6.5, (_locTop select 1), 0];
        _locmin6 = [(round (_locTop select 0)) - 6, (_locTop select 1), 0];
        _locmin55 = [(round (_locTop select 0)) - 5.5, (_locTop select 1), 0];
        _locmin5 = [(round (_locTop select 0)) - 5, (_locTop select 1), 0];
        _locmin45 = [(round (_locTop select 0)) - 4.5, (_locTop select 1), 0];
        _locmin4 = [(round (_locTop select 0)) - 4, (_locTop select 1), 0];
        _locmin35 = [(round (_locTop select 0)) - 3.5, (_locTop select 1), 0];
        _locmin3 = [(round (_locTop select 0)) - 3, (_locTop select 1), 0];
        _locmin25 = [(round (_locTop select 0)) - 2.5, (_locTop select 1), 0];
        _locmin2 = [(round (_locTop select 0)) - 2, (_locTop select 1), 0];
        _locmin15 = [(round (_locTop select 0)) - 1.5, (_locTop select 1), 0];
        _locmin1 = [(round (_locTop select 0)) - 1, (_locTop select 1), 0];
        _locmin05 = [(round (_locTop select 0)) - 0.5, (_locTop select 1), 0];
        _loc = [(round (_locTop select 0)), (_locTop select 1), 0];
        _locplus05 = [(round (_locTop select 0)) + 0.5, (_locTop select 1), 0];
        _locplus1 = [(round (_locTop select 0)) + 1, (_locTop select 1), 0];
        _locplus15 = [(round (_locTop select 0)) + 1.5, (_locTop select 1), 0];
        _locplus2 = [(round (_locTop select 0)) + 2, (_locTop select 1), 0];
        _locplus25 = [(round (_locTop select 0)) + 2.5, (_locTop select 1), 0];
        _locplus3 = [(round (_locTop select 0)) + 3, (_locTop select 1), 0];
        _locplus35 = [(round (_locTop select 0)) + 3.5, (_locTop select 1), 0];
        _locplus4 = [(round (_locTop select 0)) + 4, (_locTop select 1), 0];
        _locplus45 = [(round (_locTop select 0)) + 4.5, (_locTop select 1), 0];
        _locplus5 = [(round (_locTop select 0)) + 5, (_locTop select 1), 0];
        _locplus55 = [(round (_locTop select 0)) + 5.5, (_locTop select 1), 0];
        _locplus6 = [(round (_locTop select 0)) + 6, (_locTop select 1), 0];
        _locplus65 = [(round (_locTop select 0)) + 6.5, (_locTop select 1), 0];
        _locplus7 = [(round (_locTop select 0)) + 7, (_locTop select 1), 0];

        // Draw lines if not outside area
        if (_locmin7 call fn_inCoverMap) then {
            drawLine3D [_locmin7, [(_locmin7 select 0), (_locmin7 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin65 call fn_inCoverMap) then {
            drawLine3D [_locmin65, [(_locmin65 select 0), (_locmin65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin6 call fn_inCoverMap) then {
            drawLine3D [_locmin6, [(_locmin6 select 0), (_locmin6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin55 call fn_inCoverMap) then {
            drawLine3D [_locmin55, [(_locmin55 select 0), (_locmin55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin5 call fn_inCoverMap) then {
            drawLine3D [_locmin5, [(_locmin5 select 0), (_locmin5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin45 call fn_inCoverMap) then {
            drawLine3D [_locmin45, [(_locmin45 select 0), (_locmin45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin4 call fn_inCoverMap) then {
            drawLine3D [_locmin4, [(_locmin4 select 0), (_locmin4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin35 call fn_inCoverMap) then {
            drawLine3D [_locmin35, [(_locmin35 select 0), (_locmin35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin3 call fn_inCoverMap) then {
            drawLine3D [_locmin3, [(_locmin3 select 0), (_locmin3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin25 call fn_inCoverMap) then {
            drawLine3D [_locmin25, [(_locmin25 select 0), (_locmin25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin2 call fn_inCoverMap) then {
            drawLine3D [_locmin2, [(_locmin2 select 0), (_locmin2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin15 call fn_inCoverMap) then {
            drawLine3D [_locmin15, [(_locmin15 select 0), (_locmin15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin1 call fn_inCoverMap) then {
            drawLine3D [_locmin1, [(_locmin1 select 0), (_locmin1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locmin05 call fn_inCoverMap) then {
            drawLine3D [_locmin05, [(_locmin05 select 0), (_locmin05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_loc call fn_inCoverMap) then {
            drawLine3D [_loc, [(_loc select 0), (_loc select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus05 call fn_inCoverMap) then {
            drawLine3D [_locplus05, [(_locplus05 select 0), (_locplus05 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus1 call fn_inCoverMap) then {
            drawLine3D [_locplus1, [(_locplus1 select 0), (_locplus1 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus15 call fn_inCoverMap) then {
            drawLine3D [_locplus15, [(_locplus15 select 0), (_locplus15 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus2 call fn_inCoverMap) then {
            drawLine3D [_locplus2, [(_locplus2 select 0), (_locplus2 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus25 call fn_inCoverMap) then {
            drawLine3D [_locplus25, [(_locplus25 select 0), (_locplus25 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus3 call fn_inCoverMap) then {
            drawLine3D [_locplus3, [(_locplus3 select 0), (_locplus3 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus35 call fn_inCoverMap) then {
            drawLine3D [_locplus35, [(_locplus35 select 0), (_locplus35 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus4 call fn_inCoverMap) then {
            drawLine3D [_locplus4, [(_locplus4 select 0), (_locplus4 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus45 call fn_inCoverMap) then {
            drawLine3D [_locplus45, [(_locplus45 select 0), (_locplus45 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus5 call fn_inCoverMap) then {
            drawLine3D [_locplus5, [(_locplus5 select 0), (_locplus5 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus55 call fn_inCoverMap) then {
            drawLine3D [_locplus55, [(_locplus55 select 0), (_locplus55 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus6 call fn_inCoverMap) then {
            drawLine3D [_locplus6, [(_locplus6 select 0), (_locplus6 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus65 call fn_inCoverMap) then {
            drawLine3D [_locplus65, [(_locplus65 select 0), (_locplus65 select 1), 10], [1,0,0,_alphaLine]];
        };
        if (_locplus7 call fn_inCoverMap) then {
            drawLine3D [_locplus7, [(_locplus7 select 0), (_locplus7 select 1), 10], [1,0,0,_alphaLine]];
        };
    };
};

fn_playerSpawn = {
    player allowDamage true;
    player setPosASL (missionNamespace getVariable "RESPAWN_POSITION"); // Move to spawn
    "INNOCENT" remoteExec ["fn_playerUnitTracker", allPlayers];
    (missionNamespace getVariable "respawnTimeInfinite") remoteExec ["setPlayerRespawnTime", allPlayers];
};

fn_playerGearStart = {
    removeAllWeapons player;
    removeUniform player;
    removeVest player;
    removeBackpack player;
    removeHeadgear player;
    removeAllAssignedItems player;
    removeGoggles player;

    player linkItem "itemGPS";
    player linkItem (missionNamespace getVariable "gearRadio");
    player linkItem "ItemCompass";
    player addWeapon "Binocular";

    player forceAddUniform (missionNamespace getVariable "gearUniform");
    player addVest (missionNamespace getVariable "gearVest");
    player addHeadgear (missionNamespace getVariable "gearHeadgear");
    player addBackpack (missionNamespace getVariable "gearBackpack");
    player addItemToBackpack "Medikit";

    player setdamage 0;
    // TODO: check for ace before running
    [player] call ace_medical_treatment_fnc_fullHealLocal;
};

fn_playerUnitTracker = {
    switch (_this) do {
        case "WAITING": {
            missionNamespace setVariable ["TTT_role", "WAITING", false];
            [] spawn {
                // Spawn or update markers
                onEachFrame {
                    {
                        _markerName = (format ["%1_W", name _x]);
                        if (getMarkerColor _markerName == "") then {
                            // Create marker
                            _mk = createMarkerLocal [_markerName, (getPosVisual _x)];
                            _mk setMarkerTextLocal (name _x);
                            _mk setMarkerTypeLocal "n_inf";
                            _mk setMarkerColorLocal "colorIndependent";
                        } else {
                            // Update marker
                            _markerName setMarkerPosLocal (getPosVisual _x);
                        };
                    } foreach allPlayers;

                    [] spawn fn_playerHandleCoverMap;
                };

                waitUntil {((missionNamespace getVariable "TTT_role") != "WAITING" || (missionNamespace getVariable "TTT_overtime"))};

                // Delete markers
                onEachFrame {[] spawn fn_playerHandleCoverMap;};
                {
                    deleteMarkerLocal (format ["%1_W", name _x]);
                } foreach allPlayers;
            };
        };

        case "INNOCENT": {
            missionNamespace setVariable ["TTT_role", "INNOCENT", false];
            [] spawn {
                // Spawn or update markers
                onEachFrame {
                    _markerName = (format ["%1_I", name player]);
                    if (getMarkerColor _markerName == "") then {
                        // Create marker
                        _mk = createMarkerLocal [_markerName, (getPosVisual player)];
                        _mk setMarkerTextLocal (name player);
                        _mk setMarkerTypeLocal "n_inf";
                        _mk setMarkerColorLocal "colorIndependent";
                    } else {
                        // Update marker
                        _markerName setMarkerPosLocal (getPosVisual player);
                    };
                    if (!alive player) then {
                        _markerName setMarkerAlphaLocal 0;
                    };

                    [] spawn fn_playerHandleCoverMap;
                };

                waitUntil {((missionNamespace getVariable "TTT_role") != "INNOCENT" || (missionNamespace getVariable "TTT_overtime"))};

                // Delete markers
                onEachFrame {[] spawn fn_playerHandleCoverMap;};
                deleteMarkerLocal (format ["%1_I", name player]);
            };
        };

        case "DETECTIVE": {
            missionNamespace setVariable ["TTT_role", "DETECTIVE", false];
            [] spawn {
                // Spawn or update markers
                onEachFrame {
                    _markerName = (format ["%1_D", name player]);
                    if (getMarkerColor _markerName == "") then {
                        // Create marker
                        _mk = createMarkerLocal [_markerName, (getPosVisual player)];
                        _mk setMarkerTextLocal (name player);
                        _mk setMarkerTypeLocal "b_inf";
                        _mk setMarkerColorLocal "ColorBlufor";
                    } else {
                        // Update marker
                        _markerName setMarkerPosLocal (getPosVisual player);
                    };
                    if (!alive player) then {
                        _markerName setMarkerAlphaLocal 0;
                    };

                    [] spawn fn_playerHandleCoverMap;
                };

                waitUntil {((missionNamespace getVariable "TTT_role") != "DETECTIVE" || (missionNamespace getVariable "TTT_overtime"))};

                // Delete markers
                onEachFrame {[] spawn fn_playerHandleCoverMap;};
                deleteMarkerLocal (format ["%1_D", name player]);
            };
        };

        case "TRAITOR": {
            missionNamespace setVariable ["TTT_role", "TRAITOR", false];
            [] spawn {
                // Spawn or update markers
                onEachFrame {
                    _traitors = missionNamespace getVariable "TTT_traitors";
                    {
                        _markerName = (format ["%1_T", name _x]);
                        if (getMarkerColor _markerName == "") then {
                            // Create marker
                            _mk = createMarkerLocal [_markerName, (getPosVisual _x)];
                            _mk setMarkerTextLocal (name _x);
                            _mk setMarkerTypeLocal "o_inf";
                            _mk setMarkerColorLocal "ColorOpfor";
                        } else {
                            // Update marker
                            _markerName setMarkerPosLocal (getPosVisual _x);
                            _distance = player distance _x;
                            _pos = (getPosATLVisual _x);
                            _alphaIcon = linearConversion [20, 30, _distance, 1, 0, true];
                            _offsetIcon = linearConversion [0, 30, _distance, 2, 3, true];
                            if (_x != player) then {
                                drawIcon3D [
                                    "",
                                    [0.5,0,0,_alphaIcon],
                                    [(_pos select 0), (_pos select 1), ((_pos select 2) + _offsetIcon)],
                                    0,
                                    0,
                                    direction player,
                                    (name _x),
                                    0,
                                    0.04,
                                    "PuristaSemiBold",
                                    "center"
                                ];
                            };
                        };
                        if (!alive _x) then {
                            _markerName setMarkerAlphaLocal 0;
                        };
                    } foreach _traitors;

                    [] spawn fn_playerHandleCoverMap;
                };

                waitUntil {((missionNamespace getVariable "TTT_role") != "TRAITOR" || (missionNamespace getVariable "TTT_overtime"));};

                // Delete markers
                onEachFrame {[] spawn fn_playerHandleCoverMap;};
                {
                    deleteMarkerLocal (format ["%1_T", name _x]);
                } foreach allPlayers;
            };
        };

        case "OVERTIME": {
            [] spawn {
                // Spawn or update markers
                onEachFrame {
                    _innocents = missionNamespace getVariable "TTT_innocents";
                    _traitors = missionNamespace getVariable "TTT_traitors";
                    _detective = missionNamespace getVariable "TTT_detective";
                    {
                        _markerName = (format ["%1_IO", name _x]);
                        if (getMarkerColor _markerName == "") then {
                            // Create marker
                            _mk = createMarkerLocal [_markerName, (getPosVisual _x)];
                            _mk setMarkerTextLocal (name _x);
                            _mk setMarkerTypeLocal "o_inf";
                            _mk setMarkerColorLocal "colorIndependent";
                        } else {
                            // Update marker
                            _markerName setMarkerPosLocal (getPosVisual _x);
                            _distance = player distance _x;
                            if (!alive player) then {
                                _distance = 0;
                            };
                            _pos = (getPosATLVisual _x);
                            _alphaIcon = linearConversion [20, 30, _distance, 1, 0, true];
                            _offsetIcon = linearConversion [0, 30, _distance, 2, 3, true];
                            if (_x != player) then {
                                drawIcon3D [
                                    "",
                                    [0,0.5,0,_alphaIcon],
                                    [(_pos select 0), (_pos select 1), ((_pos select 2) + _offsetIcon)],
                                    0,
                                    0,
                                    direction player,
                                    "INNOCENT",
                                    2,
                                    0.04,
                                    "PuristaSemiBold",
                                    "center"
                                ];
                            };
                        };
                        if (!alive _x) then {
                            _markerName setMarkerAlphaLocal 0;
                        };
                    } foreach _innocents;
                    {
                        _markerName = (format ["%1_TO", name _x]);
                        if (getMarkerColor _markerName == "") then {
                            // Create marker
                            _mk = createMarkerLocal [_markerName, (getPosVisual _x)];
                            _mk setMarkerTextLocal (name _x);
                            _mk setMarkerTypeLocal "n_inf";
                            _mk setMarkerColorLocal "ColorOpfor";
                        } else {
                            // Update marker
                            _markerName setMarkerPosLocal (getPosVisual _x);
                            _distance = player distance _x;
                            if (!alive player) then {
                                _distance = 0;
                            };
                            _pos = (getPosATLVisual _x);
                            _alphaIcon = linearConversion [20, 30, _distance, 1, 0, true];
                            _offsetIcon = linearConversion [0, 30, _distance, 2, 3, true];
                            if (_x != player) then {
                                drawIcon3D [
                                    "",
                                    [0.5,0,0,_alphaIcon],
                                    [(_pos select 0), (_pos select 1), ((_pos select 2) + _offsetIcon)],
                                    0,
                                    0,
                                    direction player,
                                    "TRAITOR",
                                    2,
                                    0.04,
                                    "PuristaSemiBold",
                                    "center"
                                ];
                            };
                        };
                        if (!alive _x) then {
                            _markerName setMarkerAlphaLocal 0;
                        };
                    } foreach _traitors;
                    if (_detective != objNull) then {
                        _markerName = (format ["%1_DO", name _detective]);
                        if (getMarkerColor _markerName == "") then {
                            // Create marker
                            _mk = createMarkerLocal [_markerName, (getPosVisual _detective)];
                            _mk setMarkerTextLocal (name _detective);
                            _mk setMarkerTypeLocal "b_inf";
                            _mk setMarkerColorLocal "ColorBlufor";
                        } else {
                            // Update marker
                            _markerName setMarkerPosLocal (getPosVisual _detective);
                            _distance = player distance _detective;
                            if (!alive player) then {
                                _distance = 0;
                            };
                            _pos = (getPosATLVisual _detective);
                            _alphaIcon = linearConversion [20, 30, _distance, 1, 0, true];
                            _offsetIcon = linearConversion [0, 30, _distance, 2, 3, true];
                            if (_detective != player) then {
                                drawIcon3D [
                                    "",
                                    [0,0.3,0.6,_alphaIcon],
                                    [(_pos select 0), (_pos select 1), ((_pos select 2) + _offsetIcon)],
                                    0,
                                    0,
                                    direction player,
                                    "DETECTIVE",
                                    2,
                                    0.04,
                                    "PuristaSemiBold",
                                    "center"
                                ];
                            };
                        };
                        if (!alive _detective) then {
                            _markerName setMarkerAlphaLocal 0;
                        };
                    };

                    [] spawn fn_playerHandleCoverMap;
                };

                waitUntil {(((missionNamespace getVariable "TTT_role") != "INNOCENT" && (missionNamespace getVariable "TTT_role") != "DETECTIVE" && (missionNamespace getVariable "TTT_role") != "TRAITOR") || !(missionNamespace getVariable "TTT_overtime"));};

                // Delete markers
                onEachFrame {[] spawn fn_playerHandleCoverMap;};
                {
                    deleteMarkerLocal (format ["%1_IO", name _x]);
                } foreach allPlayers;
                {
                    deleteMarkerLocal (format ["%1_TO", name _x]);
                } foreach allPlayers;
                {
                    deleteMarkerLocal (format ["%1_DO", name _x]);
                } foreach allPlayers;
            };
        };
    };
};

fn_setTexture = {
    (_this select 0) setObjectTexture [0, (_this select 1)];
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

switch (_this) do {
    // Start game
    case "START": {
        [] spawn {
            // Exit if game is already ongoing or init has not been called
            if ((missionNamespace getVariable "TTT_gameOngoing")) exitWith {
                hint "TTT game is already ongoing";
            };
            missionNamespace setVariable ["TTT_gameOngoing", true, true];
            missionNamespace setVariable ["TTT_startingDone", false];
            missionNamespace setVariable ["TTT_preparingDone", false];

            [] spawn fn_gameTextStarting;
            waitUntil {missionNamespace getVariable ["TTT_startingDone", false]};
            [] remoteExec ["fn_playerGearStart", allPlayers];
            { deleteVehicle _x; } forEach allDead;
            [] spawn fn_lootSpawner;
            [] call fn_makeTeams;
            [] remoteExec ["fn_playerSpawn", allPlayers];
            [] spawn fn_gameTextPreparing;
            waitUntil {missionNamespace getVariable ["TTT_preparingDone", false]};
            [] spawn fn_handleGame;
            [] spawn fn_gameText;
        };
    };

    // End game
    case "STOP": {
        [] call {
            missionNamespace setVariable ["TTT_overtime", false, true];
            missionNamespace setVariable ["TTT_timeLeft", missionNamespace getVariable "TTT_timeLimit", true];

            // Delete loot
            {
                clearWeaponCargoGlobal _x;
                clearMagazineCargoGlobal _x;
                clearItemCargoGlobal _x;
                clearBackpackCargoGlobal _x;
                deleteVehicle _x;
            } foreach (missionNamespace getVariable "TTT_lootDrops");
            { deleteVehicle _x; } forEach nearestObjects [[4200,4150],["WeaponHolder","GroundWeaponHolder"],160];
            missionNamespace setVariable ["TTT_lootDrops", [], true];

            // Respawn dead players
            sleep 5;
            0.1 remoteExec ["setPlayerRespawnTime", allPlayers];
            sleep 0.5;
            { deleteVehicle _x; } forEach allDead;
            _alivePlayers = [];
            {
                if (alive _x) then {
                    _alivePlayers pushback _x;
                };
            } foreach allPlayers;
            "SPAWN" remoteExec ["ZO_fnc_TTT", _alivePlayers];
            missionNamespace setvariable ["respawnWave", false, true];
        };
    };

    // Spawn player and set default stuff
    case "SPAWN": {
        [player] join grpNull; // Leave group
        player allowDamage false;
        player enableStamina false;
        player setPosASL (missionNamespace getVariable "RESPAWN_POSITION"); // Move to spawn
        "WAITING" spawn fn_playerUnitTracker; // Reinitialize unitTracker
        [] spawn fn_playerHandleRespawn; // Handle respawn
        [] spawn fn_playerGearStart; // Gear start
    };

    case "INIT": {
        "SPAWN" spawn ZO_fnc_TTT;
        [] spawn fn_playerGearLock;
        onEachFrame {[] spawn fn_playerHandleCoverMap;};

        waitUntil {!alive player};

        if (!(missionNamespace getVariable "TTT_gameOngoing")) then {
            // respawn
            setPlayerRespawnTime 0.1;
            sleep 1;
        };
    };
};

// TODO:
//   - remove debugs
