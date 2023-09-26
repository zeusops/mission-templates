/*
    @file_name: fn_holdActionAdd.sqf
    @file_author: Jiri Wainar, modified by Dyzalonius

    Description:
    Add a hold action. If the hold actions are not initialized yet, initialize the system first.

    Parameters:
    0: OBJECT - object action is attached to
    1: CODE - code that produces action title text shown in action menu
    2: STRING or CODE - idle icon shown on screen; if CODE is used the code needs to return the path to icon
    3: STRING or CODE - progress icon shown on screen; if CODE is used the code needs to return the path to icon
    4: STRING - condition for the action to be shown; special variables passed to the script code are _target (unit to which action is attached to) and _this (caller/executing unit)
    5: STRING - condition for action to progress; if false is returned action progress is halted; arguments passed into it are: _target, _caller, _id, _arguments
    6: CODE - code executed on start; arguments passed into it are [target, caller, ID, arguments]
        0: OBJECT - target (_this select 0) - the object which the action is assigned to
        1: OBJECT - caller (_this select 1) - the unit that activated the action
        2: NUMBER - ID (_this select 2) - ID of the activated action (same as ID returned by addAction)
        3: ARRAY - arguments (_this select 3) - arguments given to the script if you are using the extended syntax
    7: CODE - code executed on every progress tick; arguments [target, caller, ID, arguments, currentProgress]; max progress is always 24
    8: CODE - code executed on completion; arguments [target, caller, ID, arguments]
    9: CODE - code executed on interrupted; arguments [target, caller, ID, arguments]
    10: ARRAY - arguments passed to the scripts
    11: NUMBER - action duration; how much time it takes to complete the action
    12: NUMBER - priority; actions are arranged in descending order according to this value
    13: BOOL - remove on completion (default: true)
    14: BOOL - show in unconscious state (default: false)
    15: BOOL - show on screen; if false action needs to be selected from action menu to appear on screen (default: true)

    Example:
    [_target,_title,_iconIdle,_iconProgress,_condShow,_condProgress,_codeStart,_codeProgress,_codeCompleted,_codeInterrupted,_arguments,_duration,_priority,_removeCompleted,_showUnconscious] call bis_fnc_holdActionAdd;

    Returns:
    Action ID, can be used for removal or referencing from other functions.
*/
#define FRAME_MAX_PROGRESS                24
#define FRAME_MAX_IDLE                    11
#define FRAME_MAX_IN                    3

#define ACTION_HIDE_ON_USE                false
#define ACTION_SHORTCUT                    ""
#define ACTION_DISTANCE                    15

#define TEXTURE_TEMPLATE_ICON_IDLE(icon)        (format["<img size='3' color='#ffffff' image='%1'/>",icon])
#define TEXTURE_TEMPLATE_ICON_PROGRESS(icon)        (format["<img size='3' color='#ffffff' image='%1'/>",icon])

#define TEXTURE_TEMPLATE_PROGRESS(frame)        (format["<img size='3' shadow='0' color='#ffffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa'/>",frame])    //frame 0-24
#define TEXTURE_TEMPLATE_IN(frame)            (format["<img size='3' shadow='0' color='#ffffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_%1_ca.paa'/>",frame])    //frame 0-3
#define TEXTURE_TEMPLATE_IDLE_PULSE(frame,color)    (format["<img size='3' shadow='0' color='%2' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_0_ca.paa'/>",frame,color])    //frame 0-3
#define TEXTURE_TEMPLATE_IDLE_ROTATION(frame)        (format["<img size='3' shadow='0' color='#ffffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\idle\idle_%1_ca.paa'/>",frame])    //frame 0-11

#define TEXTURES_PROGRESS                bis_fnc_holdAction_texturesProgress
#define TEXTURES_IDLE                    bis_fnc_holdAction_texturesIdle
#define TEXTURES_IN                    bis_fnc_holdAction_texturesIn

