function [Topology OSeq] = Build_master_topology(Seq,Size)

if nargin<2 %default car
    N='8'; %creates an 8X8 matrix
elseif Size==1 %1 for badminton
    N='10';
end

% Seq=Seq';
% Seq=Seq(:);
% Seq=Seq(~cellfun(@isempty,Seq));
% OSeq=Seq; 


OSeq=Seq;

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
% 9. PNr
% 10. PFr

switch lower(N)
    case{'8'}
    k=1;
    for i=1:length(Seq)
    if strcmp(Seq{i},'S')
        Seq_numbered(k) = 1; k=k+1;
    elseif strcmp(Seq{i},'TSt')
        Seq_numbered(k) = 2; k=k+1;
    elseif strcmp(Seq{i},'TLe')
        Seq_numbered(k) = 3; k=k+1;
    elseif strcmp(Seq{i},'TRi')
        Seq_numbered(k) = 4; k=k+1;
    elseif strcmp(Seq{i},'LR')
        Seq_numbered(k) = 5; k=k+1;
    elseif strcmp(Seq{i},'LA')
        Seq_numbered(k) = 6; k=k+1;
    elseif strcmp(Seq{i},'LG')
        Seq_numbered(k) = 7; k=k+1;
    elseif strcmp(Seq{i},'SiLL')
        Seq_numbered(k) = 8; k=k+1;
    elseif strcmp(Seq{i},'SiRR')
        Seq_numbered(k) = 9; k=k+1;
    elseif strcmp(Seq{i},'Sp')
        Seq_numbered(k) = 10; k=k+1;
    end
end



Topology_Sparsed = zeros(10,10);
Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
S = size(Sparsed_TM);
Sparsed_TM(S(1)+1:10,S(2)+1:10)=0;
Topology=mat2tmat(Sparsed_TM); %Topology without point allocation

    case{'10'}
k=1;
    for i=1:length(Seq)
    if strcmp(Seq{i},'SF')
        Seq_numbered(k) = 1; k=k+1;
    elseif strcmp(Seq{i},'SN')
        Seq_numbered(k) = 2; k=k+1;
    elseif strcmp(Seq{i},'HF')
        Seq_numbered(k) = 3; k=k+1;
    elseif strcmp(Seq{i},'HN')
        Seq_numbered(k) = 4; k=k+1;
    elseif strcmp(Seq{i},'BIN')
        Seq_numbered(k) = 5; k=k+1;
    elseif strcmp(Seq{i},'BIF')
        Seq_numbered(k) = 6; k=k+1;
    elseif strcmp(Seq{i},'BON')
        Seq_numbered(k) = 7; k=k+1;
    elseif strcmp(Seq{i},'BOF')
        Seq_numbered(k) = 8; k=k+1;
    end
end



Topology_Sparsed = zeros(8,8);
Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
S = size(Sparsed_TM);
Sparsed_TM(S(1)+1:8,S(2)+1:8)=0;
Topology=mat2tmat(Sparsed_TM); %Topology without point allocation  
    
end   


%save master_topology.mat Master_Topology_Shrinked
%imagesc(mat2tmat(Master_Topology_Shrinked))