%EV3 - Predictive Capability
clear
n=20; %size of test set
Vocabulary=main('nswitched');
Vocabulary = fix_annotation_errors(Vocabulary);
Vocabulary(end,:)=[];
% Topologies=runner;
% save topolo.mat Topologies

load topolo.mat
Test_S=Vocabulary(end-n+1:end,:);
[Test_T Test_Seq]=Build_master_topology(Test_S);
B = Test_T;
for top = 1:length(Topologies)
m=1;c=1;




    top
    for iter = 1:length(Vocabulary)-n %REMOVE -47 for complete
    %iter
    
 
    l=1;
    for i=1:length(Vocabulary)-n-iter+1
    % FIXED TEST

        Train_S=Vocabulary(i:i+iter-1,:);
        %Train_T=find_best_topology(Topologies,Train_S);
        Train_T.TM = Topologies{top}.TM;
        A = Train_T.TM;
    

Ts=zeros(8,8);
k=0;
sf=0; sn=0; hf=0; hn=0; bif=0; bin=0; bof=0;bon=0;
    for j=1:length(Test_Seq)-1
        Ts=zeros(8,8);
        if strcmp(Test_Seq{j},'SF')
            Ts = A;
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; sf=sf+1; end
        
        elseif strcmp(Test_Seq{j},'SN')
            Ts(1,:) = A(2,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; sn=sn+1; end
            
        
        elseif strcmp(Test_Seq{j},'HF')
            Ts(1,:) = A(3,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; hf=hf+1; end
        
        
        elseif strcmp(Test_Seq{j},'HN')
            Ts(1,:) = A(4,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; hn=hn+1; end
           
    
        elseif strcmp(Test_Seq{j},'BIN')
            Ts(1,:) = A(5,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; bin=bin+1; end
    
    
        elseif strcmp(Test_Seq{j},'BIF')
            Ts(1,:) = A(6,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; bif=bif+1; end
    
    
        elseif strcmp(Test_Seq{j},'BON')
            Ts(1,:) = A(7,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; bon=bon+1; end
            
    
        elseif strcmp(Test_Seq{j},'BOF')
            Ts(1,:) = A(8,:);
            [Se,St] = hmmgenerate(1,Ts,[1 1 1 1 1 1 1 1]','Statenames',{'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'});
            if strcmp(St,Test_Seq{j+1}), k=k+1; bof=bof+1; end
        end    
        
    end
    
    SF = strfind(Test_Seq,'SF');
    SN = strfind(Test_Seq,'SN');
    HF = strfind(Test_Seq,'HF');
    HN = strfind(Test_Seq,'HN');
    BIF = strfind(Test_Seq,'BIF');
    BIN = strfind(Test_Seq,'BIN');
    BOF = strfind(Test_Seq,'BOF');
    BON = strfind(Test_Seq,'BON');
    
    L_SF = length(SF(~cellfun(@isempty,SF)));
    L_SN = length(SN(~cellfun(@isempty,SN)));
    L_HF = length(HF(~cellfun(@isempty,HF)));
    L_HN = length(HN(~cellfun(@isempty,HN)));
    L_BIF = length(BIF(~cellfun(@isempty,BIF)))-1;
    L_BIN = length(BIN(~cellfun(@isempty,BIN)));
    L_BOF = length(BOF(~cellfun(@isempty,BOF)));
    L_BON = length(BON(~cellfun(@isempty,BON)));
    
    if sf>0 Serve_Far{iter}(i) = sf/L_SF * 100; else Serve_Far{iter}(i)=0; end
    if sn>0 Serve_Near{iter}(i) = sn/L_SN * 100; else Serve_Near{iter}(i)=0; end
    if hf>0 Hit_Far{iter}(i) = hf/L_HF * 100; else Hit_Far{iter}(i)=0; end
    if hn>0 Hit_Near{iter}(i) = hn/L_HN * 100; else Hit_Near{iter}(i)=0; end
    if bif>0 BI_Far{iter}(i) = bif/L_BIF * 100; else BI_Far{iter}(i)=0;  end
    if bin>0 BI_Near{iter}(i) = bin/L_BIN * 100; else BI_Near{iter}(i)=0;  end
    if bof>0 BO_Far{iter}(i) = bof/L_BOF * 100; else BO_Far{iter}(i)=0;  end
    if bon>0 BO_Near{iter}(i) = bon/L_BON * 100; else BO_Near{iter}(i)=0; end
    clear sf sn hf hn bif bin bof bon L_SF L_SN L_HF L_HN L_BIF L_BIN L_BOF L_BON
       
    Sim(i) = k/(length(Test_Seq)-1);    
    
    Individual_Accuracy = [mean(Serve_Far{iter}(i)) mean(Serve_Near{iter}(i)) mean(Hit_Far{iter}(i)) mean(Hit_Near{iter}(i)) mean(BI_Near{iter}(i)) mean(BI_Far{iter}(i)) mean(BO_Near{iter}(i)) mean(BO_Far{iter}(i))];   
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
m=m+1;
end

AA = [min(SSFF); min(SSNN); min(HHNN); min(HHFF); min(BBIIFF); min(BBIINN); min(BBOOFF); min(BBOONN)];
BB = [max(SSFF); max(SSNN); max(HHNN); max(HHFF); max(BBIIFF); max(BBIINN); max(BBOOFF); max(BBOONN)];
nCC = [mean(SSFF); mean(SSNN); mean(HHNN); mean(HHFF); mean(BBIIFF); mean(BBIINN); mean(BBOOFF); mean(BBOONN)];

b = nCC';
% errdata=BB'-AA';
% figure, hold on
% bar(b)
% errorbar(1:8,b,errdata,'xr') 
% set(gca,'XTick',1:8)
% set(gca,'xTickLabel',{'SF'; 'SN' ; 'HF' ; 'HN' ; 'BIF' ; 'BIN' ; 'BOF' ; 'BON'})
% 
% a = colormap(hot);
% b = a(end-50:-10:30,:);
% colormap(b)

for i=1:length(Mean_Accuracy)
    nMM(i)=mean(Mean_Accuracy{i});
    nST(i)=std(Mean_Accuracy{i});
end

me(top)=mean(nMM)

end


% figure, errorbar(nMM,nST)
% axis([0 80 0 100])
% save DP.mat nMM nST nCC
