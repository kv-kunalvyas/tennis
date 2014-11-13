function [hMM hST hCC Conf InD] = complete_top_best_replacedpermD(Topologies,Driving_Events,Train_Seqs,Test_Seqs,permuts,n,st)
[LH_Test Test_Seq TeMatrix] = EV4_hierarchy3levels(Test_Seqs);
B = TeMatrix;

k=0;m=1;c=1;
EV ={'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'};
Conf=zeros(10,10);

Transition_Matrix = Topologies.TM;

for iter = st:length(Driving_Events)-n
    l=1;
    JS_Distance=zeros(1,length(permuts));
    for i=1:length(Driving_Events)-n-iter+1
       Train_Seqst=Train_Seqs(i:i+iter-1);
       [LH_Train{i} Train_Seq{i} Train_T1] = EV4_hierarchy3levels(Train_Seqst);
   ccc=1;     
                    nonzero_indices=find(Transition_Matrix>0);      
                    AJS=Train_T1;
                    train_indices=find(AJS>0);
                          if factorial(length(nonzero_indices))<100;
                              LI=factorial(length(nonzero_indices));
                              JS_Distance=zeros(1,LI);
                          else
                              LI=100;
                              JS_Distance=zeros(1,LI);
                          end
              for permutations=1:LI
                  
                  %Transition_Matrix2(nonzero_indices(randperm(length(nonzero_indices))))=Transition_Matrix(nonzero_indices);
                    
                  TTT=train_indices(randperm(length(find(AJS>0))));
                  Transition_Matrix2=zeros(10,10);
                  if length(nonzero_indices)>length(TTT)
                      Transition_Matrix2(TTT(1:length(nonzero_indices)-(length(nonzero_indices)-length(TTT))))=Transition_Matrix(nonzero_indices(1:length(nonzero_indices)-(length(nonzero_indices)-length(TTT))));
                  else
                      Transition_Matrix2(TTT(1:length(nonzero_indices)))=Transition_Matrix(nonzero_indices);
                  end
                  BJS{permutations}=Transition_Matrix2;
                  clear Transition_Matrix2  
                    JS_Distance(ccc)=(abs(KLDiv(AJS(:)',BJS{permutations}(:)'))+abs(KLDiv(AJS(:)',BJS{permutations}(:)')))/2;
                    ccc=ccc+1; 
                end
                
                [~, InD]=min(JS_Distance);

                 Train_T.TM=BJS{InD};
                A = Train_T.TM;
                
                %save Drive_A.mat A
                load Drive_A.mat 
 A
                k=0;
    