params
[
    ["_target",objNull,[objNull]],
    ["_titleCode",{},[{}]],
    ["_iconIdle","\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",["",{}]],
    ["_iconProgress","\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",["",{}]],
    ["_condShow","true",[""]],
    ["_condProgress","true",[""]],
    ["_codeStart",{},[{}]],
    ["_codeProgress",{},[{}]],
    ["_codeCompleted",{},[{}]],
    ["_codeInterrupted",{},[{}]],
    ["_arguments",[],[[]]],
    ["_duration",10,[123]],
    ["_priority",1000,[123]],
    ["_removeCompleted",true,[true]],
    ["_showUnconscious",false,[true]],
    ["_showWindow",true,[true]]
];

/*
["[ ] _target: %1",_target] call bis_fnc_logFormat;
["[ ] _titleCode: %1",_titleCode] call bis_fnc_logFormat;
["[ ] _iconIdle: %1",_iconIdle] call bis_fnc_logFormat;
["[ ] _iconProgress: %1",_iconProgress] call bis_fnc_logFormat;
["[ ] _condShow: %1",_condShow] call bis_fnc_logFormat;
["[ ] _condProgress: %1",_condProgress] call bis_fnc_logFormat;
["[ ] _codeStart: %1",_codeStart] call bis_fnc_logFormat;
["[ ] _codeProgress: %1",_codeProgress] call bis_fnc_logFormat;
["[ ] _codeCompleted: %1",_codeCompleted] call bis_fnc_logFormat;
["[ ] _codeInterrupted: %1",_codeInterrupted] call bis_fnc_logFormat;
["[ ] _arguments: %1",_arguments] call bis_fnc_logFormat;
["[ ] _duration: %1",_duration] call bis_fnc_logFormat;
["[ ] _priority: %1",_priority] call bis_fnc_logFormat;
["[ ] _removeCompleted: %1",_removeCompleted] call bis_fnc_logFormat;
["[ ] _showUnconscious: %1",_showUnconscious] call bis_fnc_logFormat;
*/

//convert to structured text
if (_iconIdle isEqualType "") then
{
    _iconIdle = TEXTURE_TEMPLATE_ICON_IDLE(_iconIdle);
};
if (_iconProgress isEqualType "") then
{
    _iconProgress = TEXTURE_TEMPLATE_ICON_PROGRESS(_iconProgress);
};

//prepare progress textures
if (isNil {TEXTURES_PROGRESS}) then
{
    TEXTURES_PROGRESS = [];
    for "_i" from 0 to FRAME_MAX_PROGRESS do
    {
        TEXTURES_PROGRESS pushBack TEXTURE_TEMPLATE_PROGRESS(_i);
    };
};

//prepare idle textures
if (isNil {TEXTURES_IDLE}) then
{
    TEXTURES_IDLE = [];

    private _alpha = 0;
    private _color = "";

    for "_i" from 0 to FRAME_MAX_IDLE do
    {
        _alpha = (sin((_i/FRAME_MAX_IDLE) * 360) * 0.25) + 0.75;
        _color = [1,1,1,_alpha] call bis_fnc_colorRGBAtoHTML;

        TEXTURES_IDLE pushBack TEXTURE_TEMPLATE_IDLE_PULSE(_i,_color);
    };
};

//prepare in textures
if (isNil {TEXTURES_IN}) then
{
    TEXTURES_IN = [];
    for "_i" from 0 to FRAME_MAX_IN do
    {
        TEXTURES_IN pushBack TEXTURE_TEMPLATE_IN(_i);
    };
};

//preprocess data
private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];
//STR_A3_HoldKeyTo: Hold %1 to %2
private _keyNameColored = format["<t color='#ffae00'>%1</t>",_keyName];
private _title = _target call _titleCode;
private _hint = format[localize "STR_A3_HoldKeyTo",_keyNameColored,_title];
_hint = format["<t font='RobotoCondensedBold'>%1</t>",_hint];
_title = format["<t color='#FFFFFF' align='left'>%1</t>        <t color='#83ffffff' align='right'>%2     </t>",_title,_keyName];

if (isNil "bis_fnc_holdAction_running") then {bis_fnc_holdAction_running = false;};
if (isNil "bis_fnc_holdAction_animationIdleFrame") then {bis_fnc_holdAction_animationIdleFrame = 0;};

