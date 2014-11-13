clear
    n=112; %size of test set
    %load Driving_Eventsfix1
    load Driving_Events_Aug_2012.mat
    Driving_Events=fix_annotation_errors_D(Driving_Events);
    Train_Seq=Driving_Events(1:end-n)';
    Test_Seq=Driving_Events(end-n+1:end)';

ST=length(Train_Seq);
n=0;
TT=1;
k=0;
m=1;c=1;
EV ={'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'};

%load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_10_iterations_500_D_10.mat
%load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_10_iterations_500.mat
%load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_11_iterations_500_D_9.mat
%load All_Topologies_alpha_0.01_gamma_0.05_0.05_0.15_size_10_iterations_500.mat
load All_Topologies_alpha_0.01_0.01_0.01_gamma_0.05_0.05_0.5_size_10_iterations_500_D_6.mat

for i=1:length(All_Topologies)
    for j=1:length(All_Topologies{i}.Level_elements)
    part{i,j}=cellfun(@length,All_Topologies{i}.Tree{j});
    end
end



% for i=1:length(All_Topologies)
%     Tree{i}=getit([getit(part{i,1})...
%         getit(part{i,2})...
%         getit(part{i,3})...
%         getit(part{i,4})...
%         getit(part{i,5})...
%         getit(part{i,6})...
%         getit(part{i,7})...
%         getit(part{i,8})...
%         getit(part{i,9})...
%         getit(part{i,10})]);
%     
% end

for i=1:length(All_Topologies)
    Tree{i}=getit([getit(part{i,1})...
        getit(part{i,2})...
        getit(part{i,3})...
        getit(part{i,4})...
        getit(part{i,5})...
        getit(part{i,6})]);
    
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



%Topology_number=33;
Topology_number=43;

for mcm=Topology_number:Topology_number%1:length(idxOfUnique) %Topology_number:Topology_number %1:length(idxOfUnique) %920 %1:length(idxOfUnique) %1:length(part) %88:88 %%920 is the final number
    mcm/length(idxOfUnique)
    for jjj=1:100
        c=1;
for iter = ST:length(Train_Seq)-n
    
    %iter
 
    l=1;
    for i=1:length(Train_Seq)-n-iter+1
    % FIXED TEST

        Train_S=Train_Seq(i:i+iter-1,:);
        Conf=zeros(10,10);
        Train_T=Compute_Dat2DRIVE(Train_S,All_Topologies{idxOfUnique(mcm)},Tree{idxOfUnique(mcm)});
               
        A = Train_T;
        

 
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
    L_SiRR = length(SiRR(~cellfun(@isempty,SiRR)));L_Sp = length(Sp(~cellfun(@isempty,Sp)))-1;
    
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

AA = [min(SS); min(TTSSTT); min(TTLL); min(TTRR); min(LLRR); min(LLAA); min(LLGG); min(SSLL);min(SSRR);min(SSPP)];
BB = [max(SS); max(TTSSTT); max(TTLL); max(TTRR); max(LLRR); max(LLAA); max(LLGG); max(SSLL);max(SSRR);max(SSPP)];
nCC = [mean(SS); mean(TTSSTT); mean(TTLL); mean(TTRR); mean(LLRR); mean(LLAA); mean(LLGG); mean(SSLL);mean(SSRR);mean(SSPP)];



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
sumnCC=sumnCC+nCC_all{Topology_number,i}';
end


HMLDP_CLHBC_Confmatrix=mat2tmat(summ./100);
HMLDP_CLHBC_EventsPrediction=sumnCC./100;
HMLDP_CLHBC_mean=mean(me(Topology_number,:));
HMLDP_CLHBC_std=std(me(Topology_number,:));

% save HMLDP_CLHBC.mat HMLDP_CLHBC_Confmatrix HMLDP_CLHBC_EventsPrediction HMLDP_CLHBC_mean HMLDP_CLHBC_std