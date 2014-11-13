function [Topology OSeq] = Gen_Master_Topology(Seq_numbered,sizeofmatrix)

Topology_Sparsed = zeros(sizeofmatrix,sizeofmatrix);
Sparsed_TM = (full(sparse(Seq_numbered(1:end-1),Seq_numbered(2:end),1)));
S = size(Sparsed_TM);
Sparsed_TM(S(1)+1:sizeofmatrix,S(2)+1:sizeofmatrix)=0;
Topology=mat2tmat(Sparsed_TM); %Topology without point allocation  
   