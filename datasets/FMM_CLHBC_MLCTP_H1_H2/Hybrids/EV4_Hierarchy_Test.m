function [LH TMatrix] = EV4_Hierarchy_Test(NuM) %number of training sequences

Vocabulary=main('nswitched');

Vocabulary = fix_annotation_errors(Vocabulary);
k=1;
PS={'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''};
for i=1:length(Vocabulary)
    if strcmp(Vocabulary{i,1},'SF')
        PS(i,:) = cellfun(@(v) ['SF.' v ], Vocabulary(i,:), 'Uniform', 0);
    elseif strcmp(Vocabulary{i,1},'SN')
        PS(i,:) = cellfun(@(v) ['SN.' v ], Vocabulary(i,:), 'Uniform', 0);
        
    end
end
Vocabulary=PS;



%Train_Seq=Vocabulary(1:NuM,:);
Train_Seq=Vocabulary(NuM:end,:); %for test
Test_Seq=Vocabulary(NuM+1:end,:);

Train_Seq=Train_Seq';
Test_Seq=Test_Seq';
Train_Seq=Train_Seq(:);
Test_Seq=Test_Seq(:);
Train_Seq=Train_Seq(~cellfun(@isempty,Train_Seq));
Test_Seq=Test_Seq(~cellfun(@isempty,Test_Seq));

k=1;
for i=1:length(Train_Seq)
    if strcmp(Train_Seq{i},'SF.')
        ind(k)=i;
        k=k+1;
    elseif strcmp(Train_Seq{i},'SN.')
        ind(k)=i;
        k=k+1;
    end
end

Train_Seq(ind)=[];

clear ind
k=1;
for i=1:length(Test_Seq)
    if strcmp(Test_Seq{i},'SF.')
        ind(k)=i;
        k=k+1;
    elseif strcmp(Test_Seq{i},'SN.')
        ind(k)=i;
        k=k+1;
    end
end

Test_Seq(ind)=[];

clear Vocabulary

Vocabulary = Train_Seq;









pshot = Vocabulary;
[~, idx]= unique(pshot,'first');
idx=sort(idx);
    
playshots=pshot(idx(1:end));

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
    
        if strcmp(uniq_playshot{i},'SF.SF')
            
            Attribute{i,k}.G_state = 'Start';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Serve';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
        elseif strcmp(uniq_playshot{i},'SN.SN')
            
            Attribute{i,k}.G_state = 'Start';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Serve';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.HN')
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Near';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.HF')
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Far';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.HN')
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Near';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
            
        elseif strcmp(uniq_playshot{i},'SF.HF')
            
            Attribute{i,k}.G_state = 'Rally';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'Hit';
            Attribute{i,k}.Location1 = 'Far';
            Attribute{i,k}.Location2 = '';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
       % BOUNCE    SF
        elseif strcmp(uniq_playshot{i},'SF.BIN')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIN';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BIF')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BON')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BON';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BOF')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BOF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BINSL')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BINSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BIFSL')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIFSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BINSR')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BINSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BIFSR')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BIFSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;    
        elseif strcmp(uniq_playshot{i},'SF.BONS')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BONS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SF.BOFS')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SF';
            Attribute{i,k}.Shot_type = 'BOFS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
      
        % BOUNCE  SN    
        elseif strcmp(uniq_playshot{i},'SN.BIN')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIN';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BIF')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BON')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BON';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BOF')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BOF';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BINSL')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BINSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BIFSL')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIFSL';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BINSR')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BINSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BIFSR')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BIFSR';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'I';
            Attribute{i,k}.Characteristic = '';
            k=k+1;    
        elseif strcmp(uniq_playshot{i},'SN.BONS')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BONS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        elseif strcmp(uniq_playshot{i},'SN.BOFS')
            
            Attribute{i,k}.G_state = 'End';
            Attribute{i,k}.PS_type = 'SN';
            Attribute{i,k}.Shot_type = 'BOFS';
            Attribute{i,k}.Location1 = '';
            Attribute{i,k}.Location2 = 'O';
            Attribute{i,k}.Characteristic = '';
            k=k+1;
            
        end
    
end

%Serve Level


  for i=1:length(uniq_playshot) 
        Game_Level{i}=Attribute{i}.G_state;
        Serve_Level{i}=Attribute{i}.PS_type;
        Event_Level{i}=Attribute{i}.Shot_type;
        Location_Level{i}=Attribute{i}.Location1;
  end



    
    [~, idx] = unique(Game_Level,'first');
    idxG=sort(idx);
    G1=Game_Level(idxG);
    
    
    [~, idx] = unique(Serve_Level,'first');
    idxS=sort(idx);
    S1=Serve_Level(idxS);
    
    
    [~, idx] = unique(Event_Level,'first');
    idxE=sort(idx);
    E1=Event_Level(idxE);
    
    
    [CC, idx] = unique(Location_Level,'first');
    idxL=sort(idx);
    L1=Location_Level(idxL);
    
    
    %Transition matrices at each level
    
    LL = char(Train_Seq);
    Seq2 = LL(:,1:2); % Level 2 sequence
    TMat2 = zeros(2,2);
    for i=1:length(Seq2)-1
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            TMat2(1,1) = TMat2(1,1)+1;
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            TMat2(1,2) = TMat2(1,2)+1;
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            TMat2(2,1) = TMat2(2,1)+1;    
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            TMat2(2,2) = TMat2(2,2)+1;    
            
        end
    end
    
    TMat2 = mat2tmat(TMat2);
    
    %%


