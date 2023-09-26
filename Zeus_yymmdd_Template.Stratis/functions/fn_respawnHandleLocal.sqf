/*
    @file_name: fn_respawnHandleLocal.sqf
    @file_author: Dyzalonius
*/

////////////////////////////////////////////////
//               SUB-FUNCTIONS                //
////////////////////////////////////////////////

fn_notification = {
    _waveMinutes = ceil((missionNameSpace getVariable "respawnNextWaveTime")/60);
    _autoMinutes = ceil(playerRespawnTime/60);
    switch (_this) do {
        // waiting for bodybag or respawn /minute
        case "bodybagwait": {
            if (playerRespawnTime % 60 == 0) then {
                if (missionNameSpace getVariable "respawnAllow") then {
                    (format["<t font='PuristaBold' size='1.6'>You are dead.</t><br />Respawning with the next wave in %1 minutes, if body bagged.<br />Auto respawn in %2 minutes.", _waveMinutes, _autoMinutes]) spawn fn_text;
                } else {
                    ("<t font='PuristaBold' size='1.6'>You are dead.</t><br />Respawning with the next wave, if body bagged.<br />Auto respawn disabled.") spawn fn_text;
                };
            };
        };

        // waiting for wave or respawn
        case "bodybagged": {
            if (missionNameSpace getVariable "respawnAllow") then {
                (format["<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave in %1 minutes.<br />Auto respawn in %2 minutes.", _waveMinutes, _autoMinutes]) spawn fn_text;
            } else {
                ("<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave.<br />Auto respawn disabled.") spawn fn_text;
            };
        };

        // waiting for wave or respawn /minute
        case "wavewait": {
            if (playerRespawnTime % 60 == 0) then {
                if (missionNameSpace getVariable "respawnAllow") then {
                    (format["<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave in %1 minutes.<br />Auto respawn in %2 minutes.", _waveMinutes, _autoMinutes]) spawn fn_text;
                } else {
                    ("<t font='PuristaBold' size='1.6'>You are body bagged.</t><br />Respawning with the next wave.<br />Auto respawn disabled.") spawn fn_text;
                };
            };
        };

        // respawn with wave
        case "waverespawn": {
            ("A respawn wave has been triggered<br /><t font='PuristaBold' size='1.6'>You will respawn in 5 seconds.</t>") spawn fn_text;
        };

        // respawn automatically
        case "autorespawn": {
            ("Respawning automatically<br /><t font='PuristaBold' size='1.6'>You will respawn in 5 seconds.</t>") spawn fn_text;
        };
    };
};

fn_text = {
    [
        parseText _this,
        [0.65 * (safeZoneW + safeZoneX),
        0.8 * safeZoneY,
        0.6, 0.2
    ], nil, 5, 0.5, 0] spawn BIS_fnc_textTiles;
};

fn_notify_assets = {
    // Get all assets and notify
    private _assets = [];
    {
        if ((groupId _x) in (missionNameSpace getVariable "respawnMessageGroups")) then {
            _assets append (units _x);
        };
    } foreach allGroups;
    [0, ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t shadowColor='#444444'>A player respawned</t>", "PLAIN", 0.2, true, true]] remoteExec ["cutText", _assets];
};

////////////////////////////////////////////////
//               FUNCTION LOOP                //
////////////////////////////////////////////////

scopeName "main";

// Reset respawn timer
if (missionNameSpace getVariable "respawnAllow") then {
    setPlayerRespawnTime (missionNameSpace getVariable "respawnTime");
} else {
    setPlayerRespawnTime (missionNameSpace getVariable "respawnTimeInfinite");
};

// waiting for death
waitUntil {!alive player;};

// waiting for bodybag or respawn
while {true} do {
    _autoBodybagTeams = missionNameSpace getVariable "autoBodybagTeams";
    if (((player distance2D [-5000,-5000]) < 7100) || (alive player) || ((groupId (group player)) in _autoBodybagTeams)) then {
        breakTo "main";
    };
    // Respawning automatically -> show notification and exit
    if (playerRespawnTime <= 5) then {
        "autorespawn" spawn fn_notification;
        sleep 6;

        [] spawn fn_notify_assets;
        breakTo "main";
    };

    "bodybagwait" spawn fn_notification;
    sleep 1;
};

// if not respawn notify bodybagged
if (!alive player) then {
    "bodybagged" spawn fn_notification;
};

// waiting for wave or respawn
while {true} do {
    if (((!isNil "respawnWave") && (missionNameSpace getVariable "respawnWave")) || (alive player)) then {
        breakTo "main";
    };

    "wavewait" spawn fn_notification;
    sleep 1;
};

// respawn
if (!alive player) then {
    "waverespawn" spawn fn_notification;
    setPlayerRespawnTime 4;
    sleep 5;

    // Get all assets and notify
    [] spawn fn_notify_assets;

};

// restart
[] spawn ZO_fnc_respawnHandleLocal;
