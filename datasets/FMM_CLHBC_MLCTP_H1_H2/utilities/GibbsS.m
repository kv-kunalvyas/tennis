%Gibbs
K(4,4)=zeros;
K(1,1)=0.2;
K(1,2)=0.8;
K(2,2)=0.3;
K(2,3)=0.7;
K(3,3)=0.1;
K(3,4)=0.9;
K(4,4)=0.4;
K(4,1)=0.1;


M=zeros(4,4);
j=1;
for i=1:100
    
    if j==1
        if randn>K(1,2)
            M(1,2)=M(1,2)+1;
            j=2;
        else
            M(1,1)=M(1,1)+1;
        end
        continue
    end
    
    if j==2
        if randn>K(2,3)
            M(2,3)=M(2,3)+1;
            j=3;
        else
            M(2,2)=M(2,2)+1;
        end
        continue
    end
    
    if j==3
        if randn>K(3,4)
            M(3,4)=M(3,4)+1;
            j=4;
        else
            M(3,3)=M(3,3)+1;
        end
        continue
    end
    
    if j==4
        if randn>K(4,1)
            M(4,1)=M(4,1)+1;
            j=1;
        else
            M(4,4)=M(4,4)+1;
        end
        continue
    end
end


M(1,:)=M(1,:)/sum(M(1,:));
M(2,:)=M(2,:)/sum(M(2,:));
M(3,:)=M(3,:)/sum(M(3,:));
M(4,:)=M(4,:)/sum(M(4,:));