Vocabulary=main('nswitched');

Vocabulary = fix_annotation_errors(Vocabulary);


%TrSeq=Vocabulary(1:NuM,:); %FOR THE 2nd Bit
TrSeq=Vocabulary(NuM:end,:); %FOR THE 2nd Bit
TeSeq=Vocabulary(NuM+1:end,:); %FOR THE 2nd Bit
Seq=TrSeq;  %TrSeq for Training and TeSeq for Test
Seq=Seq';
Seq=Seq(:);
Seq=Seq(~cellfun(@isempty,Seq));

Master_Topology_Shrinked = zeros(8,8);
 
% 1. SF
% 2. SN
% 
% 3. HF
% 4. HN
% 
% 5. BIN
% 6. BIF
% 7. BON
% 8. BOF

for i=1:length(Seq)-1
    
    if strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HF')
        Master_Topology_Shrinked(1,3)=Master_Topology_Shrinked(1,3)+1;
        
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HN')
        Master_Topology_Shrinked(1,4)=Master_Topology_Shrinked(1,4)+1;
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HF')
        Master_Topology_Shrinked(2,3)=Master_Topology_Shrinked(2,3)+1;
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HN')
        Master_Topology_Shrinked(2,4)=Master_Topology_Shrinked(2,4)+1;
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'HN')
        Master_Topology_Shrinked(3,4)=Master_Topology_Shrinked(3,4)+1;
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'HF')
        Master_Topology_Shrinked(4,3)=Master_Topology_Shrinked(4,3)+1;
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIN')
        Master_Topology_Shrinked(4,5)=Master_Topology_Shrinked(4,5)+1;
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIF')
        Master_Topology_Shrinked(4,6)=Master_Topology_Shrinked(4,6)+1;
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BON')
        Master_Topology_Shrinked(4,7)=Master_Topology_Shrinked(4,7)+1;
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BOF')
        Master_Topology_Shrinked(4,8)=Master_Topology_Shrinked(4,8)+1;
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIN')
        Master_Topology_Shrinked(3,5)=Master_Topology_Shrinked(3,5)+1;
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIF')
        Master_Topology_Shrinked(3,6)=Master_Topology_Shrinked(3,6)+1;
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BON')
        Master_Topology_Shrinked(3,7)=Master_Topology_Shrinked(3,7)+1;
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BOF')
        Master_Topology_Shrinked(3,8)=Master_Topology_Shrinked(3,8)+1;
        
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SN')
        Master_Topology_Shrinked(5,2)=Master_Topology_Shrinked(5,2)+1;
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SN')
        Master_Topology_Shrinked(6,2)=Master_Topology_Shrinked(6,2)+1;
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SN')
        Master_Topology_Shrinked(7,2)=Master_Topology_Shrinked(7,2)+1;
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SN')    
        Master_Topology_Shrinked(8,2)=Master_Topology_Shrinked(8,2)+1;
    
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SF')
        Master_Topology_Shrinked(5,1)=Master_Topology_Shrinked(5,1)+1;
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SF')
        Master_Topology_Shrinked(6,1)=Master_Topology_Shrinked(6,1)+1;
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SF')
        Master_Topology_Shrinked(7,1)=Master_Topology_Shrinked(7,1)+1;
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SF')
        Master_Topology_Shrinked(8,1)=Master_Topology_Shrinked(8,1)+1;
    end
end

Master_Topology_Shrinked=mat2tmat(Master_Topology_Shrinked);

%save master_topology.mat Master_Topology_Shrinked
%imagesc(mat2tmat(Master_Topology_Shrinked))

