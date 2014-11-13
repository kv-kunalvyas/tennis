load grid_events.mat

% SERVE/NO-Serve - Hit/No-Hit - Bounce/No-Bounce - Net/No-Net
% Left/No-Left - Right/No-Right 
% Near/No-Near - Far/No-Far 
% In/No-In - Out/No-Out
% Point/No-Point

new_grid = zeros(1,11);
for i=1:length(grid_events)
       
        % SERVE ***********************************************************
   if strcmp(grid_events(i,:),'SFL  ')||strcmp(grid_events(i,:),'SF   '), new_grid(i,:) = [1 0 0 0   1 0   0 1    0 0   0]; 
    elseif strcmp(grid_events(i,:),'SNL  ')||strcmp(grid_events(i,:),'SN   '), new_grid(i,:) = [1 0 0 0   1 0   1 0    0 0   0];
    
    elseif strcmp(grid_events(i,:),'SFR  '), new_grid(i,:) = [1 0 0 0   0 1   0 1    0 0   0];
    elseif strcmp(grid_events(i,:),'SNR  '), new_grid(i,:) = [1 0 0 0   0 1   1 0    0 0   0];
          
        % HIT **********FIX ME***************************************************
    elseif strcmp(grid_events(i,:),'HN   '), new_grid(i,:) = [0 1 0 0   0 0   1 0    0 0   0];
    elseif strcmp(grid_events(i,:),'HF   '), new_grid(i,:) = [0 1 0 0   0 0   0 1    0 0   0];
     
        % BOUNCE ********FIX ME**************************************************
    elseif strcmp(grid_events(i,:),'BINSL'), new_grid(i,:) = [1 0 1 0   1 0   1 0    1 0   0];
    elseif strcmp(grid_events(i,:),'BIFSL'), new_grid(i,:) = [1 0 1 0   1 0   0 1    1 0   0];
    elseif strcmp(grid_events(i,:),'BINSR'), new_grid(i,:) = [1 0 1 0   0 1   1 0    1 0   0];
    elseif strcmp(grid_events(i,:),'BIFSR'), new_grid(i,:) = [1 0 1 0   0 1   0 1    1 0   0];     
        
    elseif strcmp(grid_events(i,:),'BONS '), new_grid(i,:) = [1 0 1 0   0 0   1 0    0 1   0];
    elseif strcmp(grid_events(i,:),'BOFS '), new_grid(i,:) = [1 0 1 0   0 0   0 1    0 1   0];
        
    elseif strcmp(grid_events(i,:),'BIN  '), new_grid(i,:) = [0 0 1 0   0 0   1 0    1 0   0];
    elseif strcmp(grid_events(i,:),'BIF  '), new_grid(i,:) = [0 0 1 0   0 0   0 1    1 0   0];
    elseif strcmp(grid_events(i,:),'BON  '), new_grid(i,:) = [0 0 1 0   0 0   1 0    0 1   0];
    elseif strcmp(grid_events(i,:),'BOF  '), new_grid(i,:) = [0 0 1 0   0 0   0 1    0 1   0];
     
        % NET *****************FIX ME********************************************
     
    elseif strcmp(grid_events(i,:),'NET  '), new_grid(i,:) = [0 0 0 1   0 0   0 0    0 0   0];
    
   end    
    
end


events_lattice_ini=new_grid;
save events_lattice_ini.mat events_lattice_ini