function [Topology ] = Build_master_topology_MSN(Seq,Size)

if nargin<2
    N='8'; %creates an 8X8 matrix
elseif Size==10
    N='10';
end


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
            if strcmp(Seq{i},' 1'), Seq_numbered(k) = 1; k=k+1;
            elseif strcmp(Seq{i},' 2'), Seq_numbered(k) = 2; k=k+1;
            elseif strcmp(Seq{i},' 3'), Seq_numbered(k) = 3; k=k+1;
            elseif strcmp(Seq{i},' 4'), Seq_numbered(k) = 4; k=k+1;
            elseif strcmp(Seq{i},' 5'), Seq_numbered(k) = 5; k=k+1;
            elseif strcmp(Seq{i},' 6'), Seq_numbered(k) = 6; k=k+1;
            elseif strcmp(Seq{i},' 7'), Seq_numbered(k) = 7; k=k+1;
            elseif strcmp(Seq{i},' 8'), Seq_numbered(k) = 8; k=k+1;
            elseif strcmp(Seq{i},' 9'), Seq_numbered(k) = 9; k=k+1;
            elseif strcmp(Seq{i},'10'), Seq_numbered(k) = 10; k=k+1;
            elseif strcmp(Seq{i},'11'), Seq_numbered(k) = 11; k=k+1;
            elseif strcmp(Seq{i},'12'), Seq_numbered(k) = 12; k=k+1;
            elseif strcmp(Seq{i},'13'), Seq_numbered(k) = 13; k=k+1;
            elseif strcmp(Seq{i},'14'), Seq_numbered(k) = 14; k=k+1;
            elseif strcmp(Seq{i},'15'), Seq_numbered(k) = 15; k=k+1;
            elseif strcmp(Seq{i},'16'), Seq_numbered(k) = 16; k=k+1;   
            elseif strcmp(Seq{i},'17'), Seq_numbered(k) = 17; k=k+1;   
            end
        end



Topology_Sparsed = zeros(17,17);
Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
S = size(Sparsed_TM);
Sparsed_TM(S(1)+1:17,S(2)+1:17)=0;
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
        Seq_numbered(k:k+1) = [5 10]; k=k+2;
    elseif strcmp(Seq{i},'BIF')
        Seq_numbered(k:k+1) = [6 9]; k=k+2;
    elseif strcmp(Seq{i},'BON')
        Seq_numbered(k:k+1) = [7 9]; k=k+2;
    elseif strcmp(Seq{i},'BOF')
        Seq_numbered(k:k+1) = [8 10]; k=k+2;
    end
end



Topology_Sparsed = zeros(10,10);
Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
S = size(Sparsed_TM);
Sparsed_TM(S(1)+1:10,S(2)+1:10)=0;
Topology=mat2tmat(Sparsed_TM); %Topology without point allocation  
    
end   


%save master_topology.mat Master_Topology_Shrinked
%imagesc(mat2tmat(Master_Topology_Shrinked))