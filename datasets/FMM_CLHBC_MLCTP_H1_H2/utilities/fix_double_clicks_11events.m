%Fix errors in the data

function Fixed_Voc =  fix_double_clicks_11events(Seq) 

k=0;
for i=1:length(Seq)-1
    
    if Seq(i)==3
            Seq(i)=9; k=k+1;
    
    elseif Seq(i)==4
            Seq(i)=3; k=k+1;
    
    elseif Seq(i)==5 || Seq(i)==6 || Seq(i)==7 || Seq(i)==13 || Seq(i)==14
            Seq(i)=11; k=k+1;
    
    elseif Seq(i)==8
            Seq(i)=4; k=k+1;        
    
    elseif Seq(i)==9
            Seq(i)=7; k=k+1;        
    
    elseif Seq(i)==10
            Seq(i)=8; k=k+1;        

    elseif Seq(i)==11
            Seq(i)=5; k=k+1;        
    
    elseif Seq(i)==12 || Seq(i)==17
            Seq(i)=6; k=k+1;        
    
    elseif Seq(i)==15
            Seq(i)=10; k=k+1;        
            
    elseif Seq(i)==16
            Seq(i)=2; k=k+1;        
    
            
            
    end
    
end

Seq(find(Seq==0))=[];

Fixed_Voc=Seq;