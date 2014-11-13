clear
load Tennis_ACASVA.mat
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
n=0; %size of test set
ST=length(Vocabulary1);
TT=1;
k=0;
m=1;c=1;
Test_S=Vocabulary2;
[UN1 Test_Seq] = Build_master_topology_Tennis_10events(Test_S);
    
EV = {'SF'; 'SN'; 'HF'; 'HN'; 'BIN'; 'BIF'; 'BON' ;'BOF';'BOFS';'BONS'};
Conf=zeros(10,10);

%load twolevels_topologies.mat
%load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_10_iterations_500.mat
%load All_Topologies_alpha_0.01_gamma_0.05_0.05_0.2_size_10_iterations_500.mat
%load All_Topologies_alpha_0.01_gamma_0.05_0.05_0.15_size_10_iterations_500.mat
load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_10_iterations_500_D_10.mat

for i=1:length(All_Topologies)
    for j=1:length(All_Topologies{i}.Level_elements)
    part{i,j}=cellfun(@length,All_Topologies{i}.Tree{j});
    end
end



for i=1:length(All_Topologies)
    Tree{i}=getit([getit(part{i,1})...
        getit(part{i,2})...
        getit(part{i,3})...
        getit(part{i,4})...
        getit(part{i,5})...
        getit(part{i,6})...
        getit(part{i,7})...
        getit(part{i,8})...
        getit(part{i,9})...
        getit(part{i,10})]);
    
end

% for i=1:length(All_Topologies)
%     Tree{i}=getit([getit(part{i,1})...
%         getit(part{i,2})...
%         getit(part{i,3})...
%         getit(part{i,4})]);
%     
% end

mc=Tree;
mcs = cellfun(@(x)(mat2str(cell2mat(x))),mc,'uniformoutput',false);
[uniqueCells,idxOfUnique,idxYouWant] = unique(mcs);
for i=1:length(uniqueCells)
A{i}=str2num(uniqueCells{i}(2:end-1));
end

%  k=1;
%  for i=1:length(idxOfUnique)
%      if ~isequal(All_Topologies{idxOfUnique(i)}.Level_elements,[1 10])
%          emptyidx(k)=i;
%          k=k+1;
%      end
%  end
%  clear k
%  
%  idxOfUnique(emptyidx)=[];



%Topology_number=49;
%Topology_number=887;
%Topology_number=4;
%Topology_number=108;
%Topology_number=33;
%Topology_number=133;%19;
Topology_number=431;
for mcm=Topology_number%360:length(idxOfUnique) %Topology_number:Topology_number %1:length(idxOfUnique) %920 %1:length(idxOfUnique) %1:length(part) %88:88 %%920 is the final number
    mcm/length(idxOfUnique)
    for jjj=1:100
        c=1;
for iter = length(Vocabulary1)-n:length(Vocabulary1)-n
    
    %iter
 
    l=1;
    for i=1:length(Vocabulary1)-n-iter+1
    % FIXED TEST

        Train_S=Vocabulary1(i:i+iter-1,:);
        
        Train_T=Compute_Dat2TENNIS(Train_S,All_Topologies{idxOfUnique(mcm)},Tree{idxOfUnique(mcm)});
               
        A = Train_T;
        

 
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
                if strcmp(St,Test_Seq{j+1}), Conf(1,1)=Conf(1,1)+1; k=k+1; sf=sf+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'SN')
                Ts(1,:) = A(2,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(2,2)=Conf(2,2)+1; k=k+1; sn=sn+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'HF')
                Ts(1,:) = A(3,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(3,3)=Conf(3,3)+1; k=k+1; hf=hf+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'HN')
                Ts(1,:) = A(4,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(4,4)=Conf(4,4)+1;k=k+1; hn=hn+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'BIN')
                Ts(1,:) = A(5,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(5,5)=Conf(5,5)+1; k=k+1; bin=bin+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},'BIF')
                Ts(1,:) = A(6,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(6,6)=Conf(6,6)+1; k=k+1; bif=bif+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
            
            
            elseif strcmp(Test_Seq{j},'BON')
                Ts(1,:) = A(7,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(7,7)=Conf(7,7)+1; k=k+1; bon=bon+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'BOF')
                Ts(1,:) = A(8,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(8,8)=Conf(8,8)+1; k=k+1; bof=bof+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'BOFS')
                Ts(1,:) = A(9,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(9,9)=Conf(9,9)+1; k=k+1; bofs=bofs+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
            
             elseif strcmp(Test_Seq{j},'BONS')
                Ts(1,:) = A(10,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(10,10)=Conf(10,10)+1; k=k+1; bons=bons+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
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

Confusion_matrices{mcm,jjj}=mat2tmat(Conf);
nCC_all{mcm,jjj}=nCC;
me(mcm,jjj)=mean(nMM);
   clear nMM Mean_Accuracy
    end
     [max(mean(me')) mean(me(mcm,:))]
end

Conf=mat2tmat(Conf);

% figure, errorbar(nMM,nST)
% axis([0 80 0 100])
% save DP.mat nMM nST nCC

summ=zeros(10,10);
sumnCC=zeros(1,10);
for i=1:100
summ=summ+Confusion_matrices{Topology_number,i};
sumnCC=sumnCC+nCC_all{Topology_number,i};
end


T2MLDP_CLHBC_Confmatrix=mat2tmat(summ./100);
T2MLDP_CLHBC_EventsPrediction=sumnCC./100;
T2MLDP_CLHBC_mean=mean(me(Topology_number,:));
T2MLDP_CLHBC_std=std(me(Topology_number,:));

% save T2MLDP_CLHBC.mat T2MLDP_CLHBC_Confmatrix T2MLDP_CLHBC_EventsPrediction T2MLDP_CLHBC_mean T2MLDP_CLHBC_std
