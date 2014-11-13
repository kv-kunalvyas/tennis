% Compute Likelihood of a playshot
%clear
load playshots
load indices_for_shots5
clear L

Vocabulary = Vocabulary(indices,:);
%Vocabulary=Vocabulary(1:end/2,:); %for Train
Vocabulary=Vocabulary(end/2:end,:); %for Test

for i=1:length(Vocabulary)
    playshots{i}=Vocabulary(i,:);
end

for i=1:length(Vocabulary)
mat_dirN{i}=zeros(4,4);
mat_dirF{i}=zeros(4,4);
end

for mnm=1:length(playshots)
    
    if (strcmp(playshots{mnm}(1),'SFL') || strcmp(playshots{mnm}(1),'SF') || strcmp(playshots{mnm}(1),'SFR'))
        
        for i=1:length(playshots{mnm})-1
        
            if (strcmp(playshots{mnm}(i),'SFL') || strcmp(playshots{mnm}(i),'SF') || strcmp(playshots{mnm}(i),'SFR')) && strcmp(playshots{mnm}(i+1),'HN')
                        mat_dirF{mnm}(1,2)=mat_dirF{mnm}(1,2)+1;
            
            
            elseif (strcmp(playshots{mnm}(i),'SF') &&(strcmp(playshots{mnm}(i+1),'BIN')))
                        mat_dirF{mnm}(1,4)=mat_dirF{mnm}(1,4)+1;
                        
            elseif (strcmp(playshots{mnm}(i),'SF') &&(strcmp(playshots{mnm}(i+1),'BONS')))
                        mat_dirF{mnm}(1,4)=mat_dirF{mnm}(1,4)+1;                        
                                                
                        
            elseif strcmp(playshots{mnm}(i),'HN') && strcmp(playshots{mnm}(i+1),'HF')
                        mat_dirF{mnm}(2,3)=mat_dirF{mnm}(2,3)+1;
                
            elseif strcmp(playshots{mnm}(i),'HF') && strcmp(playshots{mnm}(i+1),'HN')
                        mat_dirF{mnm}(3,2)=mat_dirF{mnm}(3,2)+1;
                
            elseif strcmp(playshots{mnm}(i),'HF') && (strcmp(playshots{mnm}(i+1),'BIN') || strcmp(playshots{mnm}(i+1),'BIF') || ...
                    strcmp(playshots{mnm}(i+1),'BON')|| strcmp(playshots{mnm}(i+1),'BOF'))
                
                mat_dirF{mnm}(3,4)=mat_dirF{mnm}(3,4)+1;
                
            elseif strcmp(playshots{mnm}(i),'HN') && (strcmp(playshots{mnm}(i+1),'BIN') || strcmp(playshots{mnm}(i+1),'BIF') || ...
                    strcmp(playshots{mnm}(i+1),'BON')|| strcmp(playshots{mnm}(i+1),'BOF'))
                %playshots{j}(i)={'H'};
                
                mat_dirF{mnm}(2,4)=mat_dirF{mnm}(2,4)+1;
            end              
            
               
        end
        
    else
        for i=1:length(playshots{mnm})-1
        
            if (strcmp(playshots{mnm}(i),'SNL') || strcmp(playshots{mnm}(i),'SN') || strcmp(playshots{mnm}(i),'SNR')) && strcmp(playshots{mnm}(i+1),'HF')
                        mat_dirN{mnm}(1,2)=mat_dirN{mnm}(1,2)+1;
                
            elseif strcmp(playshots{mnm}(i),'HN') && strcmp(playshots{mnm}(i+1),'HF')
                        mat_dirN{mnm}(2,3)=mat_dirN{mnm}(2,3)+1;
                
            elseif strcmp(playshots{mnm}(i),'HF') && strcmp(playshots{mnm}(i+1),'HN')
                        mat_dirN{mnm}(3,2)=mat_dirN{mnm}(3,2)+1;
                
            elseif strcmp(playshots{mnm}(i),'HF') && (strcmp(playshots{mnm}(i+1),'BIN') || strcmp(playshots{mnm}(i+1),'BIF') || ...
                    strcmp(playshots{mnm}(i+1),'BON')|| strcmp(playshots{mnm}(i+1),'BOF'))
                
                mat_dirN{mnm}(3,4)=mat_dirN{mnm}(3,4)+1;
                
            elseif strcmp(playshots{mnm}(i),'HN') && (strcmp(playshots{mnm}(i+1),'BIN') || strcmp(playshots{mnm}(i+1),'BIF') || ...
                    strcmp(playshots{mnm}(i+1),'BON')|| strcmp(playshots{mnm}(i+1),'BOF'))
                %playshots{j}(i)={'H'};
                
                mat_dirN{mnm}(2,4)=mat_dirN{mnm}(2,4)+1;
            end              
            
               
        end
        
        
        
        
    end
