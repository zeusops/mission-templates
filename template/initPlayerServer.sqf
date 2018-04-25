{
	if (!isnull (getassignedcuratorunit _x)) then {
		private _unit = getassignedcuratorunit _x;
		if (isnull (getassignedcuratorlogic _unit)) then {
			unassignCurator _x;
			sleep 1;
			_unit assignCurator _x;
		};
	};
} foreach allcurators;