cbrn_maxDamage = 100; // how much damage before death, 50% starts internal contamination
cbrn_backpacks = [
    "B_CombinationUnitRespirator_01_F",
    "tfar_bussole",
    "B_SCBA_01_F",
    "rhs_r148",
    "rhs_medic_bag",
    "PB_ASSAULT_MED_Green",
    "TFAR_rt1523g_black",
    "rhs_rd54_vest_emr1",
    "rhs_rk_sht_30_emr",
    "rhs_rk_sht_30_emr_engineer_empty",
    "rhs_rk_sht_30_olive",
    "rhs_rk_sht_30_olive_engineer_empty"
];
cbrn_suits = [
    "U_C_CBRN_Suit_01_Blue_F",
    "U_B_CBRN_Suit_01_MTP_F",
    "U_B_CBRN_Suit_01_Tropic_F",
    "U_C_CBRN_Suit_01_White_F",
    "U_B_CBRN_Suit_01_Wdl_F",
    "U_I_CBRN_Suit_01_AAF_F",
    "U_I_E_CBRN_Suit_01_EAF_F",
    "U_CBRN_B_blue",
    "UK3CB_ADC_C_Pants_U_20",
    "U_CBRN_C_blue",
    "U_CBRN_B_black",
    "U_CBRN_B_green",
    "U_CBRN_A_woodland",
    "U_CBRN_A_multicam",
    "U_CBRN_C_orange",
    "U_CBRN_C_red",
    "U_CBRN_C_white",
    "U_CBRN_C_yellow",
    "C_CBRN_DLC_bluegreen",
    "U_CBRN_DLC_cyan",
    "U_CBRN_DLC_orange",
    "U_CBRN_DLC_yellow",
    "U_B_PilotCoveralls"
];
cbrn_masks = [
    "G_AirPurifyingRespirator_02_black_F",
    "G_AirPurifyingRespirator_02_olive_F",
    "G_AirPurifyingRespirator_02_sand_F",
    "G_AirPurifyingRespirator_01_F",
    "G_RegulatorMask_F",
    "G_CBRN_A",
    "G_CBRN_A_multicam",
    "G_BRN_A_woodland",
    "G_CBRN_B",
    "G_CBRN_B_black",
    "G_CBRN_B_blue",
    "G_CBRN_B_green",
    "G_CBRN_C_blue",
    "G_CBRN_C_orange",
    "G_CBRN_C_red",
    "G_CBRN_C_white",
    "G_CBRN_C_yellow"
];
cbrn_threatMeteritem = "ACE_microDAGR";
cbrn_maxOxygenTime = 60 * 30;

// do not edit below here unless you know what you are doing
if !(hasInterface) exitWith {};
cbrn_localZones = [];
cbrn_curThreat = 0;
cbrn_lastBeep = -1;
cbrn_beepVolume = 2;
cbrn_beep = true;
["cbrn_createZone", {
    params ["_pos", "_threatLevel", "_size", "_falloffArea", "_height", "_activationVariable"];
    private _trg = createTrigger ["EmptyDetector", _pos, false];
    _trg setVariable ["cbrn_zone", true];
    _trg enableDynamicSimulation false;
    _trg setVariable ["cbrn_active", true];
    _trg setVariable ["cbrn_threatLevel", _threatLevel];
    _trg setVariable ["cbrn_size", _size];
    _trg setVariable ["cbrn_falloffArea", _falloffArea];
    _trg setVariable ["cbrn_height", _height];
    _trg setVariable ["cbrn_activationVariable", _activationVariable];
    private _radius = _size + _falloffArea;
    _trg setTriggerArea [_radius, _radius, 0, false, _radius];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["thisTrigger getVariable ['cbrn_active',false] && {this && {(vehicle ace_player) in thisList}}", "[thisTrigger, ace_player, true] call cbrn_fnc_addZone", "[thisTrigger, ace_player, false] call cbrn_fnc_addZone"];
    cbrn_localZones pushBack _trg;
}] call CBA_fnc_addEventhandler;


// display gas mask overlay above ace nvg and below DUI
if !(isNil "ace_nightvision") then {
    "ace_nightvision_display" cutFadeOut 0;
};
"cbrn_gasmask_overlay" cutFadeOut 0;
if !(isNil "diwako_dui_radar") then {
    "diwako_dui_compass" cutFadeOut 0;
    "diwako_dui_namebox" cutFadeOut 0;
};
