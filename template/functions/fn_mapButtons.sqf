/*
	@file_name: fn_mapButtons.sqf
	@file_edit: 24/02/2018
*/

//spawn 00 button
[] call {
	private _mk = createMarkerLocal ["mapButton00", [0,0]];
	_mk setMarkerAlphaLocal 0;
	_mk setMarkerTypeLocal "mil_dot_noShadow";
	_mk setMarkerSizeLocal [2.35,2.35];
};

missionNameSpace setVariable ["mapButton01", 0, false]; //local
missionNameSpace setVariable ["mapButtons",["mapButton01"], false]; //local

//spawn zeus checker
[] spawn {
	//when a zeus, give the marker, else remove it.
	waitUntil {playerSide == sideLogic};
	
	private _mapButtons = missionNameSpace getvariable "mapButtons";
	
	private _marker = createMarkerLocal ["mapButton02", [((getMarkerPos "mapButton01") select 0),((getMarkerPos "mapButton01") select 1)+1000]];
	_marker setMarkerTypeLocal "mil_circle";
	_marker setMarkerSizeLocal [0.8,0.8];
	_marker setMarkerTextLocal " Reinforcement Wave";
	_mapButtons pushback _marker;
	
	private _marker = createMarkerLocal ["mapButton03", (getMarkerPos "respawn")];
	_marker setMarkerTypeLocal "mil_circle";
	_marker setMarkerSizeLocal [0.8,0.8];
	_marker setMarkerTextLocal " RESPAWN LOCATION";
	_mapButtons pushback _marker;
	
	private _marker = createMarkerLocal ["mapButton04", [((getMarkerPos "mapButton01") select 0),((getMarkerPos "mapButton01") select 1)+2000]];
	_marker setMarkerTypeLocal "mil_circle";
	_marker setMarkerSizeLocal [0.8,0.8];
	_marker setMarkerTextLocal " Body Bag Everyone";
	_mapButtons pushback _marker;
	
	missionNameSpace setvariable ["mapButtons", _mapButtons, false];
};

//spawn eventhandler
[
	"leftClick_EH",
	"onMapSingleClick",
	{
		private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
		private _posMkBool = false;
		private _posMk = nil;
		private _mapButton03 = missionNameSpace getVariable "mapButton03";
		private _mapButton03_user = missionNameSpace getVariable "mapButton03_user";
		
		//set posMkBool to true if clicking (roughly) on a mapButton, and posMk to that marker
		{
			if ((_pos select 0) > (getMarkerPos _x select 0) - _scale*300 && (_pos select 0) < (getMarkerPos _x select 0) + _scale*300 && (_pos select 1) > (getMarkerPos _x select 1) - _scale*300 && (_pos select 1) < (getMarkerPos _x select 1) + _scale*300) exitWith {
				_posMkBool = true;
				_posMk = _x;
			};
		} foreach (missionNameSpace getVariable "mapButtons");
		
		//move mapButton03 to cursor if you are currently moving that marker
		if (_mapButton03 == 1 && player == _mapButton03_user) then {
			_mapButton03 = 0;
			missionNameSpace setVariable ["mapButton03", _mapButton03, true];
				
			_mapButton03_user = objNull;
			missionNameSpace setVariable ["mapButton03_user", _mapButton03_user, true];
			
			//get array of all zeuses
			private _zeuses = [];
			{
				if (side _x == sideLogic) then {
					_zeuses pushback _x;
				};
			} foreach allPlayers;
			
			//give hint to all zeuses
			[0, ["RESPAWN POSITION has been moved.", "PLAIN"]] remoteExec ["cutText", _zeuses];
			
			//put marker down at cursor position.
			["mapButton03", _pos] remoteExec ["setMarkerPosLocal", _zeuses];
			
			missionNameSpace setVariable ["RESPAWN_POSITION", _pos, true];
		} else {
		
			//if clicked on a button, do whatever should happen
			if (_posMkBool) then {
				//show animation with 00 button
				[_posMk] spawn {
					private _posMk = _this select 0;
					"mapButton00" setMarkerPosLocal (getMarkerPos _posMk);
					"mapButton00" setMarkerAlphaLocal 0.8;
					playSound "sound1";
					while {markerAlpha "mapButton00" > 0} do {
						"mapButton00" setMarkerAlphaLocal (markerAlpha "mapButton00" - 0.05);
						sleep 0.01;
					};
				};
				
				//run the button specific code
				switch (_posMk) do {
					case "mapButton01": {
						private _mapButton01 = missionNameSpace getVariable "mapButton01";
						_mapButton01 = [1,0] select _mapButton01;
						missionNameSpace setVariable ["mapButton01", _mapButton01, false];
						
						if (_mapButton01 == 1) then {
							setTerrainGrid 50;
						} else {
							setTerrainGrid 25;
						};
					};
					
					case "mapButton02": {
						//get array of all zeuses
						private _zeuses = [];
						{
							if (side _x == sideLogic) then {
								_zeuses pushback _x;
							};
						} foreach allPlayers;
						
						//give hint to all zeuses
						[0, ["A respawn wave has been triggered.", "PLAIN"]] remoteExec ["cutText", _zeuses];
						
						//force respawn all bagged dead people
						missionNameSpace setvariable ["respawnWaveForce", true, true]; //change to just changing a variable for everyone
					};
					
					case "mapButton03": {
							if (_mapButton03 == 0 && isNull _mapButton03_user) then {
							_mapButton03 = 1;
							missionNameSpace setVariable ["mapButton03", _mapButton03, true];
							
							_mapButton03_user = player;
							missionNameSpace setVariable ["mapButton03_user", _mapButton03_user, true];
							
							//get array of all zeuses
							private _zeuses = [];
							{
								if (side _x == sideLogic) then {
									_zeuses pushback _x;
								};
							} foreach allPlayers;
							
							//give hint to all zeuses
							[0, ["RESPAWN POSITION is being moved.", "PLAIN"]] remoteExec ["cutText", _zeuses];
						};
					};
					
					case "mapButton04": {
						//get array of all zeuses
						private _zeuses = [];
						{
							if (side _x == sideLogic) then {
								_zeuses pushback _x;
							};
						} foreach allPlayers;
						
						//give hint to all zeuses
						[0, ["Force body bagged everyone.", "PLAIN"]] remoteExec ["cutText", _zeuses];
						
						//force body bag all dead people
						missionNameSpace setvariable ["forceBodyBag", true, true]; //change to just changing a variable for everyone
						
						[] spawn {
							sleep 2;
							missionNameSpace setvariable ["forceBodyBag", false, true]; //change to just changing a variable for everyone
						};
					};
				};
			};
		};
	},
	[]
] call BIS_fnc_addStackedEventHandler;