end

for i=1:length(Vocabulary)
    mat_dirN{i} = mat2tmat(mat_dirN{i});
    mat_dirF{i} = mat2tmat(mat_dirF{i});
end


%likelihood of a playshot

for i=1:length(Vocabulary)
    if ~isempty(mat_dirN{i}(mat_dirN{i}>0))
    L(i) = prod(mat_dirN{i}(mat_dirN{i}>0));
    
    elseif ~isempty(mat_dirF{i}(mat_dirF{i}>0))
    L(i) = prod(mat_dirF{i}(mat_dirF{i}>0));
    end
end
    
   L=L';     

   %Ignoring playshots with less than 5 playshots
   I=zeros(63,1);
   for i=1:length(Vocabulary)
       for j=1:31
            if isempty(Vocabulary{i,j})
                if j>4
                    I(i,1) = 1;
                end
                break;
            end
    end
   end

   indices = find(I>0);     %indices for shots with greater than 4 events
   
   %dicotomise topologies
   clear A
   A = [association' L];
   
% for i=1:length(Vocabulary)
%     if A(i,1)==1
%         LF(i)= L(i)*6;
%     elseif A(i,1)==2
%         LF(i)= L(i)*4;
%     elseif A(i,1)==3
%         LF(i)= L(i)*5;
%     elseif A(i,1)==4
%         LF(i)= L(i)*18;
%     elseif A(i,1)==5
%         LF(i)= L(i)*21;
%     elseif A(i,1)==6
%         LF(i)= L(i)*7;
%     elseif A(i,1)==7
%         LF(i)= L(i)*12;
%     elseif A(i,1)==8
%         LF(i)= L(i)*15;
%     end
% end

for i=1:length(Vocabulary)
    if A(i,1)==1
        LF(i)= L(i)*0.5;
    elseif A(i,1)==2
        LF(i)= L(i)*1/9;
    elseif A(i,1)==3
        LF(i)= L(i)*1/6;
    elseif A(i,1)==4
        LF(i)= L(i)*1;
    elseif A(i,1)==5
        LF(i)= L(i)*0.5;
    elseif A(i,1)==6
        LF(i)= L(i)*0.2;
    elseif A(i,1)==7
        LF(i)= L(i)*0.2;
    elseif A(i,1)==8
        LF(i)= L(i)*1;
    end
end

LF=L;



ii1=find(association==1);U(1)=mean((LF(ii1)));
ii2=find(association==2);U(2)=mean((LF(ii2)));
ii3=find(association==3);U(3)=mean((LF(ii3)));
ii4=find(association==4);U(4)=mean((LF(ii4)));
ii5=find(association==5);U(5)=mean((LF(ii5)));
ii6=find(association==6);U(6)=mean((LF(ii6)));
ii7=find(association==7);U(7)=mean((LF(ii7)));
ii8=find(association==8);U(8)=mean((LF(ii8)));

%plot(U)
%grid on

% TRAIN
%  UTr = U; associationTr = association; LikTr = LF;
%  save Training_set.mat UTr LikTr associationTr

% TEST
 UTe = U; associationTe = association; LikTe = LF;
 save Test_set.mat UTe LikTe associationTe













   
break
for j=1:length(playshots)  %N
    for i=1:maxShotsize-1
        if strcmp(playshots(j,1),'SNL') || strcmp(playshots(j,1),'SN') || strcmp(playshots(j,1),'SNR')
            playshots(j,1)={'SN'};
            if (strcmp(playshots{j}(i),'SNL') || strcmp(playshots{j}(i),'SN') || strcmp(playshots{j}(i),'SNR')) && strcmp(playshots{j+1}(i),'HF')
                playshots{j}(i)={'SN'};
                badminton_pmN(1,2)=badminton_pmN(1,2)+1;
                mat_dir{mnm,i}(1,2)=mat_dir{mnm,i}(1,2)+1;
                
            elseif strcmp(playshots{j}(i),'HF') && strcmp(playshots{j+1}(i),'HN')
                %playshots{j}(i)={'H'};
                badminton_pmN(2,3)=badminton_pmN(2,3)+1;
                mat_dir{mnm,i}(2,2)=mat_dir{mnm,i}(2,2)+1;
                
            elseif strcmp(playshots{j}(i),'HN') && strcmp(playshots{j+1}(i),'HF')
                %playshots{j}(i)={'H'};
                badminton_pmN(3,2)=badminton_pmN(3,2)+1;
                mat_dir{mnm,i}(2,2)=mat_dir{mnm,i}(2,2)+1;
                
            elseif strcmp(playshots{j}(i),'HN') && (strcmp(playshots{j+1}(i),'BIN') || strcmp(playshots{j+1}(i),'BIF') || ...
                    strcmp(playshots{j+1}(i),'BON')|| strcmp(playshots{j+1}(i),'BOF'))
                %playshots{j}(i)={'H'};
                badminton_pmN(3,4)=badminton_pmN(3,4)+1;
                mat_dir{mnm,i}(2,3)=mat_dir{mnm,i}(2,3)+1;
                
            elseif strcmp(playshots{j}(i),'HF') && (strcmp(playshots{j+1}(i),'BIN') || strcmp(playshots{j+1}(i),'BIF') || ...
                    strcmp(playshots{j+1}(i),'BON')|| strcmp(playshots{j+1}(i),'BOF'))
                %playshots{j}(i)={'H'};
                badminton_pmN(2,4)=badminton_pmN(2,4)+1;
                mat_dir{mnm,i}(2,3)=mat_dir{mnm,i}(2,3)+1;
                
%             elseif strcmp(playshots{j}(i),'BIN') || strcmp(playshots{j}(i),'BIF') || ...
%                     strcmp(playshots{j}(i),'BON')|| strcmp(playshots{j}(i),'BOF') || strcmp(playshots{j}(i),'BONS')...
%                     || strcmp(playshots{j}(i),'BOFS') || strcmp(playshots{j}(i),'BINSL') || strcmp(playshots{j}(i),'BIFSL')
%                 playshots{j}(i)={'B'};
             
     elseif strcmp(playshots{j}(i),'BIN')
               playshots{j}(i)={'BIN'};
            elseif strcmp(playshots{j}(i),'BINSL')
               playshots{j}(i)={'BINSL'}; 
               
               
            elseif strcmp(playshots{j}(i),'BIF')
               playshots{j}(i)={'BIF'};
            elseif strcmp(playshots{j}(i),'BIFSL')
               playshots{j}(i)={'BIFSL'}; 
            
            elseif strcmp(playshots{j}(i),'BON')
               playshots{j}(i)={'BON'};
            elseif strcmp(playshots{j}(i),'BOF')
               playshots{j}(i)={'BOF'}; 
               
            elseif strcmp(playshots{j}(i),'BONS')
               playshots{j}(i)={'BONS'};
            elseif strcmp(playshots{j}(i),'BOFS')
               playshots{j}(i)={'BOFS'}; 
            end
            
           
            
            if (strcmp(playshots{j+1}(i),'BIN') || strcmp(playshots{j+1}(i),'BIF') || ...
                    strcmp(playshots{j+1}(i),'BON')|| strcmp(playshots{j+1}(i),'BOF')) && (strcmp(playshots(j+1,1),'SNL') ...
                    || strcmp(playshots(j+1,1),'SN') || strcmp(playshots(j+1,1),'SNR'))
                mat_dir{mnm,i}(3,1)=mat_dir{mnm,i}(3,1)+1;
            end
            
            if (strcmp(playshots{j+1}(i),'BIN') || strcmp(playshots{j+1}(i),'BIF') || ...
                    strcmp(playshots{j+1}(i),'BON')|| strcmp(playshots{j+1}(i),'BOF')) && (strcmp(playshots(j+1,1),'SFL') ...
                    || strcmp(playshots(j+1,1),'SF') || strcmp(playshots(j+1,1),'SFR'))
                mat_dir{mnm,i}(3,4)=mat_dir{mnm,i}(3,4)+1;
                
            end
        end
    end
end


SF = sum(badminton_pmF,2);

badminton_pmF = bsxfun(@rdivide,badminton_pmF,SF+eps);

SN = sum(badminton_pmN,2);

badminton_pmN = bsxfun(@rdivide,badminton_pmN,SN+eps);

M = sum(mat_dir{mnm,i},2);

mat_dir{mnm,i} = bsxfun(@rdivide,mat_dir{mnm,i},M+eps);