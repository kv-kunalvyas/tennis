%Fix errors in the data

function Fixed_Voc =  fix_annotation_errors_10events(Seq) 

k=0;
for i=1:length(Seq)
    for j=1:52
        
        if strcmp(Seq{i,j},'SNL') || strcmp(Seq{i,j},'SNR')
            Seq{i,j}='SN'; k=k+1;
            
            
        elseif strcmp(Seq{i,j},'SFL') || strcmp(Seq{i,j},'SFR')
            Seq{i,j}='SF'; k=k+1;    
            
            
        elseif strcmp(Seq{i,j},'BINSL') || strcmp(Seq{i,j},'BINSR')
            Seq{i,j}='BIN'; k=k+1;    
            
        elseif strcmp(Seq{i,j},'BIFSL') || strcmp(Seq{i,j},'BIFSR')
            Seq{i,j}='BIF'; k=k+1; 
            
        elseif strcmp(Seq{i,j},'BOF') || strcmp(Seq{i,j},'BON') || strcmp(Seq{i,j},'BOFS') || strcmp(Seq{i,j},'BONS')   
            for Z = j+1:52
            Seq{i,Z}='';
            end
            k=k+1;
            
            
        elseif strcmp(Seq{i,j},'HF') && strcmp(Seq{i,j+1},'HF')
            Seq{i,j+1}=''; k=k+1;
            
            elseif strcmp(Seq{i,j},'HN') && strcmp(Seq{i,j+1},'HN')
            Seq{i,j+1}=''; k=k+1;  
            
        end
    end
end

Fixed_Voc=Seq;