//resize arguments array to max 10 items
_arguments resize 10;
_arguments = _arguments + [_target,_titleCode,_iconIdle,_iconProgress,_condShow,_condProgress,_codeStart,_codeProgress,_codeCompleted,_codeInterrupted,_duration,_removeCompleted];

//[_target,_actionID,_titleCode,_icon,_textures,_frame,_showHint,_keyName] call bis_fnc_holdAction_showIcon;
ZO_fnc_holdAction_showIcon =
{
    params
    [
        ["_target",objNull,[objNull]],
        ["_actionID",0,[123]],
        ["_titleCode",{},[{}]],
        ["_icon","",["",{}]],
        ["_texSet",TEXTURES_PROGRESS,[[]]],
        ["_frame",0,[123]],
        ["_showHint",false,[false]],
        ["_keyName", "",[""]]
    ];

    if (_icon isEqualType {}) then {
        _icon = _target call _icon;
    };

    _title = format["<t color='#FFFFFF' align='left'>%1</t>        <t color='#83ffffff' align='right'>%2     </t>",_target call _titleCode,_keyName];
    _hint = "";
    if (_showHint) then {
        private _hint = format[localize "STR_A3_HoldKeyTo",format["<t color='#ffae00'>%1</t>",_keyName],_target call _titleCode];
    };
    _target setUserActionText [_actionID,_title,_texSet select _frame,_icon + "<br/><br/>" + _hint];
};

ZO_fnc_holdAction_animationTimerCode =
{
    if (time > (missionNamespace getVariable ["bis_fnc_holdAction_animationIdleTime",-1]) && {_eval}) then
    {
        bis_fnc_holdAction_animationIdleTime = time + 0.065;
        bis_fnc_holdAction_animationIdleFrame = (bis_fnc_holdAction_animationIdleFrame + 1) % 12;

        //play idle animation only when action is not in progress
        if (!bis_fnc_holdAction_running) then
        {
            params["_titleCode","_iconIdle","_hint"];
            private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
            private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];

            //idle animations always have 12 frames
            [_originalTarget,_actionID,_titleCode,_iconIdle,TEXTURES_IDLE,bis_fnc_holdAction_animationIdleFrame,true,_keyName] call ZO_fnc_holdAction_showIcon;
        };
    };
};

