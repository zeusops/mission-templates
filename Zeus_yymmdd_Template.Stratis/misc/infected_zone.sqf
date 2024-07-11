

["ColorCorrections", 1500, [.65, 1, 0, [0, .15, 0, .3], [.1, 1,.1, 1], [0, 0, 0, 0]]] spawn { params ["_name", "_priority", "_effect", "_handle"]; while { _handle = ppEffectCreate [_name, _priority]; _handle < 0 } do { _priority = _priority + 1; }; _handle ppEffectEnable true; _handle ppEffectAdjust _effect; _handle ppEffectCommit 5; waitUntil {ppEffectCommitted _handle}; };