Ts=zeros(10,10);
     k=0;
     s=0; tst=0; tle=0; tri=0; lr=0; la=0; lg=0;sill=0;sirr=0;sp=0;
     for j=1:length(Test_Seq)-1
        Ts=zeros(10,10);
        if strcmp(Test_Seq{j},'S')
            Ts = A;
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(1,1)=Conf(1,1)+1; k=k+1; s=s+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
        
        elseif strcmp(Test_Seq{j},'TSt')
            Ts(1,:) = A(2,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(2,2)=Conf(2,2)+1; k=k+1; tst=tst+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
           
        elseif strcmp(Test_Seq{j},'TLe')
            Ts(1,:) = A(3,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}),Conf(3,3)=Conf(3,3)+1; k=k+1; tle=tle+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
        
        elseif strcmp(Test_Seq{j},'TRi')
            Ts(1,:) = A(4,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}),Conf(4,4)=Conf(4,4)+1; k=k+1; tri=tri+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
           
        elseif strcmp(Test_Seq{j},'LR')
            Ts(1,:) = A(5,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(5,5)=Conf(5,5)+1;k=k+1; lr=lr+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
    
        elseif strcmp(Test_Seq{j},'LA')
            Ts(1,:) = A(6,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}),Conf(6,6)=Conf(6,6)+1; k=k+1; la=la+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
    
        elseif strcmp(Test_Seq{j},'LG')
            Ts(1,:) = A(7,:);
           [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
           NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0); 
           if strcmp(St,Test_Seq{j+1}),Conf(7,7)=Conf(7,7)+1; k=k+1; lg=lg+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
            
        elseif strcmp(Test_Seq{j},'SiLL')
            Ts(1,:) = A(8,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(8,8)=Conf(8,8)+1;k=k+1; sill=sill+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
            
        elseif strcmp(Test_Seq{j},'SiRR')
            Ts(1,:) = A(9,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(9,9)=Conf(9,9)+1;k=k+1; sirr=sirr+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
        
        elseif strcmp(Test_Seq{j},'Sp')
            Ts(1,:) = A(10,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',{'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'});
            NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
            MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
            if strcmp(St,Test_Seq{j+1}), Conf(10,10)=Conf(10,10)+1;k=k+1; sp=sp+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
        
            
            
        end    
        end
    
    S = strfind(Test_Seq,'S');TSt = strfind(Test_Seq,'TSt');TLe = strfind(Test_Seq,'TLe');TRi = strfind(Test_Seq,'TRi');LR = strfind(Test_Seq,'LR');LA = strfind(Test_Seq,'LA');LG = strfind(Test_Seq,'LG');SiLL = strfind(Test_Seq,'SiLL');SiRR = strfind(Test_Seq,'SiRR');Sp = strfind(Test_Seq,'Sp');
    L_S = length(S(~cellfun(@isempty,S)));L_TSt = length(TSt(~cellfun(@isempty,TSt)));L_TLe = length(TLe(~cellfun(@isempty,TLe)));L_TRi = length(TRi(~cellfun(@isempty,TRi)));
    L_LR = length(LR(~cellfun(@isempty,LR)))-1;L_LA = length(LA(~cellfun(@isempty,LA)));L_LG = length(LG(~cellfun(@isempty,LG)));L_SiLL = length(SiLL(~cellfun(@isempty,SiLL)));
    L_SiRR = length(SiRR(~cellfun(@isempty,SiRR)));L_Sp = length(Sp(~cellfun(@isempty,Sp)));
    
    if s>0 Start{iter}(i) = s/L_S * 100; else Start{iter}(i)=0; end
    if tst>0 Turn_Straight{iter}(i) = tst/L_TSt * 100; else Turn_Straight{iter}(i)=0; end
    if tle>0 Turn_Left{iter}(i) = tle/L_TLe * 100; else Turn_Left{iter}(i)=0; end
    if tri>0 Turn_Right{iter}(i) = tri/L_TRi * 100; else Turn_Right{iter}(i)=0; end
    if lr>0 Light_Red{iter}(i) = lr/L_LR * 100; else Light_Red{iter}(i)=0;  end
    if la>0 Light_Amber{iter}(i) = la/L_LA * 100; else Light_Amber{iter}(i)=0;  end
    if lg>0 Light_Green{iter}(i) = lg/L_LG * 100; else Light_Green{iter}(i)=0;  end
    if sill>0 Signal_Left{iter}(i) = sill/L_SiLL * 100; else Signal_Left{iter}(i)=0; end
    if sirr>0 Signal_Right{iter}(i) = sirr/L_SiRR * 100; else Signal_Right{iter}(i)=0; end
    if sp>0 Stop{iter}(i) = sp/L_Sp * 100; else Stop{iter}(i)=0; end
    
    
    clear s tst tle tri lr la lg sill sirr sp L_S L_TSt L_TLe L_TRi L_LR L_LA L_LG L_Sill L_SiRR L_Sp
          
    Sim(i) = k/(length(Test_Seq)-1);    
    Individual_Accuracy = [mean(Start{iter}(i)) mean(Turn_Straight{iter}(i)) mean(Turn_Left{iter}(i)) mean(Turn_Right{iter}(i)) mean(Light_Red{iter}(i)) mean(Light_Amber{iter}(i)) mean(Light_Green{iter}(i))...
        mean(Signal_Left{iter}(i)) mean(Signal_Right{iter}(i)) mean(Stop{iter}(i))];   
    Mean_Accuracy{c}(l) = mean(Individual_Accuracy);
    l=l+1;
end
c=c+1;

SS(m)=mean(Start{iter});
TTSSTT(m)=mean(Turn_Straight{iter});
TTLL(m)=mean(Turn_Left{iter});
TTRR(m)=mean(Turn_Right{iter});
LLRR(m)=mean(Light_Red{iter});
LLAA(m)=mean(Light_Amber{iter});
LLGG(m)=mean(Light_Green{iter});
SSLL(m)=mean(Signal_Left{iter});
SSRR(m)=mean(Signal_Right{iter});
SSPP(m)=mean(Stop{iter});
m=m+1;
end

hCC = [mean(SS); mean(TTSSTT); mean(TTLL); mean(TTRR); mean(LLRR); mean(LLAA); mean(LLGG); mean(SSLL);mean(SSRR);mean(SSPP)];

for i=1:length(Mean_Accuracy)
    hMM(i)=mean(Mean_Accuracy{i});
    hST(i)=std(Mean_Accuracy{i});
end


Conf = mat2tmat(Conf);