private _codeInit =
{
    bis_fnc_holdAction_running = true;

    //check if another hold action is running, if so terminate the new hold action execution
    if (!isNil "ZO_fnc_holdAction_scriptHandle" && {!scriptDone ZO_fnc_holdAction_scriptHandle}) exitWith {};

    bis_fnc_holdAction_params = _this;
    ZO_fnc_holdAction_scriptHandle = _this spawn
    {
        //unwrap arguments supplied by addAction command
        params
        [
            ["_target",objNull,[objNull]],
            ["_caller",objNull,[objNull]],
            ["_actionID",10,[123]],
            ["_arguments",[],[[]]]
        ];

        private _this = _caller;    //needed for conditions, there _caller is refferenced as _this for some legacy reason ;(
        private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
        private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];

        //disable player's action menu
        {inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];

        //unwrap 'arguments' argument :)
        _arguments params["_a0","_a1","_a2","_a3","_a4","_a5","_a6","_a7","_a8","_a9","_target","_titleCode","_iconIdle","_iconProgress","_condShow","_condProgress","_codeStart","_codeProgress","_codeCompleted","_codeInterrupted","_duration","_removeCompleted"];

        //retype conditions from string to code
        private _condProgressCode = compile _condProgress;

        //play transition-in animation
        for "_i" from 0 to FRAME_MAX_IN do
        {
            sleep 0.05;

            //update icon
            [_target,_actionID,_titleCode,_iconIdle,TEXTURES_IN,_i,false,_keyName] call ZO_fnc_holdAction_showIcon;
        };

        //execute supplied 'on start' action code
        [_target,_caller,_actionID,_arguments] call _codeStart;

        //progress init
        private _frame = 0;
        private _timeStart = time;
        private _timeNextStep = time;
        private _stepDuration = _duration / FRAME_MAX_PROGRESS;

        //handle progress
        while {call _condProgressCode && {_frame < FRAME_MAX_PROGRESS}} do
        {
            _timeNextStep = _timeStart + (_frame * _stepDuration);

            waitUntil
            {
                time >= _timeNextStep || {(inputAction "Action" < 0.5 && {inputAction "ActionContext" < 0.5}) || {visibleMap || {!(call _condProgressCode)}}}
            };

            //exit if progression failed - key was released or condition was not fulfiled
            if (time < _timeNextStep) exitWith
            {
                /*
                ["[x] inputAction 'Action' : %1",inputAction "Action"] call bis_fnc_logFormat;
                ["[x] inputAction 'ActionContext' : %1",inputAction "ActionContext"] call bis_fnc_logFormat;
                ["[x] !(call _condProgressCode) : %1",!(call _condProgressCode)] call bis_fnc_logFormat;
                ["[x] visibleMap : %1",visibleMap] call bis_fnc_logFormat;
                */
            };

            //increment progress
            _frame = _frame + 1;

            //update icon
            [_target,_actionID,_titleCode,_iconProgress,TEXTURES_PROGRESS,_frame,false,_keyName] call ZO_fnc_holdAction_showIcon;

            //execute supplied 'on progress' action code
            [_target,_caller,_actionID,_arguments,_frame,FRAME_MAX_PROGRESS] call _codeProgress;
        };

        //execute supplied 'completed' action code
        if (_frame == FRAME_MAX_PROGRESS) then
        {
            sleep _stepDuration;

            if (_removeCompleted) then
            {
                _target removeAction _actionID;
            };

            [_target,_caller,_actionID,_arguments] call _codeCompleted;
        }
        else
        {
            [_target,_caller,_actionID,_arguments] call _codeInterrupted;
        };

        //reset the progress texture
        [_target,_actionID,_titleCode,_iconIdle,TEXTURES_PROGRESS,0,false,_keyName] call ZO_fnc_holdAction_showIcon;

        //enable player's action menu
        {inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];

        //reset 'running' flag
        bis_fnc_holdAction_running = false;
    };
};

//inject custom code to _condStart to allow for the idle animation
if (_iconIdle isEqualType "") then
{
    _condShow = format["_target = _originalTarget; _eval = %1; [%2,""%3"",""%4""] call ZO_fnc_holdAction_animationTimerCode; _eval",_condShow,_titleCode,_iconIdle,_hint];
}
else
{
    _condShow = format["_target = _originalTarget; _eval = %1; [%2,%3,""%4""] call ZO_fnc_holdAction_animationTimerCode; _eval",_condShow,_titleCode,_iconIdle,_hint];
};

//add the action
private _actionID = _target addAction [_title, _codeInit, _arguments, _priority, _showWindow, ACTION_HIDE_ON_USE, ACTION_SHORTCUT, _condShow, ACTION_DISTANCE, _showUnconscious, ""];

[_target, _actionID, _arguments] spawn {
    params
    [
        ["_target",objNull,[objNull]],
        ["_actionID",10,[123]],
        ["_arguments",[],[[]]]
    ];
    _arguments params["_a0","_a1","_a2","_a3","_a4","_a5","_a6","_a7","_a8","_a9","_target","_titleCode","_iconIdle","_iconProgress","_condShow","_condProgress","_codeStart","_codeProgress","_codeCompleted","_codeInterrupted","_duration","_removeCompleted"];
    private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
    private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];

    while {alive _target} do {
        waitUntil { _var = _target getVariable "updateAllHoldActions"; (!isNil "_var") && {_target getVariable "updateAllHoldActions"} };
        [_target,_actionID,_titleCode,_iconIdle,TEXTURES_PROGRESS,0,false,_keyName] call ZO_fnc_holdAction_showIcon;
        sleep 0.1;
        _target setVariable ["updateAllHoldActions", false, true];
    };
};

//set the initial state to frame 0
[_target,_actionID,_titleCode,_iconIdle,TEXTURES_IDLE,0,false,_keyName] call ZO_fnc_holdAction_showIcon;

_actionID
