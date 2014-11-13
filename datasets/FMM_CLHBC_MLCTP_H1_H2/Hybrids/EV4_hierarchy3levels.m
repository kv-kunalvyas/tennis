function [LH OSeq TMatrix] = EV4_hierarchy3levels(Seq) %number of training sequences

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
for i=1:length(Seq)
        if strcmp(Seq{i},'S')
        PS(i)={'S'};
        elseif strcmp(Seq{i},'TSt') || strcmp(Seq{i},'TLe') || strcmp(Seq{i},'TRi')
        PS(i) = {'T'};
        elseif strcmp(Seq{i},'LR') || strcmp(Seq{i},'LA') || strcmp(Seq{i},'LG')
        PS(i) = {'L'};
        elseif strcmp(Seq{i},'SiLL') || strcmp(Seq{i},'SiRR')
        PS(i) = {'Si'};
        elseif strcmp(Seq{i},'Sp')
        PS(i)={'Sp'};
        end
    
end

PS=PS';
PS=PS(:);
PS(~ind)=[];

for i=1:length(PS)
    if strcmp(PS{i},'S')
        T2(i) = 1;
    elseif strcmp(PS{i},'T')
        T2(i) = 2;
    elseif strcmp(PS{i},'L')
        T2(i) = 3;
        elseif strcmp(PS{i},'Si')
        T2(i) = 4;
        elseif strcmp(PS{i},'Sp')
        T2(i) = 5;
    end
end
Seq2=PS;
Seq=OSeq;
clear PS
To2 = zeros(5,5);
Sparsed_To2 = (full(sparse(T2(1:end-1),T2(2:end),1)));
S = size(Sparsed_To2);
Sparsed_To2(S(1)+1:5,S(2)+1:5)=0;
TMat2=mat2tmat(Sparsed_To2); %Topology without point allocation

for i=1:length(Seq2)
        if strcmp(Seq2{i},'S')
        PS(i)={'S'};
        elseif strcmp(Seq2{i},'T') || strcmp(Seq2{i},'L') || strcmp(Seq2{i},'Si')
        PS(i) = {'D'};
        elseif strcmp(Seq2{i},'Sp')
        PS(i)={'Sp'};
        end
    
end

PS=PS';
PS=PS(:);
PS(~ind)=[];

for i=1:length(PS)
    if strcmp(PS{i},'S')
        T1(i) = 1;
    elseif strcmp(PS{i},'D')
        T1(i) = 2;
    elseif strcmp(PS{i},'Sp')
        T1(i) = 3;
        
    end
end
Seq1=PS;
Seq=OSeq;

To1 = zeros(3,3);
Sparsed_To1 = (full(sparse(T1(1:end-1),T1(2:end),1)));
S = size(Sparsed_To1);
Sparsed_To1(S(1)+1:3,S(2)+1:3)=0;
TMat1=mat2tmat(Sparsed_To1); %Topology without point allocation


Div = [1 3 1];
Si = size(TMat1);
for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end
D=zeros(5,5);
for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat2(A{i},A{j})*TMat1(i,j);
    end
end
LH = log(prod(D(D>0)));

TMat2n = mat2tmat(D);

clear TMat2

TMat2=TMat2n;
TMat3=Build_master_topology_Driver(Seq);



Div = [1 3 3 2 1];
Si = size(TMat2);
for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end

D=zeros(10,10);
for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
    end
end
LH = log(prod(D(D>0)));
TMatrix = mat2tmat(D);