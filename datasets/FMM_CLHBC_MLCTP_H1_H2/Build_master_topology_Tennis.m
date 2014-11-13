function [Topology OSeq] = Build_master_topology_Tennis(Seq,Size)

if nargin<2
    N='8'; %creates an 8X8 matrix
elseif Size==10
    N='10';
end

Seq=Seq';
Seq=Seq(:);
Seq=Seq(~cellfun(@isempty,Seq));
OSeq=Seq;
% 1. SFL
% 2. SFR
% 3. SNL
% 4. SNR

% 5. HF
% 6. HN
%
% 7. BIN
% 8. BIF
% 9. BON
% 10. BOF

% 11. BINSL
% 12. BIFSL
% 13. BINSR
% 14. BIFSR

% 15. BOFS
% 16. BONS

switch lower(N)
    case{'8'}
        k=1;
        for i=1:length(Seq)
            if strcmp(Seq{i},'SFL'), Seq_numbered(k) = 1; k=k+1;
            elseif strcmp(Seq{i},'SFR'), Seq_numbered(k) = 2; k=k+1;
            elseif strcmp(Seq{i},'SNL'), Seq_numbered(k) = 3; k=k+1;
            elseif strcmp(Seq{i},'SNR'), Seq_numbered(k) = 4; k=k+1;
            elseif strcmp(Seq{i},'HF'), Seq_numbered(k) = 5; k=k+1;
            elseif strcmp(Seq{i},'HN'), Seq_numbered(k) = 6; k=k+1;
            elseif strcmp(Seq{i},'BIN'), Seq_numbered(k) = 7; k=k+1;
            elseif strcmp(Seq{i},'BIF'), Seq_numbered(k) = 8; k=k+1;
            elseif strcmp(Seq{i},'BON'), Seq_numbered(k) = 9; k=k+1;
            elseif strcmp(Seq{i},'BOF'), Seq_numbered(k) = 10; k=k+1;
            elseif strcmp(Seq{i},'BINSL'), Seq_numbered(k) = 11; k=k+1;
            elseif strcmp(Seq{i},'BIFSL'), Seq_numbered(k) = 12; k=k+1;
            elseif strcmp(Seq{i},'BINSR'), Seq_numbered(k) = 13; k=k+1;
            elseif strcmp(Seq{i},'BIFSR'), Seq_numbered(k) = 14; k=k+1;
            elseif strcmp(Seq{i},'BOFS'), Seq_numbered(k) = 15; k=k+1;
            elseif strcmp(Seq{i},'BONS'), Seq_numbered(k) = 16; k=k+1;   
            end
        end
        
        
        
        Topology_Sparsed = zeros(16,16);
        Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
        S = size(Sparsed_TM);
        Sparsed_TM(S(1)+1:16,S(2)+1:16)=0;
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