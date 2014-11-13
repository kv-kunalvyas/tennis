%Fix errors in the data

function Fixed_Voc =  fix_annotation_errors(Seq)


Seq=Seq';
% k=0;
% for i=1:length(Seq)
%     
%     if strcmp(Seq{i},'Sp') && strcmp(Seq{i+1},'TSt')
%         BB=insertrows(Seq,'S',i);
%     elseif strcmp(Seq{i},'LG') && strcmp(Seq{i+1},'TSt')
%         BB=insertrows(Seq,'S',i);
%     elseif strcmp(Seq{i},'LA') && strcmp(Seq{i+1},'TSt')
%         BB=insertrows(Seq,'S',i);
%     elseif strcmp(Seq{i},Seq{i+1})
%         Seq(i)=[];
%         BB=Seq;
%     else
%         BB=Seq;
%     end
%     
%     Seq=BB;
%     clear BB
% end
% 
% Fixed_Voc=Seq';


Original = Seq;
New = Seq;
k=1;
for i=1:length(Seq)-1
    
    New{k}=Seq{i};
    k=k+1;

    if strcmp(Seq{i},'Sp') && strcmp(Seq{i+1},'TSt')
         New{k}=char('S');k=k+1;
    elseif strcmp(Seq{i},'LG') && strcmp(Seq{i+1},'TSt') 
         New{k}=char('S');k=k+1; 
    elseif strcmp(Seq{i},'LA') && strcmp(Seq{i+1},'TSt')
         New{k}=char('S');k=k+1; 
    elseif strcmp(Seq{i},Seq{i+1})
         New{k+1}=[];k=k+1; 
        
    end
end

New(cellfun(@isempty,New)) = [];

Fixed_Voc=New';


