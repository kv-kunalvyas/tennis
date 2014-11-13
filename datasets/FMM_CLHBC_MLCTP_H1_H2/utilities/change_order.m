function D = change_order(Da)

D=0;
for i=1:length(Da)
    
    if Da(i)==1;
        D(i)=11;
    elseif Da(i)==2;
        D(i)=9;
        elseif Da(i)==3;
        D(i)=10;
        elseif Da(i)==4;
        D(i)=8;
        
        elseif Da(i)==5;
        D(i)=7;
        elseif Da(i)==6;
        D(i)=5;
        elseif Da(i)==7;
        D(i)=6;
        elseif Da(i)==8;
        D(i)=4;
        elseif Da(i)==9;
        D(i)=1;
        elseif Da(i)==10;
        D(i)=2;
        elseif Da(i)==11;
        D(i)=3;
    end
end

D=D';