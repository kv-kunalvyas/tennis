function [LH TMatrix] = Activity_test_CLHBC(Seq) %number of training sequences
Sizzz=size(Seq);

for i=1:Sizzz(1)
    if strcmp(Seq{i},' 1')
        PS(i) = {'S'};
        elseif strcmp(Seq{i},' 2') || strcmp(Seq{i},' 3')
        PS(i) = {'H'};
        elseif strcmp(Seq{i},' 4')
        PS(i) = {'B'};
        elseif strcmp(Seq{i},' 5') || strcmp(Seq{i},' 6') || strcmp(Seq{i},' 7')
        PS(i) = {'O'};
        elseif strcmp(Seq{i},' 8') || strcmp(Seq{i},' 9') || strcmp(Seq{i},'10')
        PS(i) = {'O2'};
        elseif strcmp(Seq{i},'11')
        PS(i) = {'O3'};    
    end
    
end

for i=1:length(PS)
    if strcmp(PS{i},'S')
        T2(i) = 1; 
    elseif strcmp(PS{i},'H')
        T2(i) = 2; 
    elseif strcmp(PS{i},'B')
        T2(i) = 3; 
    elseif strcmp(PS{i},'O')
        T2(i) = 4;
    elseif strcmp(PS{i},'O2')
        T2(i) = 5;
        elseif strcmp(PS{i},'O3')
        T2(i) = 6;
        
        
    end
end
Seq2=PS;
Seq=Seq;
ind=cellfun(@isempty,Seq2);
Seq2(ind)=[];
To2 = zeros(6,6);
Sparsed_To2 = (full(sparse(T2(1:end-1),T2(2:end),1)));
S = size(Sparsed_To2);
Sparsed_To2(S(1)+1:6,S(2)+1:6)=0;
TMat2=mat2tmat(Sparsed_To2); %Topology without point allocation

TMat3=Build_master_topology_MSN_11events(Seq);
Div = [1 2 1 3 3 1];
Si = size(TMat2);
for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end
D=zeros(11,11);
for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
    end
end
LH = log(prod(D(D>0)));
TMatrix = mat2tmat(D);