function [OSeq TMatrix] = CLHBC_T(Seq) %number of training sequences
Sizzz=size(Seq);
AS=Seq;
Seq=Seq';
Seq=Seq(:);
ind=~cellfun(@isempty,Seq);
Seq=Seq(ind);
OSeq=Seq;
k=1;
PS={'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''};
Seq=AS;
for i=1:Sizzz(1)
    for j=1:Sizzz(2)
        if strcmp(Seq{i,j},'SFL') || strcmp(Seq{i,j},'SNL') || strcmp(Seq{i,j},'SFR') || strcmp(Seq{i,j},'SNR')
        PS(i,j) = {'S'};
        elseif strcmp(Seq{i,j},'HF') || strcmp(Seq{i,j},'HN')
        PS(i,j) = {'H'};
        elseif strcmp(Seq{i,j},'BIF') || strcmp(Seq{i,j},'BIN') || strcmp(Seq{i,j},'BIFSL')...
                || strcmp(Seq{i,j},'BINSL') ||  strcmp(Seq{i,j},'BIFSR') || strcmp(Seq{i,j},'BINSR')
        PS(i,j) = {'BI'};
        elseif strcmp(Seq{i,j},'BOF') || strcmp(Seq{i,j},'BON') ...
                || strcmp(Seq{i,j},'BOFS') || strcmp(Seq{i,j},'BONS')
        PS(i,j) = {'BO'};    
        end
    end
end
PS=PS';
PS=PS(:);
PS(~ind)=[];
for i=1:length(PS)
    if strcmp(PS{i},'S')
        T2(i) = 1; 
    elseif strcmp(PS{i},'H')
        T2(i) = 2; 
    elseif strcmp(PS{i},'BI')
        T2(i) = 3; 
        elseif strcmp(PS{i},'BO')
        T2(i) = 4; 
    end
end
Seq2=PS;
Seq=OSeq;
ind=cellfun(@isempty,Seq2);
Seq2(ind)=[];
To2 = zeros(4,4);
Sparsed_To2 = (full(sparse(T2(1:end-1),T2(2:end),1)));
S = size(Sparsed_To2);
Sparsed_To2(S(1)+1:4,S(2)+1:4)=0;
TMat2=mat2tmat(Sparsed_To2); %Topology without point allocation
TMat3=Build_master_topology_Tennis(Seq);
Div = [4 2 6 4];
Si = size(TMat2);
for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end
D=zeros(16,16);
for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
    end
end
LH = log(prod(D(D>0)));
TMatrix = mat2tmat(D);