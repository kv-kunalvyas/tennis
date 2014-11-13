clear
    load Activity_Dataset.mat
    Train_Seq = Activity_Dataset(1:500);
    Test_Seq = Activity_Dataset(501:end);

[cza Test_T]=Activity_test_CLHBC(Test_Seq);
ST=length(Train_Seq);
n=0;
TT=1;
k=0;
m=1;c=1;
EV = {' 1';' 2';' 3';' 4';' 5';' 6';' 7';' 8';' 9';'10';'11'};

%load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_10_iterations_500.mat
load All_Topologies_alpha_0.01_0.01_0.01_gamma_0.05_0.05_0.5_size_11_iterations_500_D_11.mat




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
        getit(part{i,10})...
        getit(part{i,11})]);
    
end




mc=Tree;
mcs = cellfun(@(x)(mat2str(cell2mat(x))),mc,'uniformoutput',false);
[uniqueCells,idxOfUnique,idxYouWant] = unique(mcs);
for i=1:length(uniqueCells)
A{i}=str2num(uniqueCells{i}(2:end-1));
end

%Topology_number=33;
Topology_number=133;

Topology_number=99;
for mcm=Topology_number%1:length(idxOfUnique)%228:length(idxOfUnique) %Topology_number:Topology_number %1:length(idxOfUnique) %920 %1:length(idxOfUnique) %1:length(part) %88:88 %%920 is the final number
    mcm/length(idxOfUnique)
    for jjj=1:100
        c=1;
for iter = ST:length(Train_Seq)-n
    
    %iter
 
    l=1;
    for i=1:length(Train_Seq)-n-iter+1
    % FIXED TEST

        Train_S=Train_Seq(i:i+iter-1,:);
        Conf=zeros(11,11);
        Train_T=Compute_Dat2ACTIVITY(Train_S,All_Topologies{idxOfUnique(mcm)},Tree{idxOfUnique(mcm)});
               
        A = Train_T;
        

 
