%Fix errors in the data

function Fixed_Voc =  fix_annotation_errors(Seq) 

k=0;
for i=1:length(Seq)
    for j=1:31
        
        if strcmp(Seq{i,j},'BIN') && strcmp(Seq{i+1,1},'SN')
            Seq{i,j}='BON'; k=k+1;
            
        elseif strcmp(Seq{i,j},'BIF') && strcmp(Seq{i+1,1},'SF')
            Seq{i,j}='BOF'; k=k+1;
            
             elseif strcmp(Seq{i,j},'BON') && strcmp(Seq{i+1,1},'SF')
            Seq{i,j}='BIN'; k=k+1;
            
               elseif strcmp(Seq{i,j},'BOF') && strcmp(Seq{i+1,1},'SN')
            Seq{i,j}='BON'; k=k+1;
            
            
            
              elseif strcmp(Seq{i,j},'HF') && strcmp(Seq{i,j+1},'HF')
            Seq{i,j+1}=''; k=k+1;
            
            elseif strcmp(Seq{i,j},'HN') && strcmp(Seq{i,j+1},'HN')
            Seq{i,j+1}=''; k=k+1;  
            
        end
    end
end

Fixed_Voc=Seq;