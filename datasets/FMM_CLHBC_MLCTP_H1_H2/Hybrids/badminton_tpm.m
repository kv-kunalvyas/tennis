
load grid_events.mat
gridb=cellstr(corrected_grid_events);
badminton_pmF = zeros(4,4);
badminton_pmN = zeros(4,4);

for i=1:length(gridb)
    if (strcmp(gridb(i,1),'SFL') || strcmp(gridb(i,1),'SF')) && strcmp(gridb(i+1,1),'HN')
        badminton_pmF(1,2)=badminton_pmF(1,2)+1;
        
    elseif strcmp(gridb(i,1),'HN') && strcmp(gridb(i+1,1),'HF')
        badminton_pmF(2,3)=badminton_pmF(2,3)+1;
        
    elseif strcmp(gridb(i,1),'HF') && strcmp(gridb(i+1,1),'HN')
        badminton_pmF(3,2)=badminton_pmF(3,2)+1;
    
    elseif strcmp(gridb(i,1),'HF') && (strcmp(gridb(i+1,1),'BIN') || strcmp(gridb(i+1,1),'BIF') || ...
            strcmp(gridb(i+1,1),'BON')|| strcmp(gridb(i+1,1),'BOF'))
        badminton_pmF(3,4)=badminton_pmF(3,4)+1;

    elseif strcmp(gridb(i,1),'HN') && (strcmp(gridb(i+1,1),'BIN') || strcmp(gridb(i+1,1),'BIF') || ...
            strcmp(gridb(i+1,1),'BON')|| strcmp(gridb(i+1,1),'BOF'))
        badminton_pmF(2,4)=badminton_pmF(2,4)+1;
        
    end
end


for i=1:length(gridb)
    if (strcmp(gridb(i,1),'SNL') || strcmp(gridb(i,1),'SN')) && strcmp(gridb(i+1,1),'HF')
        badminton_pmN(1,2)=badminton_pmN(1,2)+1;
        
    elseif strcmp(gridb(i,1),'HF') && strcmp(gridb(i+1,1),'HN')
        badminton_pmN(2,3)=badminton_pmN(2,3)+1;
        
    elseif strcmp(gridb(i,1),'HN') && strcmp(gridb(i+1,1),'HF')
        badminton_pmN(3,2)=badminton_pmN(3,2)+1;
    
    elseif strcmp(gridb(i,1),'HF') && (strcmp(gridb(i+1,1),'BIN') || strcmp(gridb(i+1,1),'BIF') || ...
            strcmp(gridb(i+1,1),'BON')|| strcmp(gridb(i+1,1),'BOF'))
        badminton_pmN(2,4)=badminton_pmN(2,4)+1;

    elseif strcmp(gridb(i,1),'HN') && (strcmp(gridb(i+1,1),'BIN') || strcmp(gridb(i+1,1),'BIF') || ...
            strcmp(gridb(i+1,1),'BON')|| strcmp(gridb(i+1,1),'BOF'))
        badminton_pmN(3,4)=badminton_pmN(3,4)+1;
        
    end
end