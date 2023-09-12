/*
	@file_name: fn_tag.sqf
	@file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_tag = {
  if (!(player getVariable ["isTagger", false])) exitWith {
    _taggedPlayer = _this;
    ["tagged"] remoteExec ["ZO_fnc_tag", [_taggedPlayer]];
  };
};

fn_untag = {
    _untaggedPlayer = _this;
    ["untagged"] remoteExec ["ZO_fnc_tag", [_untaggedPlayer]];
};

fn_tagged = {
    if (uniform player == "") then {
        player forceAddUniform (missionNameSpace getVariable "gearUniform");
    };
    [player, "#(rgb,8,8,3)color(0.3,0,0,1)"] remoteExec ["fn_setTexture", [0,-2] select isDedicated, true];
    player setVariable ["isTagger", true, false];
    [] spawn fn_showTagged;
    [] spawn fn_playerGearLock;
    [] spawn fn_handleTagger;
};

fn_untagged = {
	if(missionNameSpace getVariable "Tag_isContagionMode") exitWith {
		hint "Contagion Mode";
	}
	hint "Not in Contagion Mode";
	// Save uniform and uniform items
	_uniform = uniform player;
	_uniformItems = [];
	{
		_uniformItems pushback _x;
	} foreach (uniformItems player);

	// Re-add and refill uniform
	removeUniform player;
	player forceAddUniform _uniform;
	{
		player addItemToUniform _x;
	} foreach _uniformItems;

	player setVariable ["isTagger", false, false];
	[] spawn fn_showUntagged;
};

fn_handleTagger = {
    sleep 1;
	while {player getVariable ["isTagger", false]} do
    {
        {
            if ((player distance _x) < 2) exitWith {
                // player call fn_untagged;
                _x call fn_tag;
            };
        } foreach (allUnits - [player]);
        sleep 0.1;
    };
};

fn_setTexture = {
    (_this select 0) setObjectTexture [0, (_this select 1)];
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

	while {player getVariable ["isTagger", false]} do
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

fn_showTagged = {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.0, 0.0, 0.0, 0.0], [1, 0, 0, 0.75], [0.9, 0.9, 0.9, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;

    sleep 0.5;

    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1], [0.0, 0.0, 0.0, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;
};

fn_showUntagged = {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.0, 0.0, 0.0, 0.0], [0, 0, 1, 0.75], [0.9, 0.9, 0.9, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;

    sleep 0.5;

    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1], [0.0, 0.0, 0.0, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;
};

//Angel tag 2023-09-05
fn_pickTagger = {
	// Fetch alive players
	_playersUnmarked = [];
	{
		if (alive _x) then { _playersUnmarked pushback _x; };
		_x call fn_untag;
	} foreach allPlayers;


	// Select tagger
	_playersUnmarkedCount = count _playersUnmarked;
	_playerTagger = (_playersUnmarked deleteAt (round random (_playersUnmarkedCount - 1)));
	

	missionNameSpace setVariable ["Tag_playersUnmarked", _playersUnmarked, true];
	missionNameSpace setVariable ["Tag_playerTagger", _playerTagger, true];
	missionNameSpace setVariable ["Tag_isContagionMode", true, true];
	
	_playerTagger call fn_tag;
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

switch (_this) do {
	case "START": {
		[] call {
			// Exit if game is already ongoing or init has not been called
			if ((missionNameSpace getVariable "Tag_gameOngoing")) exitWith {
				hint "Tag game is already ongoing";
			};
			missionNameSpace setVariable ["Tag_gameOngoing", true, true];
			[] call fn_pickTagger;
		};
	};
}
_request = _this select 0;

switch (_request) do {
    case "tag": {
        _player = _this select 1;
        _player call fn_tag;
    };

    case "untag": {
        _player = _this select 1;
        _player call fn_untag;
    };

    // Locally called by player that gets tagged
    case "tagged": {
        [] call fn_tagged;
    };

    // Locally called by player that gets untagged
    case "untagged": {
        [] call fn_untagged;
		
    };	
	
}
