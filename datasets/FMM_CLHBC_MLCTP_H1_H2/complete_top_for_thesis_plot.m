alpha=0.01:0.01;
gamma=0.15:0.05:0.15;


n=20; %size of test set
Vocabulary=main('nswitched');
Vocabulary = fix_annotation_errors(Vocabulary);
Vocabulary(end,:)=[];
permuts=perms(1:1:8);

matFilename = ['top-alpha_' num2str(alpha) '_and_gamma_' num2str(gamma) '.mat'];
load(matFilename);
Topologies=Topologies{end};

coun=1;

Test_S=Vocabulary(end-n+1:end,:);
[Test_T Test_Seq]=Build_master_topology(Test_S);

B = Test_T;
m=1;c=1;





for TTT=1:length(Topologies)
    TTT/length(Topologies)*100
    Transition_Matrix = Topologies{TTT}.TM;
    
    if length(find(Topologies{TTT}.TM>0))>8

    for iter = 77:length(Vocabulary)-n %REMOVE -47 for complete %replace with start with 1 for complete        
        %iter
        l=1;
        JS_Distance=zeros(1,40320);
        for i=1:length(Vocabulary)-n-iter+1 %replace with i:length(Vocabulary)-n-iter+1 for complete
            Train_S=Vocabulary(i:i+iter-1,:);
            [Train_T1 Train_Seq1]=Build_master_topology(Train_S);
            ccc=1;     
                for permutations=1:length(permuts)
                    BJS=Transition_Matrix(permuts(permutations,1:end),permuts(permutations,1:end));
                    AJS=Train_T1;
                    JS_Distance(ccc)=(abs(KLDiv(AJS(:)',BJS(:)'))+abs(KLDiv(AJS(:)',BJS(:)')))/2;
                    ccc=ccc+1; 
                end
                
                %InD = 4252;
                [~, InD]=min(JS_Distance);

                Train_T.TM=Transition_Matrix(permuts(InD,1:end),permuts(InD,1:end));
     
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
                Individual_Accuracy = [mean(Serve_Far{iter}(i)) mean(Serve_Near{iter}(i)) mean(Hit_Far{iter}(i)) mean(Hit_Near{iter}(i)) mean(BI_Near{iter}(i)) mean(BI_Far{iter}(i)) mean(BO_Near{iter}(i)) mean(BO_Far{iter}(i))];
                Mean_Accuracy{TTT}{iter}(i) = mean(Individual_Accuracy);
                l=l+1;
            end
            c=c+1;
        %    SSFF(m)=mean(Serve_Far{iter});SSNN(m)=mean(Serve_Near{iter});
        %    HHFF(m)=mean(Hit_Far{iter});HHNN(m)=mean(Hit_Near{iter});
        %    BBIINN(m)=mean(BI_Near{iter});BBIIFF(m)=mean(BI_Far{iter});
        %    BBOONN(m)=mean(BO_Near{iter});BBOOFF(m)=mean(BO_Far{iter});
            m=m+1;
            
        %for ZzZ=1:length(Mean_Accuracy{c-1})
        %    nMM(ZzZ)=mean(Mean_Accuracy{c-1});
        %    nST(ZzZ)=std(Mean_Accuracy{c-1});
        %end
            
        %Final_output{TTT}{iter}=nMM;                    
        
        end
        

        
    end
end