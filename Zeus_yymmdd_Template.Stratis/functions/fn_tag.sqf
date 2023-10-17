/*
    @file_name: fn_tag.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_tag_other = {
    _taggedPlayer = _this;
    diag_log format["_taggedPlayer %1", _taggedPlayer];
    [] remoteExec ["fn_tag_self", _taggedPlayer];
};

fn_untag_other = {
    _untaggedPlayer = _this;
    [] remoteExec ["fn_untag_self", _untaggedPlayer];
};

fn_tag_self = {
    if (player getVariable ["isTagger", false]) exitWith {};

    if (uniform player == "") then {
        player forceAddUniform (missionNameSpace getVariable "gearUniform");
    };
    [player, "#(rgb,8,8,3)color(0.3,0,0,1)"] remoteExec ["fn_setTexture", [0,-2] select isDedicated, true];
    player setVariable ["isTagger", true, false];


    _all_untagged = (missionNamespace getVariable ["Tag_playersUnmarked", []]) - [name player];

    missionNamespace setVariable ["Tag_playersUnmarked", _all_untagged, true];

    [] spawn fn_showTagged;
    [] spawn fn_playerGearLock;
    [] spawn fn_handleTagger;
};

fn_untag_self = {
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
                _x call fn_tag_other;
                // Only untag self if not in contagion mode
                if (!(missionNamespace getVariable ["Tag_isContagionMode", false])) then {
                    player call fn_untag_self;
                };
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

fn_resetColour = {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1], [0.0, 0.0, 0.0, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;
};

fn_showTagged = {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.0, 0.0, 0.0, 0.0], [1, 0, 0, 0.75], [0.9, 0.9, 0.9, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;

    sleep 0.5;

    call fn_resetColour;

};

fn_showUntagged = {
    "colorCorrections" ppEffectEnable true;
    "colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.0, 0.0, 0.0, 0.0], [0, 0, 1, 0.75], [0.9, 0.9, 0.9, 0.0]];
    "colorCorrections" ppEffectCommit 0.3;

    sleep 0.5;

    call fn_resetColour;
};

//Angel tag 2023-09-05
fn_pickTagger = {
    // Fetch alive players
    _unmarkedNames = [];
    _unmarkedObjects = [];
    {
        if (alive _x) then {
            _unmarkedNames pushback name _x;
            _unmarkedObjects pushback _x;
        };
        _x call fn_untag_other;
    } foreach allPlayers;

    missionNameSpace setVariable ["Tag_playersUnmarked", _unmarkedNames, true];

    // Select tagger
    _playerTagger = selectRandom _unmarkedObjects;
    diag_log format["Tagger: %1", _playerTagger];
    _playerTagger call fn_tag_other;
};

fn_endGame = {
    // acknowledge game over
    if (missionNamespace getVariable ["Tag_isContagionMode", false]) then {
        _winner = ((missionNamespace getVariable ["Tag_playersUnmarked", []]) + ["missingno"]) select 0;
        [
            parseText (format["<t font='PuristaBold' size='1.6' align='left'>Game Over! %1 is the winner</t>", _winner])
        ] remoteExec ["hint", [0,-2] select isDedicated, true];
    } else {
        [
            parseText "<t font='PuristaBold' size='1.6' align='left'>Game Over!</t>"
        ] remoteExec ["hint", [0,-2] select isDedicated, true];
    };
    missionNameSpace setVariable ["Tag_gameOngoing", false, true];
    {
        [] remoteExec ["fn_untag_self", _x];
    } foreach allPlayers;
};

fn_checkEndGame = {
    if (!(missionNamespace getVariable ["Tag_isContagionMode", false])) exitWith {};
    while {missionNameSpace getVariable ["Tag_gameOngoing", false]} do {
        sleep 1;
        _all_untagged = missionNamespace getVariable ["Tag_playersUnmarked", []];
        if (count _all_untagged <= 1) exitWith {
            [] spawn fn_endGame;
        };
    };
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

fn_tag = {
    switch (_this) do {
        case "START": {
            [] call {
                // Exit if game is already ongoing or init has not been called
                if (missionNameSpace getVariable ["Tag_gameOngoing", false]) exitWith {
                    hint "Tag game is already ongoing";
                    diag_log "Tag game is already ongoing";
                };
                missionNameSpace setVariable ["Tag_gameOngoing", true, true];
                [] call fn_pickTagger;
                [] spawn fn_checkEndGame;
            };
        };

        case "tag_other": {
            _player = _this select 1;
            _player call fn_tag_other;
        };

        case "untag_other": {
            _player = _this select 1;
            _player call fn_untag_other;
        };

        // Locally called by player that gets tagged
        case "tag_self": {
            [] call fn_tag_self;
        };

        // Locally called by player that gets untagged
        case "untag_self": {
            [] call fn_untag_self;

        };

    };
};
