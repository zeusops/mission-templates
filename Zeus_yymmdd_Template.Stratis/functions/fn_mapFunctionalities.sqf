/*
	@file_name: fn_mapFunctionalities.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_enterZeus = {
	// Remove toggle grass
	[] call fn_removeToggleGrass;

	// Find position to put toggle respawn button
	private _mapButtons = missionNameSpace getvariable "mapButtons";
	private _worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	private _pos = [-500, -1500];
	if (_worldSize > 0 && _worldSize < 5000) then {
		_pos = [-500, -600];
	};

	// Spawn respawn position marker
	private _mk = createMarkerLocal ["respawnPosition", (missionNameSpace getVariable "RESPAWN_POSITION")];
	_mk setMarkerTypeLocal "mil_dot";
	_mk setMarkerSizeLocal [0.5,0.5];
	_mk setMarkerTextLocal "RESPAWN POSITION";

	// Spawn zeus info marker
	private _mk = createMarkerLocal ["zeusInfo", _pos];
	_mk setMarkerTypeLocal "mil_dot";
	_mk setMarkerSizeLocal [0,0];
	_mk setMarkerTextLocal "";

	// Spawn respawn position marker updater
	onEachFrame {
		_respawnPos = ASLToAGL (missionNameSpace getVariable "RESPAWN_POSITION");
		_distance = player distance _respawnPos;
		_alphaIcon = linearConversion [500, 1500, _distance, 1, 0.1, true];
		_alphaLine = linearConversion [50, 500, _distance, 1, 0, true];
		drawIcon3D [
			"",
			[0,0,0,_alphaIcon],
			[_respawnPos select 0, _respawnPos select 1, (_respawnPos select 2) + 5],
			0,
			0,
			direction player,
			"RESPAWN POSITION",
			0,
			0.04,
			"PuristaSemiBold",
			"center"
		];
		drawLine3D [[_respawnPos select 0, _respawnPos select 1, _respawnPos select 2], [_respawnPos select 0, _respawnPos select 1, (_respawnPos select 2) + 4], [0,0,0,_alphaLine]];
		"respawnPosition" setMarkerPosLocal _respawnPos;
		if (missionNameSpace getVariable "respawnAllow") then {
			"zeusInfo" setMarkerTextLocal format ["        RESPAWN Enabled - Next wave: %1s", missionNameSpace getVariable "respawnNextWaveTime"];
		} else {
			"zeusInfo" setMarkerTextLocal "        RESPAWN Disabled";
		};
	};
};

fn_exitZeus = {
	[] call fn_spawnToggleGrass;
	deleteMarkerLocal "respawnPosition";
	deleteMarkerLocal "zeusInfo";
	onEachFrame{};
};

fn_isInZeus = {
    (!isNull (findDisplay 312) || playerSide == sideLogic);
};

fn_spawnToggleGrass = {
	private _worldSize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	private _pos = [-500, -1500];
	if (_worldSize > 0 && _worldSize < 5000) then {
		_pos = [-500, -600];
	};

	private _mk = createMarkerLocal ["toggleGrassButtonCenter", _pos];
	_mk setMarkerAlphaLocal 0;
	_mk setMarkerTypeLocal "mil_dot_noShadow";
	_mk setMarkerSizeLocal [2.35,2.35];

	private _mk = createMarkerLocal ["toggleGrassButton", _pos];
	_mk setMarkerTypeLocal "mil_circle";
	_mk setMarkerSizeLocal [0.8,0.8];
	_mk setMarkerTextLocal " Toggle Grass";

	missionNameSpace setVariable ["toggleGrass", 0, false]; //local
};

fn_removeToggleGrass = {
	deleteMarkerLocal "toggleGrassButtonCenter";
	deleteMarkerLocal "toggleGrassButton";
};

fn_spawnEventHandler = {
	[
		"leftClick_EH",
		"onMapSingleClick",
		{
			private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
			private _onToggleGrass = false;
			private _mkPos = getMarkerPos "toggleGrassButton";

			// Exit if zeus
			if ([] call fn_isInZeus) exitWith {};

			// Set posMkBool to true if clicking (roughly) on toggle grass
			if ((_pos select 0) > (_mkPos select 0) - _scale*300 && (_pos select 0) < (_mkPos select 0) + _scale*300 && (_pos select 1) > (_mkPos select 1) - _scale*300 && (_pos select 1) < (_mkPos select 1) + _scale*300) then {
				_onToggleGrass = true;
			};

			// If clicked toggle grass button
			if (_onToggleGrass) then {
				// Show animation with 00 button
				[] spawn {
					"toggleGrassButtonCenter" setMarkerAlphaLocal 0.8;
					playSound "sound1";
					while {markerAlpha "toggleGrassButtonCenter" > 0} do {
						"toggleGrassButtonCenter" setMarkerAlphaLocal (markerAlpha "toggleGrassButtonCenter" - 0.05);
						sleep 0.01;
					};
				};

				// Toggle grass
				private _toggleGrass = [1,0] select (missionNameSpace getVariable "toggleGrass");
				missionNameSpace setVariable ["toggleGrass", _toggleGrass, false];
				if (_toggleGrass == 1) then {
					setTerrainGrid 50;
				} else {
					setTerrainGrid 25;
				};
			};
		},
		[]
	] call BIS_fnc_addStackedEventHandler;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

// Spawn toggle grass buttons
[] call fn_spawnToggleGrass;

// Spawn eventhandler
[] call fn_spawnEventHandler;

// Handler for adding/removing zeus markers
while {true} do {
	// Add markers when in zeus
	waitUntil {[] call fn_isInZeus;};
	[] call fn_enterZeus;

	// Remove markers when out of zeus
	waitUntil {!([] call fn_isInZeus);};
	[] call fn_exitZeus;
};
