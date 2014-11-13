Vocabulary = main;

k=1;
load indices_for_shots5
Vocabulary=Vocabulary(indices,:);
%Vocabulary=Vocabulary(1:end/2,:); %for Train
Vocabulary=Vocabulary(end/2:end,:); %for Test
 
for i=1:length(Vocabulary)
    pshot = Vocabulary(i,:);
    [~, idx]= unique(pshot,'first');
    idx=sort(idx);
    
    playshots{k}=pshot(idx(1:end-1));
    k=k+1;
    clear pshot
    
end

A=playshots';

ii = 1;
while ii<size(A,1)
    tf = true(size(A,1),1);
    for jj = ii:size(A,1)
        if isequal(A(ii,:),A(jj,:)) && ii~=jj
            tf(jj) = 0;
        end
    end
    A = A(tf,:);
    ii = ii + 1;
end

uniq_playshot=A(1:end,:);

%appending each event with SN. and SF.

for i=1:length(uniq_playshot)
    if strcmp(uniq_playshot{i,1}(1),'SF') || strcmp(uniq_playshot{i,1}(1),'SFR') || strcmp(uniq_playshot{i,1}(1),'SFL')
        PS{i} = cellfun(@(v) ['SF.' v ], uniq_playshot{i}, 'Uniform', 0);
    elseif strcmp(uniq_playshot{i,1}(1),'SN') || strcmp(uniq_playshot{i,1}(1),'SNR') || strcmp(uniq_playshot{i,1}(1),'SNL')
        PS{i} = cellfun(@(v) ['SN.' v ], uniq_playshot{i}, 'Uniform', 0);
        
    end
end

for i=1:length(PS)
    
    for j=1:length(PS{i})-1
        
        TT = char(PS{i});
        [C, idx]= unique(TT(:,1:4),'rows','first');
        idx=sort(idx);
        
        new{i}=TT(idx,1:4);
        
    end
end


for i=1:length(uniq_playshot)
    k=1;
    for j=1:length(uniq_playshot{i})
        
        if strcmp(uniq_playshot{i}(j),'SF') || strcmp(uniq_playshot{i}(j),'SFR') || strcmp(uniq_playshot{i}(j),'SFL')
            
            Attribute{i,k}.G_state = 'Start';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Serve';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
        elseif strcmp(uniq_playshot{i}(j),'SN') || strcmp(uniq_playshot{i}(j),'SNR') || strcmp(uniq_playshot{i}(j),'SNL')
            
            Attribute{i,k}.G_state = 'Start';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Serve';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'HN') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Near';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'HF') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Far';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'HN') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Near';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
            
        elseif strcmp(uniq_playshot{i}(j),'HF') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Far';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
       % BOUNCE    SF
        elseif strcmp(uniq_playshot{i}(j),'BIN') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIN';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIF') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BON') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BON';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BOF') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BOF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BINSL') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BINSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIFSL') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIFSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BINSR') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BINSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIFSR') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIFSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;    
        elseif strcmp(uniq_playshot{i}(j),'BONS') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BONS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BOFS') && (strcmp(uniq_playshot{i}(1),'SF') || strcmp(uniq_playshot{i}(1),'SFR') || strcmp(uniq_playshot{i}(1),'SFL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BOFS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
      
        % BOUNCE  SN    
        elseif strcmp(uniq_playshot{i}(j),'BIN') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIN';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIF') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BON') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BON';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BOF') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BOF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BINSL') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BINSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIFSL') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIFSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BINSR') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BINSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BIFSR') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIFSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;    
        elseif strcmp(uniq_playshot{i}(j),'BONS') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BONS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i}(j),'BOFS') && (strcmp(uniq_playshot{i}(1),'SN') || strcmp(uniq_playshot{i}(1),'SNR') || strcmp(uniq_playshot{i}(1),'SNL'))
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BOFS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        end
    end
end

%Serve Level

for i=1:length(uniq_playshot)
    for j=1:length(uniq_playshot{i})
        Game_Level{i,j}=Attribute{i,j}.G_state;
        Serve_Level{i,j}=Attribute{i,j}.PS_type;
        Event_Level{i,j}=Attribute{i,j}.Shot_type;
        Location_Level{i,j}=Attribute{i,j}.Location1;
    end