Ts=zeros(11,11);
        k=0;
        
        sfl=0; sfr=0; snl=0; snr=0; hf=0; hn=0; bin=0; bif=0; bon=0; bof=0;
        binsl=0;
        
        for j=1:length(Test_Seq)-1
            Ts=zeros(11,11);
            if strcmp(Test_Seq{j},' 1')
                Ts = A;
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(1,1)=Conf(1,1)+1; k=k+1; sfl=sfl+1; else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},' 2')
                Ts(1,:) = A(2,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(2,2)=Conf(2,2)+1; k=k+1; sfr=sfr+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},' 3')
                Ts(1,:) = A(3,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(3,3)=Conf(3,3)+1; k=k+1; snl=snl+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},' 4')
                Ts(1,:) = A(4,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(4,4)=Conf(4,4)+1; k=k+1; snr=snr+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},' 5')
                Ts(1,:) = A(5,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(5,5)=Conf(5,5)+1; k=k+1; hf=hf+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},' 6')
                Ts(1,:) = A(6,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}), Conf(6,6)=Conf(6,6)+1;k=k+1; hn=hn+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},' 7')
                Ts(1,:) = A(7,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(7,7)=Conf(7,7)+1; k=k+1; bin=bin+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                
            elseif strcmp(Test_Seq{j},' 8')
                Ts(1,:) = A(8,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(8,8)=Conf(8,8)+1; k=k+1; bif=bif+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
            
            
            elseif strcmp(Test_Seq{j},' 9')
                Ts(1,:) = A(9,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(9,9)=Conf(9,9)+1; k=k+1; bon=bon+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'10')
                Ts(1,:) = A(10,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(10,10)=Conf(10,10)+1; k=k+1; bof=bof+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            elseif strcmp(Test_Seq{j},'11')
                Ts(1,:) = A(11,:);
                [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1 1 1 1]','Statenames',EV);
                NNN=strfind(EV,char(Test_Seq{j+1})); iidn=find(~cellfun(@isempty,NNN)>0);
                MMM=strfind(EV,char(St)); iid=find(~cellfun(@isempty,MMM)>0);
                if strcmp(St,Test_Seq{j+1}),Conf(11,11)=Conf(11,11)+1; k=k+1; binsl=binsl+1;  else Conf(iidn,iid)=Conf(iidn,iid)+1; end
                         
            
            end
        end
        
        SFL = strfind(Test_Seq,' 1');
        SFR = strfind(Test_Seq,' 2');
        SNL = strfind(Test_Seq,' 3');
        SNR = strfind(Test_Seq,' 4');
        
        HF = strfind(Test_Seq,' 5');
        HN = strfind(Test_Seq,' 6');
        
        BIN = strfind(Test_Seq,' 7');
        BIF = strfind(Test_Seq,' 8');
        BON = strfind(Test_Seq,' 9');
        BOF = strfind(Test_Seq,'10');
        
        BINSL = strfind(Test_Seq,'11');
        
        L_SFL = length(SFL(~cellfun(@isempty,SFL)));
        L_SFR = length(SFR(~cellfun(@isempty,SFR)));
        L_SNL = length(SNL(~cellfun(@isempty,SNL)));
        L_SNR = length(SNR(~cellfun(@isempty,SNR)));
        
        L_HF = length(HF(~cellfun(@isempty,HF)));
        L_HN = length(HN(~cellfun(@isempty,HN)));
        
        L_BIN = length(BIN(~cellfun(@isempty,BIN)));
        L_BIF = length(BIF(~cellfun(@isempty,BIF)));
        L_BON = length(BON(~cellfun(@isempty,BON)));
        L_BOF = length(BOF(~cellfun(@isempty,BOF)));
        
        L_BINSL = length(BINSL(~cellfun(@isempty,BINSL)));
        
        if sfl>0 Serve_Far_Left{iter}(i) = sfl/L_SFL * 100; else Serve_Far_Left{iter}(i)=0; end
        if sfr>0 Serve_Far_Right{iter}(i) = sfr/L_SFR * 100; else Serve_Far_Right{iter}(i)=0; end
        if snl>0 Serve_Near_Left{iter}(i) = snl/L_SNL * 100; else Serve_Near_Left{iter}(i)=0; end
        if snr>0 Serve_Near_Right{iter}(i) = snr/L_SNR * 100; else Serve_Near_Right{iter}(i)=0; end
        
        if hf>0 Hit_Far{iter}(i) = hf/L_HF * 100; else Hit_Far{iter}(i)=0; end
        if hn>0 Hit_Near{iter}(i) = hn/L_HN * 100; else Hit_Near{iter}(i)=0; end
        
        if bin>0 BI_Near{iter}(i) = bin/L_BIN * 100; else BI_Near{iter}(i)=0;  end
        if bif>0 BI_Far{iter}(i) = bif/L_BIF * 100; else BI_Far{iter}(i)=0;  end
        if bon>0 BO_Near{iter}(i) = bon/L_BON * 100; else BO_Near{iter}(i)=0; end
        if bof>0 BO_Far{iter}(i) = bof/L_BOF * 100; else BO_Far{iter}(i)=0;  end
        
        if binsl>0 BI_Near_SL{iter}(i) = binsl/L_BINSL * 100; else BI_Near_SL{iter}(i)=0;  end
        
        clear sfl sfr snl snr hf hn bif bin bof bon binsl bifsl L_SFL L_SFR L_SNL L_SNR L_HF L_HN L_BIF L_BIN L_BOF L_BON L_BINSL 
        
        Sim(i) = k/(length(Test_Seq)-1);
        
        Individual_Accuracy = [mean(Serve_Far_Left{iter}(i)) mean(Serve_Far_Right{iter}(i)) mean(Serve_Near_Left{iter}(i)) mean(Serve_Near_Right{iter}(i))...
            mean(Hit_Far{iter}(i)) mean(Hit_Near{iter}(i)) mean(BI_Near{iter}(i)) mean(BI_Far{iter}(i)) mean(BO_Near{iter}(i)) mean(BO_Far{iter}(i)) ...
            mean(BI_Near_SL{iter}(i))];
        
        Mean_Accuracy{c}(l) = mean(Individual_Accuracy);
        l=l+1;
      
    end
    c=c+1;
    
    SSFFLL(m)=mean(Serve_Far_Left{iter});
    SSFFRR(m)=mean(Serve_Far_Right{iter});
    SSNNLL(m)=mean(Serve_Near_Left{iter});
    SSNNRR(m)=mean(Serve_Near_Right{iter});
    
    HHFF(m)=mean(Hit_Far{iter});
    HHNN(m)=mean(Hit_Near{iter});
    
    BBIINN(m)=mean(BI_Near{iter});
    BBIIFF(m)=mean(BI_Far{iter});
    BBOONN(m)=mean(BO_Near{iter});
    BBOOFF(m)=mean(BO_Far{iter});
    
    BBIINNSSLL(m)=mean(BI_Near_SL{iter});
    m=m+1;
end
nCC = [mean(SSFFLL); mean(SSFFRR); mean(SSNNLL); mean(SSNNRR); mean(HHFF); mean(HHNN); mean(BBIINN); mean(BBIIFF); mean(BBOONN); mean(BBOOFF); mean(BBIINNSSLL)]';

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

summ=zeros(11,11);
sumnCC=zeros(1,11);
for i=1:100
summ=summ+Confusion_matrices{Topology_number,i};
sumnCC=sumnCC+nCC_all{Topology_number,i};
end


AMLDP_CLHBC_Confmatrix=mat2tmat(summ./100);
AMLDP_CLHBC_EventsPrediction=sumnCC./100;
AMLDP_CLHBC_mean=mean(me(Topology_number,:));
AMLDP_CLHBC_std=std(me(Topology_number,:));

% save AMLDP_CLHBC.mat AMLDP_CLHBC_Confmatrix AMLDP_CLHBC_EventsPrediction AMLDP_CLHBC_mean AMLDP_CLHBC_std
