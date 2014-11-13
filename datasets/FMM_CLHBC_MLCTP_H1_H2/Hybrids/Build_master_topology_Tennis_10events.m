function [Topology OSeq] = Build_master_topology_Tennis_10events(Seq)

Seq=Seq';
Seq=Seq(:);
Seq=Seq(~cellfun(@isempty,Seq));
OSeq=Seq;
% 1. SF
% 2. SNL
% 
% 3. HF
% 4. HN
%
% 5. BIN
% 6. BIF
% 7. BON
% 8. BOF

% 9. BOFS
% 10. BONS

k=1;
for i=1:length(Seq)
         if strcmp(Seq{i},'SF'), Seq_numbered(k) = 1; k=k+1;
            elseif strcmp(Seq{i},'SN'), Seq_numbered(k) = 2; k=k+1;
            elseif strcmp(Seq{i},'HF'), Seq_numbered(k) = 3; k=k+1;
            elseif strcmp(Seq{i},'HN'), Seq_numbered(k) = 4; k=k+1;
            elseif strcmp(Seq{i},'BIN'), Seq_numbered(k) = 5; k=k+1;
            elseif strcmp(Seq{i},'BIF'), Seq_numbered(k) = 6; k=k+1;
            elseif strcmp(Seq{i},'BON'), Seq_numbered(k) = 7; k=k+1;
            elseif strcmp(Seq{i},'BOF'), Seq_numbered(k) = 8; k=k+1;
            elseif strcmp(Seq{i},'BOFS'), Seq_numbered(k) = 9; k=k+1;
            elseif strcmp(Seq{i},'BONS'), Seq_numbered(k) = 10; k=k+1;   
            end
        end
        
        
        
        Topology_Sparsed = zeros(10,10);
        Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
        S = size(Sparsed_TM);
        Sparsed_TM(S(1)+1:10,S(2)+1:10)=0;
        Topology=Sparsed_TM;
        %Topology=mat2tmat(Sparsed_TM); %Topology without point allocation
        
