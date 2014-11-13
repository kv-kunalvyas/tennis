function [LH OSeq TMatrix] = EV4_hierarchy(Seq) %number of training sequences
Sizzz=size(Seq);
AS=Seq;
Seq=Seq';
Seq=Seq(:);
ind=~cellfun(@isempty,Seq);
Seq=Seq(ind);
OSeq=Seq; 

k=1;
PS={'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''};

Seq=AS;
for i=1:Sizzz(1)
    for j=1:Sizzz(2)
        if strcmp(Seq{i,j},'SF') || strcmp(Seq{i,j},'SN')
        PS(i,j) = {'S'};
        elseif strcmp(Seq{i,j},'HF') || strcmp(Seq{i,j},'HN')
        PS(i,j) = {'H'};
        elseif strcmp(Seq{i,j},'BIF') || strcmp(Seq{i,j},'BIN') || strcmp(Seq{i,j},'BOF') || strcmp(Seq{i,j},'BON')
        PS(i,j) = {'B'};
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
    elseif strcmp(PS{i},'B')
        T2(i) = 3;
    end
end
Seq2=PS;
Seq=OSeq;

To2 = zeros(3,3);
Sparsed_To2 = (full(sparse(T2(1:end-1),T2(2:end),1)));
S = size(Sparsed_To2);
Sparsed_To2(S(1)+1:3,S(2)+1:3)=0;
TMat2=mat2tmat(Sparsed_To2); %Topology without point allocation

TMat3=Build_master_topology_Badminton(Seq);
Div = [2 2 4];
Si = size(TMat2);
for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end
D=zeros(8,8);
for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
    end
end
LH = log(prod(D(D>0)));
TMatrix = mat2tmat(D);