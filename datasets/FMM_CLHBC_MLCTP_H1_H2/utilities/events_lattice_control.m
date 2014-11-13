load events_lattice_ini.mat

% 11 types of sub-components
% first 4: S H B N || next 2: L R || next 2: N F || next 2: I O || next: Point

% Usage []

usage = [1 0 1 0 0];

usage_act = [usage(1)+zeros(1,4) usage(2)+zeros(1,2) usage(3)+zeros(1,2)...
    usage(4)+zeros(1,2) usage(5)+zeros(1,1)];

usage_act = repmat(usage_act,676,1);
lattice = usage_act.*events_lattice_init;