end


for i=1:length(uniq_playshot)
    j=length(uniq_playshot{i});
    
    [~, idx] = unique(Game_Level(i,1:j),'first');
    idxG{i}=sort(idx);
    G1{i}=Game_Level(i,idxG{i});
    
    
    [~, idx] = unique(Serve_Level(i,1:j),'first');
    idxS{i}=sort(idx);
    S1{i}=Serve_Level(i,idxS{i});
    
    
    [~, idx] = unique(Event_Level(i,1:j),'first');
    idxE{i}=sort(idx);
    E1{i}=Event_Level(i,idxE{i});
    
    
    [CC, idx] = unique(Location_Level(i,1:j),'first');
    idxL{i}=sort(idx);
    L1{i}=Location_Level(i,idxL{i});
    
end




TP{1} = zeros(3,5);
TP{2} = zeros(3,5);
TP{3} = zeros(3,5);

for i=1:8
    
    if length(S1{i}(~cellfun(@isempty, S1{i}))) == 1; TP{i}(1,3) = 1; end
    if length(S1{i}(~cellfun(@isempty, S1{i}))) == 2; TP{i}(1,2) = 1; TP{i}(1,4) = 1; end
    if length(S1{i}(~cellfun(@isempty, S1{i}))) == 3; TP{i}(1,1) = 1; TP{i}(1,3) = 1; TP{i}(1,5) = 1; end
    
    if length(E1{i}(~cellfun(@isempty, E1{i}))) == 1; TP{i}(2,3) = 2; end
    if length(E1{i}(~cellfun(@isempty, E1{i}))) == 2; TP{i}(2,2) = 2; TP{i}(2,4) = 2; end
    if length(E1{i}(~cellfun(@isempty, E1{i}))) == 3; TP{i}(2,1) = 2; TP{i}(2,3) = 2; TP{i}(2,5) = 2; end
    
    if length(L1{i}(~cellfun(@isempty, L1{i}))) == 1; TP{i}(3,3) = 3; end
    if length(L1{i}(~cellfun(@isempty, L1{i}))) == 2; TP{i}(3,2) = 3; TP{i}(3,4) = 3; end
    if length(L1{i}(~cellfun(@isempty, L1{i}))) == 3; TP{i}(3,1) = 3; TP{i}(3,3) = 3; TP{i}(3,5) = 3; end
    
end

figure
for i=1:8
    
    subplot(3,3,i)
    imagesc(TP{i})
    hold on
    
    
    
    SSS=S1{i}(~cellfun(@isempty, S1{i}));
    if length(SSS) == 1; text(3-0.25,1,SSS(1)); end
    if length(SSS) == 2; text(2-0.25,1,SSS(1)); text(4-0.25,1,SSS(2)); end
    if length(SSS) == 3; text(1-0.25,1,SSS(1)); text(3-0.25,1,SSS(2)); text(5-0.25,1,SSS(3)); end
    
    EEE=E1{i}(~cellfun(@isempty, E1{i}));
    if length(EEE) == 1; text(3-0.25,2,EEE(1)); end
    if length(EEE) == 2; text(2-0.25,2,EEE(1)); text(4-0.25,2,EEE(2)); end
    if length(EEE) == 3; text(1-0.25,2,EEE(1)); text(3-0.25,2,EEE(2)); text(5-0.25,2,EEE(3)); end
    
    LLL=L1{i}(~cellfun(@isempty, L1{i}));
    if length(LLL) == 1; text(3-0.25,3,LLL(1)); end
    if length(LLL) == 2; text(2-0.25,3,LLL(1)); text(4-0.25,3,LLL(2)); end
    if length(LLL) == 3; text(1-0.25,3,LLL(1)); text(3-0.25,3,LLL(2)); text(5-0.25,3,LLL(3)); end
end



a = colormap(hot);
b = a(end:-1:20,:);
colormap(b)




for i=1:8
    k=0;
    for j=1:length(Vocabulary)
        if isequal(length(A{i}),length(playshots{j})), 
            if mean(strcmp(A{i},playshots{j}))==1
                Count{i}=k+1;
                association(j)=i;               
                k=k+1; 
            end, 
        end
    end
end


for i=1:8
    subplot(3,3,i)
    title(Count{i})
end


















