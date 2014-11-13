%Fix errors in the data

function Fixed_Voc =  fix_double_clicks_(Seq) 

k=0;
for i=1:length(Seq)-1
    if Seq(i)==Seq(i+1)
            Seq(i)=0; k=k+1;
            
           
    end
    
end

Seq(find(Seq==0))=[];

Fixed_Voc=Seq;