Topology_Layer3 = Master_Topology_Shrinked;
Topology_Layer2 = TMat2;
New_Topology = zeros(8,8);
for i=1:length(Seq)-1
    
    if strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(1,3)=Master_Topology_Shrinked(1,3)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(1,3)=Master_Topology_Shrinked(1,3)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(1,3)=Master_Topology_Shrinked(1,3)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(1,3)=Master_Topology_Shrinked(1,3)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(1,4)=Master_Topology_Shrinked(1,4)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(1,4)=Master_Topology_Shrinked(1,4)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(1,4)=Master_Topology_Shrinked(1,4)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(1,4)=Master_Topology_Shrinked(1,4)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(2,3)=Master_Topology_Shrinked(2,3)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(2,3)=Master_Topology_Shrinked(2,3)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(2,3)=Master_Topology_Shrinked(2,3)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(2,3)=Master_Topology_Shrinked(2,3)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(2,4)=Master_Topology_Shrinked(2,4)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(2,4)=Master_Topology_Shrinked(2,4)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(2,4)=Master_Topology_Shrinked(2,4)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(2,4)=Master_Topology_Shrinked(2,4)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,4)=Master_Topology_Shrinked(3,4)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,4)=Master_Topology_Shrinked(3,4)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,4)=Master_Topology_Shrinked(3,4)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,4)=Master_Topology_Shrinked(3,4)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,3)=Master_Topology_Shrinked(4,3)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,3)=Master_Topology_Shrinked(4,3)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,3)=Master_Topology_Shrinked(4,3)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,3)=Master_Topology_Shrinked(4,3)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,5)=Master_Topology_Shrinked(4,5)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,5)=Master_Topology_Shrinked(4,5)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,5)=Master_Topology_Shrinked(4,5)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,5)=Master_Topology_Shrinked(4,5)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,6)=Master_Topology_Shrinked(4,6)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,6)=Master_Topology_Shrinked(4,6)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,6)=Master_Topology_Shrinked(4,6)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,6)=Master_Topology_Shrinked(4,6)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BON')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,7)=Master_Topology_Shrinked(4,7)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,7)=Master_Topology_Shrinked(4,7)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,7)=Master_Topology_Shrinked(4,7)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,7)=Master_Topology_Shrinked(4,7)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BOF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,8)=Master_Topology_Shrinked(4,8)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,8)=Master_Topology_Shrinked(4,8)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(4,8)=Master_Topology_Shrinked(4,8)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(4,8)=Master_Topology_Shrinked(4,8)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,5)=Master_Topology_Shrinked(3,5)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,5)=Master_Topology_Shrinked(3,5)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,5)=Master_Topology_Shrinked(3,5)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,5)=Master_Topology_Shrinked(3,5)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIF')
                if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,6)=Master_Topology_Shrinked(3,6)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,6)=Master_Topology_Shrinked(3,6)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,6)=Master_Topology_Shrinked(3,6)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,6)=Master_Topology_Shrinked(3,6)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BON')
                if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,7)=Master_Topology_Shrinked(3,7)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,7)=Master_Topology_Shrinked(3,7)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,7)=Master_Topology_Shrinked(3,7)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,7)=Master_Topology_Shrinked(3,7)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BOF')
                if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,8)=Master_Topology_Shrinked(3,8)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,8)=Master_Topology_Shrinked(3,8)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(3,8)=Master_Topology_Shrinked(3,8)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(3,8)=Master_Topology_Shrinked(3,8)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(5,2)=Master_Topology_Shrinked(5,2)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(5,2)=Master_Topology_Shrinked(5,2)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(5,2)=Master_Topology_Shrinked(5,2)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(5,2)=Master_Topology_Shrinked(5,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(6,2)=Master_Topology_Shrinked(6,2)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(6,2)=Master_Topology_Shrinked(6,2)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(6,2)=Master_Topology_Shrinked(6,2)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(6,2)=Master_Topology_Shrinked(6,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(7,2)=Master_Topology_Shrinked(7,2)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(7,2)=Master_Topology_Shrinked(7,2)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(7,2)=Master_Topology_Shrinked(7,2)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(7,2)=Master_Topology_Shrinked(7,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SN')    
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(8,2)=Master_Topology_Shrinked(8,2)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(8,2)=Master_Topology_Shrinked(8,2)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(8,2)=Master_Topology_Shrinked(8,2)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(8,2)=Master_Topology_Shrinked(8,2)*TMat2(2,2);
        end
    
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(5,1)=Master_Topology_Shrinked(5,1)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(5,1)=Master_Topology_Shrinked(5,1)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(5,1)=Master_Topology_Shrinked(5,1)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(5,1)=Master_Topology_Shrinked(5,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(6,1)=Master_Topology_Shrinked(6,1)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(6,1)=Master_Topology_Shrinked(6,1)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(6,1)=Master_Topology_Shrinked(6,1)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(6,1)=Master_Topology_Shrinked(6,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(7,1)=Master_Topology_Shrinked(7,1)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(7,1)=Master_Topology_Shrinked(7,1)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(7,1)=Master_Topology_Shrinked(7,1)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(7,1)=Master_Topology_Shrinked(7,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(8,1)=Master_Topology_Shrinked(8,1)*TMat2(1,1);
        elseif strcmp(Seq2(i,:),'SF') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(8,1)=Master_Topology_Shrinked(8,1)*TMat2(1,2);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SF')
            New_Topology(8,1)=Master_Topology_Shrinked(8,1)*TMat2(2,1);
        elseif strcmp(Seq2(i,:),'SN') && strcmp(Seq2(i+1,:),'SN')
            New_Topology(8,1)=Master_Topology_Shrinked(8,1)*TMat2(2,2);
        end
    end
end

    
 %new topology has the hierarchial input to it
    
    
 LH = log(prod(New_Topology(New_Topology>0)));
 TMatrix = New_Topology;   
    
    
    
    
    
    
    
    
