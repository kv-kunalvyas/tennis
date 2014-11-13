k=1;

for i=1:length(footage_data.grid_events)
    
    if isempty(footage_data.grid_events{i})==1
        continue
    else
        A = footage_data.grid_events{i};
        if strcmp(A(1,1),'B')
            M{k}=A;
            k=k+1;
        end
    end
end

M=M';
M = char(M);            % All bounce data - Next step to convert "B 1 2" 
                        % to 1 or 2 for near and far
                        
                        
k=1;
for i=1:length(M)
    if strcmp(M(i,3),'-')==1
        
        L(k)=1;
        k=k+1;
    else
        L(k)=2;
        k=k+1;
    end
end

Rtpm=zeros(2,2);
for i=1:length(L)-1
    
    if L(i)==1 && L(i+1)==1
        Rtpm(1,1) = Rtpm(1,1)+1;
    elseif L(i)==1 && L(i+1)==2
        Rtpm(1,2) = Rtpm(1,2)+1;
    elseif L(i)==2 && L(i+1)==1
        Rtpm(2,1) = Rtpm(2,1)+1;
    elseif L(i)==2 && L(i+1)==2
        Rtpm(2,2) = Rtpm(2,2)+1;
    end
end

Rtpm=Rtpm/sum(sum(Rtpm));
    
    