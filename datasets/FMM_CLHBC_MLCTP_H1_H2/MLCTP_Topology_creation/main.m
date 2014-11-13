function [Vocabulary1 Vocabulary2] = main %'switched'

load grid_events_tennis

A = cellstr(grid_events);
B = strfind(A,'NET');
B(cellfun(@isempty,B))={0};
B=cell2mat(B);
ind=find(B==1);
A(ind)=[];





corrected_grid_events=char(A);
clear A B ind     
maxShotsize=50;                                                             %29 for BadmintonCzechGB

Vocabulary1 = buildVocabulary(corrected_grid_events, maxShotsize);

load grid_events_tennis2
A = cellstr(grid_events);
B = strfind(A,'NET');
B(cellfun(@isempty,B))={0};
B=cell2mat(B);
ind=find(B==1);
A(ind)=[];
    
corrected_grid_events=char(A);
    
maxShotsize=50;                                                             %29 for BadmintonCzechGB

Vocabulary2 = buildVocabulary(corrected_grid_events, maxShotsize);
clear A B ind     