function [nMM nST nCC Conf InD] = complete_top_replacedperm_T(Topologies,Vocabulary1,Vocabulary2,permuts,st)
Test_S=Vocabulary2;
[Test_Seq Test_T]=CLHBC_T10(Test_S);
B = Test_T;
m=1;c=1;

 EV = {'SF'; 'SN'; 'HF'; 'HN'; 'BIN'; 'BIF'; 'BON' ;'BOF';'BOFS';'BONS'};
Conf=zeros(10,10);


    InD=0;
    m=1;c=1;
    Transition_Matrix = Topologies.TM;
    
for iter = st:length(Vocabulary1) %REMOVE -47 for complete %replace with start with 1 for complete        
    l=1;
    
            for i=1:length(Vocabulary1)-iter+1 %replace with i:length(Vocabulary)-n-iter+1 for complete
                Train_S=Vocabulary1(i:i+iter-1,:);
                [ZCA Train_T1]=CLHBC_T10(Train_S);
                          ccc=1;     
                    nonzero_indices=find(Transition_Matrix>0);      
                    AJS=Train_T1;
                    train_indices=find(AJS>0);
                          if factorial(length(nonzero_indices))<1
                              LI=factorial(length(nonzero_indices));
                              JS_Distance=zeros(1,LI);
                          else
                              LI=1;
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
                
                %InD = 4252;
                [~, InD]=min(JS_Distance);

                 Train_T.TM=BJS{InD};
                 
             
                 %TENNIS HAND ANNOTATED
                 Train_T.TM=[   0         0         0         0    1.0000         0         0         0         0    1.0000
         0         0         0         0         0    1.0000         0         0         0         0
         0         0         0         0    0.9999         0         0         0         0         0
         0         0         0         0         0    0.0046         0         0         0         0
         0         0         0    1.0000         0         0         0         0         0         0
         0         0    0.0001         0         0         0         0         0         0         0
         0         0         0         0         0         0         0         0         0         0
    0.9954         0         0         0         0         0         0         0         0         0
         0    0.4244         0         0         0         0         0         0         0         0
    0.5756         0         0         0         0         0         0         0         0         0];
                 
                %TENNIS REAL
                              
              
     A = Train_T.TM;
                    Ts=zeros(10,10);
    k=0;
        
        sf=0; sn=0; hf=0; hn=0; bin=0; bif=0; bon=0; bof=0;
        bofs=0; bons=0;
        
        for j=1:length(Test_Seq)-1
            Ts=zeros(10,10);
            if strcmp(Test_Seq{j},'SF')
                Ts = A;
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(1,1)=Conf(1,1)+1; k=k+1; sf=sf+1; else Conf(1,iid)=Conf(1,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'SN')
                Ts(1,:) = A(2,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(2,2)=Conf(2,2)+1; k=k+1; sn=sn+1;  else Conf(2,iid)=Conf(2,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'HF')
                Ts(1,:) = A(3,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(3,3)=Conf(3,3)+1; k=k+1; hf=hf+1;  else Conf(3,iid)=Conf(3,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'HN')
                Ts(1,:) = A(4,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(4,4)=Conf(4,4)+1;k=k+1; hn=hn+1;  else Conf(4,iid)=Conf(4,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'BIN')
                Ts(1,:) = A(5,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(5,5)=Conf(5,5)+1; k=k+1; bin=bin+1;  else Conf(5,iid)=Conf(5,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'BIF')
                Ts(1,:) = A(6,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(6,6)=Conf(6,6)+1; k=k+1; bif=bif+1;  else Conf(6,iid)=Conf(6,iid)+1; end
            
            
            elseif strcmp(Test_Seq{j},'BON')
                Ts(1,:) = A(7,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(7,7)=Conf(7,7)+1; k=k+1; bon=bon+1;  else Conf(7,iid)=Conf(7,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'BOF')
                Ts(1,:) = A(8,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(8,8)=Conf(8,8)+1; k=k+1; bof=bof+1;  else Conf(8,iid)=Conf(8,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'BOFS')
                Ts(1,:) = A(9,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(9,9)=Conf(9,9)+1; k=k+1; bofs=bofs+1;  else Conf(9,iid)=Conf(9,iid)+1; end
            
             elseif strcmp(Test_Seq{j},'BONS')
                Ts(1,:) = A(10,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(10,10)=Conf(10,10)+1; k=k+1; bons=bons+1;  else Conf(10,iid)=Conf(10,iid)+1; end
            end
        end
        
        SF = strfind(Test_Seq,'SF');
        SN = strfind(Test_Seq,'SN');
        HF = strfind(Test_Seq,'HF');
        HN = strfind(Test_Seq,'HN');
        
        BIN = strfind(Test_Seq,'BIN');
        BIF = strfind(Test_Seq,'BIF');
        BON = strfind(Test_Seq,'BON');
        BOF = strfind(Test_Seq,'BOF');
        
        BOFS = strfind(Test_Seq,'BOFS');
        BONS = strfind(Test_Seq,'BONS');
        
        
        
        L_SF = length(SF(~cellfun(@isempty,SF)));
        L_SN = length(SN(~cellfun(@isempty,SN)));
        L_HF = length(HF(~cellfun(@isempty,HF)));
        L_HN = length(HN(~cellfun(@isempty,HN)));
        
        L_BIN = length(BIN(~cellfun(@isempty,BIN)));
        L_BIF = length(BIF(~cellfun(@isempty,BIF)));
        L_BON = length(BON(~cellfun(@isempty,BON)));
        L_BOF = length(BOF(~cellfun(@isempty,BOF)));
                
        L_BOFS = length(BOFS(~cellfun(@isempty,BOFS)));
        L_BONS = length(BONS(~cellfun(@isempty,BONS)))-1;
        
        
        if sf>0 Serve_Far{iter}(i) = sf/L_SF * 100; else Serve_Far{iter}(i)=0; end
        if sn>0 Serve_Near{iter}(i) = sn/L_SN * 100; else Serve_Near{iter}(i)=0; end
               
        if hf>0 Hit_Far{iter}(i) = hf/L_HF * 100; else Hit_Far{iter}(i)=0; end
        if hn>0 Hit_Near{iter}(i) = hn/L_HN * 100; else Hit_Near{iter}(i)=0; end
        
        if bin>0 BI_Near{iter}(i) = bin/L_BIN * 100; else BI_Near{iter}(i)=0;  end
        if bif>0 BI_Far{iter}(i) = bif/L_BIF * 100; else BI_Far{iter}(i)=0;  end
        if bon>0 BO_Near{iter}(i) = bon/L_BON * 100; else BO_Near{iter}(i)=0; end
        if bof>0 BO_Far{iter}(i) = bof/L_BOF * 100; else BO_Far{iter}(i)=0;  end
                
        if bofs>0 BO_Far_S{iter}(i) = bofs/L_BOFS * 100; else BO_Far_S{iter}(i)=0; end
        if bons>0 BO_Near_S{iter}(i) = bons/L_BONS * 100; else BO_Near_S{iter}(i)=0;  end
        
        clear sf sn hf hn bif bin bof bon bofs bons L_SF L_SN L_HF L_HN L_BIF L_BIN L_BOF L_BON L_BOFS L_BONS
        
        Sim(i) = k/(length(Test_Seq)-1);
        
        Individual_Accuracy = [mean(Serve_Far{iter}(i)) mean(Serve_Near{iter}(i)) mean(Hit_Far{iter}(i)) mean(Hit_Near{iter}(i))...
            mean(BI_Near{iter}(i)) mean(BI_Far{iter}(i)) mean(BO_Near{iter}(i)) mean(BO_Far{iter}(i)) mean(BO_Far_S{iter}(i)) mean(BO_Near_S{iter}(i))];
        
        Mean_Accuracy{c}(l) = mean(Individual_Accuracy);
        l=l+1;
      
    end
    c=c+1;
    
    SSFF(m)=mean(Serve_Far{iter});
    SSNN(m)=mean(Serve_Near{iter});
    
    HHFF(m)=mean(Hit_Far{iter});
    HHNN(m)=mean(Hit_Near{iter});
    
    BBIINN(m)=mean(BI_Near{iter});
    BBIIFF(m)=mean(BI_Far{iter});
    BBOONN(m)=mean(BO_Near{iter});
    BBOOFF(m)=mean(BO_Far{iter});
    
    BBOOFFSS(m)=mean(BO_Far_S{iter});
    BBOONNSS(m)=mean(BO_Near_S{iter});
    
    m=m+1;
end
nCC = [mean(SSFF); mean(SSNN); mean(HHFF); mean(HHNN); mean(BBIINN); mean(BBIIFF); mean(BBOONN); mean(BBOOFF);mean(BBOOFFSS);mean(BBOONNSS)]';

for i=1:length(Mean_Accuracy)
    nMM(i)=mean(Mean_Accuracy{i});
    nST(i)=std(Mean_Accuracy{i});
end
Conf=mat2tmat(Conf);