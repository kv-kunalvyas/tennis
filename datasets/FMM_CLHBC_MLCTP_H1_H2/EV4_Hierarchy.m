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
    if strcmp(Seq{i,1},'SF')
        PS(i,:) = {'SF'};
    elseif strcmp(Seq{i,1},'SN')
        PS(i,:) = {'SN'};
    end
end


PS=PS';
PS=PS(:);
PS(~ind)=[];

for i=1:length(PS)
    if strcmp(PS{i},'SF')
        T2(i) = 1;
    elseif strcmp(PS{i},'SN')
        T2(i) = 2;
    end
end
Seq2=PS;
Seq=OSeq;

To2 = zeros(2,2);
Sparsed_To2 = (full(sparse(T2(1:end-1),T2(2:end),1)));
S = size(Sparsed_To2);
Sparsed_To2(S(1)+1:2,S(2)+1:2)=0;
TMat2=mat2tmat(Sparsed_To2); %Topology without point allocation

TMat3=Build_master_topology(Seq);


New_Topology = zeros(8,8);

for i=1:length(Seq)-1
    
    if strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,1)=TMat3(1,1)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,1)=TMat3(1,1)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,1)=TMat3(1,1)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,1)=TMat3(1,1)*TMat2(2,2);
        end
    
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,2)=TMat3(1,2)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,2)=TMat3(1,2)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,2)=TMat3(1,2)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,2)=TMat3(1,2)*TMat2(2,2);
        end    
    
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,3)=TMat3(1,3)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,3)=TMat3(1,3)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,3)=TMat3(1,3)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,3)=TMat3(1,3)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,4)=TMat3(1,4)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,4)=TMat3(1,4)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,4)=TMat3(1,4)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,4)=TMat3(1,4)*TMat2(2,2);
        end    
        
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'BIN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,5)=TMat3(1,5)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,5)=TMat3(1,5)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,5)=TMat3(1,5)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,5)=TMat3(1,5)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'SF') && strcmp(Seq{i+1},'BON')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,7)=TMat3(1,7)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,7)=TMat3(1,7)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(1,7)=TMat3(1,7)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(1,7)=TMat3(1,7)*TMat2(2,2);
        end    
        
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(2,3)=TMat3(2,3)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(2,3)=TMat3(2,3)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(2,3)=TMat3(2,3)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(2,3)=TMat3(2,3)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'SN') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(2,4)=TMat3(2,4)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(2,4)=TMat3(2,4)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(2,4)=TMat3(2,4)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(2,4)=TMat3(2,4)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,3)=TMat3(3,3)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,3)=TMat3(3,3)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,3)=TMat3(3,3)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,3)=TMat3(3,3)*TMat2(2,2);
        end    
        
        
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,4)=TMat3(3,4)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,4)=TMat3(3,4)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,4)=TMat3(3,4)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,4)=TMat3(3,4)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'HF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,3)=TMat3(4,3)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,3)=TMat3(4,3)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,3)=TMat3(4,3)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,3)=TMat3(4,3)*TMat2(2,2);
        end
    
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'HN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,4)=TMat3(4,4)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,4)=TMat3(4,4)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,4)=TMat3(4,4)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,4)=TMat3(4,4)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,5)=TMat3(4,5)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,5)=TMat3(4,5)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,5)=TMat3(4,5)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,5)=TMat3(4,5)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BIF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,6)=TMat3(4,6)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,6)=TMat3(4,6)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,6)=TMat3(4,6)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,6)=TMat3(4,6)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BON')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,7)=TMat3(4,7)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,7)=TMat3(4,7)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,7)=TMat3(4,7)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,7)=TMat3(4,7)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HN') && strcmp(Seq{i+1},'BOF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,8)=TMat3(4,8)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,8)=TMat3(4,8)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(4,8)=TMat3(4,8)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(4,8)=TMat3(4,8)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,5)=TMat3(3,5)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,5)=TMat3(3,5)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,5)=TMat3(3,5)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,5)=TMat3(3,5)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BIF')
                if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,6)=TMat3(3,6)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,6)=TMat3(3,6)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,6)=TMat3(3,6)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,6)=TMat3(3,6)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BON')
                if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,7)=TMat3(3,7)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,7)=TMat3(3,7)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,7)=TMat3(3,7)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,7)=TMat3(3,7)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'HF') && strcmp(Seq{i+1},'BOF')
                if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,8)=TMat3(3,8)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,8)=TMat3(3,8)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(3,8)=TMat3(3,8)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(3,8)=TMat3(3,8)*TMat2(2,2);
        end
        
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(5,2)=TMat3(5,2)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(5,2)=TMat3(5,2)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(5,2)=TMat3(5,2)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(5,2)=TMat3(5,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(6,2)=TMat3(6,2)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(6,2)=TMat3(6,2)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(6,2)=TMat3(6,2)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(6,2)=TMat3(6,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SN')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(7,2)=TMat3(7,2)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(7,2)=TMat3(7,2)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(7,2)=TMat3(7,2)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(7,2)=TMat3(7,2)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SN')    
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(8,2)=TMat3(8,2)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(8,2)=TMat3(8,2)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(8,2)=TMat3(8,2)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(8,2)=TMat3(8,2)*TMat2(2,2);
        end
    
    elseif strcmp(Seq{i},'BIN') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(5,1)=TMat3(5,1)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(5,1)=TMat3(5,1)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(5,1)=TMat3(5,1)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(5,1)=TMat3(5,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BIF') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(6,1)=TMat3(6,1)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(6,1)=TMat3(6,1)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(6,1)=TMat3(6,1)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(6,1)=TMat3(6,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BON') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(7,1)=TMat3(7,1)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(7,1)=TMat3(7,1)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(7,1)=TMat3(7,1)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(7,1)=TMat3(7,1)*TMat2(2,2);
        end
    elseif strcmp(Seq{i},'BOF') && strcmp(Seq{i+1},'SF')
        if strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SF')
            New_Topology(8,1)=TMat3(8,1)*TMat2(1,1);
        elseif strcmp(Seq2(i),'SF') && strcmp(Seq2(i+1),'SN')
            New_Topology(8,1)=TMat3(8,1)*TMat2(1,2);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SF')
            New_Topology(8,1)=TMat3(8,1)*TMat2(2,1);
        elseif strcmp(Seq2(i),'SN') && strcmp(Seq2(i+1),'SN')
            New_Topology(8,1)=TMat3(8,1)*TMat2(2,2);
        end
    end
end

    
 %new topology has the hierarchial input to it
    
    
 LH = log(prod(New_Topology(New_Topology>0)));
 TMatrix = New_Topology;   
    
    
    
    
    
    
    
    
