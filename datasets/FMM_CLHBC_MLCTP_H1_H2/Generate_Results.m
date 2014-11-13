%VERSION 1.0 (I will try and release version 1.1 soon with a major
%clean-up.


%To generate topologies for MLCTP - go to folder MLCTP_Topology_creation
%folder and run MLCTP_Topology_Generator (specify alpha and gamma inside
%that code (or the range of these hyperparameters - It will generate a mat
%file with a collection of topologies which either needs copying over to
%this folder or adding MLCTP_Topology_creation folder as
%addpath('./MLCTP_Topology_Generator'). 

%Unfortunately source footage files are not present in this folder due to 
%restrictions. However, annotated features are present in the dataset 
%folder that could be used in conjunction with this code. In principle any
%sequential data can be presented to this code for rule induction. This may
%require minor tweaks to be made to the code. In the next version, I hope
%to make this code more generally useable on all types of sequential data.

%Source activity and MSNBC.com datasets are available at the UCI 
%repository; It's filtered version is in the dataset folder.

%Example 
%Generate_Results(5,1) %for Activity dataset with Flat MM
%Generate_Results(1,2) %for Badminton using CLHBC

function Generate_Results(filenumber,Method)
%filenumber: 1 for Badminton, 2 for tennis, 3 for Tennis, 4 for MSN, 5 for Activity 6 for Driver
%method: 1 for Flat MM, 1.5 for tennis_10events 2 for CLHBC, 3 for DP-LR, 4 for DP-Relaxed
addpath(genpath('.'))
if filenumber==1
    n=20; %size of test set
    Vocabulary=main('nswitched'); %Data available by request (contact for details)
    Vocabulary = fix_annotation_errors(Vocabulary);
    Vocabulary(end,:)=[];
    permuts=perms(1:1:8);
    
    if Method==1
        disp('Badminton + FlatMM')
        
        %[BFMM BFSD BFBar BFConf ] = FlatMM_Badminton(Vocabulary,n,1); %Flat for start till end (with changing training data)
        [BFMM_Best Ignore BFBar_Best BFConf_Best] = FlatMM_Badminton(Vocabulary,n,length(Vocabulary)-n) %For whole data
        
        %save Badminton_Flat_Results.mat BFMM BFSD BFBar BFConf BFMM_Best BFBar_Best BFConf_Best
        
        %IF YOU WANT TO EVALUATE RUN THIS!
        % for i=1:100
        % [BFMM_Best(i) Ignore BFBar_Best{i} BFConf_Best{i}] = FlatMM_Badminton(Vocabulary,n,length(Vocabulary)-n);
        % end
        
        %Fsumm=zeros(8,8);
        %FsumnCC=zeros(1,8);
        %FsumMM=0;
        %for i=1:100
        %    Fsumm=Fsumm+BFConf_Best{i};
        %    FsumnCC=FsumnCC+BFBar_Best{i};
        %end
        
        
        %Flat_Confmatrix=mat2tmat(Fsumm./100);
        %Flat_EventsPrediction=FsumnCC./100;
        %Flat_mean=mean(BFMM_Best);
        %Flat_std=std(BFMM_Best);
        
        
        %         save Flat.mat Flat_Confmatrix Flat_EventsPrediction Flat_mean Flat_std
        
        
        
        
    elseif Method==2
        disp('Badminton + CLHBC')
        load Voc_for_generalized_CP
        %[BCMM BCSD BCBar BCConf] = CLHBC_Badminton(Voc,n,1,1);
        [BCMM_Best Ignore BCBar_Best BCConf_Best] = CLHBC_Badminton(Voc,n,1,length(Voc)-n)
        
        %save Badminton_CLHBC_Results.mat BCMM BCSD BCBar BCConf BCMM_Best BCBar_Best BCConf_Best
        
        
        %         for i=1:100
        % [BCMM_Best(i) Ignore BCBar_Best{i} BCConf_Best{i}] = CLHBC_Badminton(Voc,n,1,length(Voc)-n);
        % end
        
%         Csumm=zeros(8,8);
%         CsumnCC=zeros(1,8);
%         CsumMM=0;
%         for i=1:100
%             Csumm=Csumm+BCConf_Best{i};
%             CsumnCC=CsumnCC+BCBar_Best{i};
%         end
%         
%         
%         CLHBC_Confmatrix=mat2tmat(Csumm./100);
%         CLHBC_EventsPrediction=CsumnCC./100;
%         CLHBC_mean=mean(BCMM_Best);
%         CLHBC_std=std(BCMM_Best);
        
        
        %         save CLHBC.mat CLHBC_Confmatrix CLHBC_EventsPrediction CLHBC_mean CLHBC_std
        %
        
        
        
        
        
        
        
        
        
%         
%     elseif Method==3
%         disp('Badminton + DP')
%         sizes=8;
%         permuts = perms(1:sizes);
%         load Voc_for_generalized_CP %DATA NOT AVAILABLE CONTACT FOR DETAILS
%         matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
%             num2str(sizes) '_iterations_500.mat'];
%         load(matfilename);
%         for i=1:length(All_Topologies)-length(All_Topologies)+1
%             i/length(All_Topologies)
%             [DPMM_Best{i} ignore DPBar_Best{i} DPConf_Best{i} InD{i}]=complete_top_replacedperm(All_Topologies{i},Vocabulary,permuts,n,Voc,length(Vocabulary)-n);
%             %[DPMM{i} DPSD{i} DPBar{i} DPConf{i}]=complete_top(All_Topologies{i},Vocabulary,permuts,n,Voc,1,InD{i});
%             
%             %save Badminton_DP_Results.mat DPMM_Best DPBar_Best DPConf_Best
%         end
%         
        
%                         for i=1:100
%         [BDMM_Best(i) Ignore BDBar_Best{i} BDConf_Best{i}] = complete_top_replacedperm(All_Topologies{1},Vocabulary,permuts,n,Voc,length(Vocabulary)-n);
%         end
        
%         Dsumm=zeros(8,8);
%         DsumnCC=zeros(1,8);
%         DsumMM=0;
%         for i=1:100
%             Dsumm=Dsumm+BDConf_Best{i};
%             DsumnCC=DsumnCC+BDBar_Best{i}';
%         end
%         
%         
%         MLDP_Confmatrix=mat2tmat(Dsumm./100);
%         MLDP_EventsPrediction=DsumnCC./100;
%         MLDP_mean=mean(BDMM_Best);
%         MLDP_std=std(BDMM_Best);
%         
        
        %         save MLDP.mat MLDP_Confmatrix MLDP_EventsPrediction MLDP_mean MLDP_std
        %
        
        
    elseif Method==3
        disp('Badminton + DP')
        sizes=8;
        permuts = perms(1:sizes);
        load Voc_for_generalized_CP
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat']; %Generate topologies first (MLCTP_Topology_creation)
        load(matfilename);
        load twolevels_topologies.mat
        load All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_8_iterations_500.mat
        for i=1:length(All_Topologies)
            for j=1:length(All_Topologies{i}.Level_elements)
                part{i,j}=cellfun(@length,All_Topologies{i}.Tree{j});
            end
        end
        for i=1:length(All_Topologies)
            Tree{i}=getit([getit(part{i,1})...
                getit(part{i,2})...
                getit(part{i,3})...
                getit(part{i,4})]);
            
        end
        mc=Tree;
        mcs = cellfun(@(x)(mat2str(cell2mat(x))),mc,'uniformoutput',false);
        [uniqueCells,idxOfUnique,idxYouWant] = unique(mcs);
        for i=1:length(uniqueCells)
            A{i}=str2num(uniqueCells{i}(2:end-1));
        end
        
        for i=1:length(idxOfUnique)
            i/length(idxOfUnique)
            [DPMM(i) DPSD{i} DPBar{i} DPConf{i}]=complete_top_replacedperm_DPHMM(All_Topologies{idxOfUnique(i)},Tree{idxOfUnique(i)},Vocabulary,permuts,n,Voc,length(Vocabulary)-n);
        end
                
%                         for i=1:100
%         [BDMM_Best(i) Ignore BDBar_Best{i} BDConf_Best{i}] = complete_top_replacedperm_DPHMM(All_Topologies{idxOfUnique(434)},Tree{idxOfUnique(434)},Vocabulary,permuts,n,Voc,length(Vocabulary)-n);
%         end
        
%         Dsumm=zeros(8,8);
%         DsumnCC=zeros(1,8);
%         DsumMM=0;
%         for i=1:100
%             Dsumm=Dsumm+BDConf_Best{i};
%             DsumnCC=DsumnCC+BDBar_Best{i}';
%         end
%         
%         
%         MLDP_Confmatrix=mat2tmat(Dsumm./100);
%         MLDP_EventsPrediction=DsumnCC./100;
%         MLDP_mean=mean(BDMM_Best);
%         MLDP_std=std(BDMM_Best);
        
        
        %         save MLDP.mat MLDP_Confmatrix MLDP_EventsPrediction MLDP_mean MLDP_std
        %
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    end
    
elseif filenumber==2
    
    n=0;
    
    %     if Method==1
    %         load Tennis_Vocabulary
    %         disp('Tennis + FlatMM')
    %         [TFMM TFSD TFBar TFConf ] = FlatMM_Tennis(Vocabulary1,Vocabulary2,n,1);
    %         [TFMM_Best Ignore TFBar_Best TFConf_Best] = FlatMM_Tennis(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
    %         save Tennis_Flat_Results.mat TFMM TFSD TFBar TFConf TFMM_Best TFBar_Best TFConf_Best
    %
    if Method==1 %10 EVENTS
        load Tennis_Vocabulary %Data available by request (contact for details)
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        disp('Tennis + FlatMM_10events')
        %[TFMM10 TFSD10 TFBar10 TFConf10 ] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,1);
        [TFMM_Best10 Ignore TFBar_Best10 TFConf_Best10] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,length(Vocabulary1))
%         save Tennis_Flat_Results10.mat TFMM10 TFSD10 TFBar10 TFConf10 TFMM_Best10 TFBar_Best10 TFConf_Best10
        
        %     elseif Method==2
        %         load Tennis_Vocabulary
        %         disp('Tennis + CLHBC')
        %         [TCMM TCSD TCBar TCConf] = CLHBC_Tennis(Vocabulary1,Vocabulary2,n,1);
        %         [TCMM_Best Ignore TCBar_Best TCConf_Best] = CLHBC_Tennis(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
        %         save Tennis_CLHBC_Results.mat TCMM TCSD TCBar TCConf TCMM_Best TCBar_Best TCConf_Best
        
        
%          for i=1:100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
%          end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i};
%         end
%         
%         
%         TFlat_Confmatrix=mat2tmat(Fsumm./100);
%         TFlat_EventsPrediction=FsumnCC./100;
%         TFlat_mean=mean(TFMM_Best);
%         TFlat_std=std(TFMM_Best);
%         
        
        %         save T1Flat.mat TFlat_Confmatrix TFlat_EventsPrediction TFlat_mean TFlat_std
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    elseif Method==2 %10events
        disp('Tennis + CLHBC10')
        load Tennis_Vocabulary %DATA NOT AVAILABLE CONTACT FOR DETAILS
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        %[TCMM10 TCSD10 TCBar10 TCConf10 ] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
        [TCMM_Best10 Ignore TCBar_Best10 TCConf_Best10] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1))
%         save Tennis_CLHBC_Results10.mat TCMM10 TCSD10 TCBar10 TCConf10 TCMM_Best10 TCBar_Best10 TCConf_Best10
        
        
        
%          for i=1:100
%          [TCMM_Best(i) Ignore TCBar_Best{i} TCConf_Best{i}] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
%          end
        
        
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TCConf_Best{i};
%             FsumnCC=FsumnCC+TCBar_Best{i};
%         end
%         
%         
%         TCLHBC_Confmatrix=mat2tmat(Fsumm./100);
%         TCLHBC_EventsPrediction=FsumnCC./100;
%         TCLHBC_mean=mean(TCMM_Best);
%         TCLHBC_std=std(TCMM_Best);
%         
        
        %         save T1CLHBC.mat TCLHBC_Confmatrix TCLHBC_EventsPrediction TCLHBC_mean TCLHBC_std
        
        
        

    elseif Method==3
        disp('Tennis + DP')
        sizes=10;
        load Tennis_Vocabulary
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        permuts = perms(1:sizes);
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat'];
        load(matfilename);
        for i=1:1 %length(All_Topologies)
            i/length(All_Topologies)
            [TDPMM_Best10{i} ignore TDPBar_Best10{i} TDPConf_Best10{i} TInD10{i}]=complete_top_replacedperm_T(All_Topologies{i},Vocabulary1,Vocabulary2,permuts,length(Vocabulary1)-n);
            %[DPMM{i} DPSD{i} DPBar{i} DPConf{i}]=complete_top(All_Topologies{i},Vocabulary,permuts,n,Voc,1,InD{i});
%             save Tennis_DP_Results.mat TDPMM_Best10 TDPBar_Best10 TDPConf_Best10
        end
     
        
        
%           for i=1:100
%           [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_replacedperm_T(All_Topologies{56},Vocabulary1,Vocabulary2,permuts,length(Vocabulary1)-n);
%           end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TDConf_Best{i};
%             FsumnCC=FsumnCC+TDBar_Best{i};
%         end
%         
%         
%         TD_Confmatrix=mat2tmat(Fsumm./100);
%         TD_EventsPrediction=FsumnCC./100;
%         TD_mean=mean(TDMM_Best);
%         TD_std=std(TCMM_Best);
        
        
        %         save T1D.mat TD_Confmatrix TD_EventsPrediction TD_mean TD_std
        
                
        
        
        
        
        
        
        
             
        
        
        
        
        
        
    end
    
elseif filenumber==3
    
    n=0;
    
   if Method==1 %10 EVENTS
        load Tennis_ACASVA.mat %DATA AVAILABLE BY REQUEST (CONTACT FOR DETAILS)
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        disp('Tennis + FlatMM_10events')
        %[TFMM10 TFSD10 TFBar10 TFConf10 ] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,1);
        [TFMM_Best10 Ignore TFBar_Best10 TFConf_Best10] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,length(Vocabulary1))
        %save Tennis_Flat_Results10.mat TFMM10 TFSD10 TFBar10 TFConf10 TFMM_Best10 TFBar_Best10 TFConf_Best10
        
        %     elseif Method==2
        %         load Tennis_Vocabulary
        %         disp('Tennis + CLHBC')
        %         [TCMM TCSD TCBar TCConf] = CLHBC_Tennis(Vocabulary1,Vocabulary2,n,1);
        %         [TCMM_Best Ignore TCBar_Best TCConf_Best] = CLHBC_Tennis(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
        %         save Tennis_CLHBC_Results.mat TCMM TCSD TCBar TCConf TCMM_Best TCBar_Best TCConf_Best
        
        
%          for i=1:100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = FlatMM_Tennis_10events(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
%          end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i};
%         end
%         
%         
%         T2Flat_Confmatrix=mat2tmat(Fsumm./100);
%         T2Flat_EventsPrediction=FsumnCC./100;
%         T2Flat_mean=mean(TFMM_Best);
%         T2Flat_std=std(TFMM_Best);
        
        
        %         save T2Flat.mat T2Flat_Confmatrix T2Flat_EventsPrediction T2Flat_mean T2Flat_std
        
    elseif Method==2 %10events
        disp('Tennis + CLHBC10')
        load Tennis_ACASVA.mat
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        
        %[TCMM10 TCSD10 TCBar10 TCConf10 ] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
        [TCMM_Best10 Ignore TCBar_Best10 TCConf_Best10] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1))
        %save Tennis_CLHBC_Results10.mat TCMM10 TCSD10 TCBar10 TCConf10 TCMM_Best10 TCBar_Best10 TCConf_Best10
        
        
%         
%          for i=1:100
%          [TCMM_Best(i) Ignore TCBar_Best{i} TCConf_Best{i}] = CLHBC_Tennis10(Vocabulary1,Vocabulary2,n,length(Vocabulary1));
%          end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TCConf_Best{i};
%             FsumnCC=FsumnCC+TCBar_Best{i};
%         end
%         
%         
%         T2CLHBC_Confmatrix=mat2tmat(Fsumm./100);
%         T2CLHBC_EventsPrediction=FsumnCC./100;
%         T2CLHBC_mean=mean(TCMM_Best);
%         T2CLHBC_std=std(TCMM_Best);
%         
        
        %         save T2CLHBC.mat T2CLHBC_Confmatrix T2CLHBC_EventsPrediction T2CLHBC_mean T2CLHBC_std
        
        
       elseif Method==3
        disp('Tennis + DP')
        sizes=10;
        load Tennis_ACASVA.mat %DATA AVAILABLE BY REQEUST (CONTACT FOR DETAILS)
        Vocabulary1 = fix_annotation_errors_10events(Vocabulary1);
        Vocabulary2 = fix_annotation_errors_10events(Vocabulary2);
        permuts = perms(1:sizes);
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat'];
        load(matfilename);
        for i=1:1 %length(All_Topologies)
            i/length(All_Topologies)
            [TDPMM_Best10{i} ignore TDPBar_Best10{i} TDPConf_Best10{i} TInD10{i}]=complete_top_replacedperm_T(All_Topologies{i},Vocabulary1,Vocabulary2,permuts,length(Vocabulary1)-n);
            %[DPMM{i} DPSD{i} DPBar{i} DPConf{i}]=complete_top(All_Topologies{i},Vocabulary,permuts,n,Voc,1,InD{i});
%             save Tennis_DP_Results.mat TDPMM_Best10 TDPBar_Best10 TDPConf_Best10
        end
     
%         for i=1:length(All_Topologies)
%         [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_replacedperm_T(All_Topologies{i},Vocabulary1,Vocabulary2,permuts,length(Vocabulary1)-n);
%         [i/length(All_Topologies) TDMM_Best(i) max(TDMM_Best)]
%         end
%         
%         for i=1:100
%         [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_replacedperm_T(All_Topologies{115},Vocabulary1,Vocabulary2,permuts,length(Vocabulary1)-n);
%         end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TDConf_Best{i};
%             FsumnCC=FsumnCC+TDBar_Best{i};
%         end
%         
%         
%         T2D_Confmatrix=mat2tmat(Fsumm./100);
%         T2D_EventsPrediction=FsumnCC./100;
%         T2D_mean=mean(TDMM_Best);
%         T2D_std=std(TDMM_Best);
        
        
        %         save T2D.mat T2D_Confmatrix T2D_EventsPrediction T2D_mean T2D_std
        
    end
    
    
elseif filenumber==4
    Data = textread('msnbc990928.seq','%d'); %(UCI - prepared version available by request)
    Data = fix_double_clicks_11events(Data);
    
    Data = change_order(Data);
    Train_Seq = cellstr(num2str(Data(1:8000)));
    Test_Seq = cellstr(num2str(Data(8001:9999)));
    
    if Method==1
        disp('MSN + FlatMM')
        st=1;
        %[MSNFMM MSNFSD MSNFBar MSNFConf] = MSN_11events(Train_Seq,Test_Seq,st);
        [MSNFMM_Best Ignore MSNFBar_Best MSNFConf_Best] = MSN_11events(Train_Seq,Test_Seq,length(Train_Seq))
%         save MSN_Flat_Results.mat MSNFMM MSNFSD MSNFBar MSNFConf MSNFMM_Best MSNFBar_Best MSNFConf_Best
%         
%          for i=1:100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = MSN_11events(Train_Seq,Test_Seq,length(Train_Seq));
%          end
%         
%         
%         Fsumm=zeros(11,11);
%         FsumnCC=zeros(1,11);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i};
%         end
%         
%         
%         MFlat_Confmatrix=mat2tmat(Fsumm./100);
%         MFlat_EventsPrediction=FsumnCC./100;
%         MFlat_mean=mean(TFMM_Best);
%         MFlat_std=std(TFMM_Best);
%         
%         save MFlat.mat MFlat_Confmatrix MFlat_EventsPrediction MFlat_mean MFlat_std
        
    elseif Method==2
        disp('MSN + CLHBC')
        st=1;
        %[MSNCMM MSNCSD MSNCBar MSNCConf] = MSN_11events_CLHBCTEST(Train_Seq,Test_Seq,st);
        [MSNCMM_Best Ignore MSNCBar_Best MSNCConf_Best] = MSN_11events_CLHBCTEST(Train_Seq,Test_Seq,length(Train_Seq))
        %save MSN_CLHBC_Results.mat MSNCMM MSNCSD MSNCBar MSNCConf MSNCMM_Best MSNCBar_Best MSNCConf_Best
        
%         for i=1:100
%             i/100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = MSN_11events_CLHBCTEST(Train_Seq,Test_Seq,length(Train_Seq));
%          end
%         
%         
%         Fsumm=zeros(11,11);
%         FsumnCC=zeros(1,11);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i};
%         end
%         
%         
%         MCLHBC_Confmatrix=mat2tmat(Fsumm./100);
%         MCLHBC_EventsPrediction=FsumnCC./100;
%         MCLHBC_mean=mean(TFMM_Best);
%         MCLHBC_std=std(TFMM_Best);
%         
%         save MCLHBC.mat MCLHBC_Confmatrix MCLHBC_EventsPrediction MCLHBC_mean MCLHBC_std
%         
%         
        
        
    elseif Method==3
        disp('MSN + DP')
        sizes=11;
        permuts = [randperm(sizes);randperm(sizes);randperm(sizes)];
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat'];
        load(matfilename);
        for i=1:length(All_Topologies)
            i/length(All_Topologies)
            [MSNDPMM_Best10{i} ignore MSNDPBar_Best10{i} MSNDPConf_Best10{i} MSNInD10{i}]=complete_top_best_replacedperm_MSN(All_Topologies{i},Train_Seq,Test_Seq,permuts,length(Train_Seq));
            
            %save MSN_DP_Results.mat MSNDPMM_Best10 MSNDPBar_Best10 MSNDPConf_Best10
        end
       
        
        for i=1:length(All_Topologies)
        [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_best_replacedperm_MSN(All_Topologies{i},Train_Seq,Test_Seq,permuts,length(Train_Seq));
        [i/length(All_Topologies) TDMM_Best(i) max(TDMM_Best)]
        end
        
%         for i=1:100
%         [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_best_replacedperm_MSN(All_Topologies{190},Train_Seq,Test_Seq,permuts,length(Train_Seq));
%         TDMM_Best(i)
%         end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TDConf_Best{i};
%             FsumnCC=FsumnCC+TDBar_Best{i};
%         end
%         
%         
%         MSND_Confmatrix=mat2tmat(Fsumm./100);
%         MSND_EventsPrediction=FsumnCC./100;
%         MSND_mean=mean(TDMM_Best);
%         MSND_std=std(TDMM_Best);
%         
%         save MD.mat MSND_Confmatrix MSND_EventsPrediction MSND_mean MSND_std
%         
        
        
        
    end
    
    
elseif filenumber==5
    load Activity_Dataset %(UCI prepared version available by request)
    Train_Seq = Activity_Dataset(1:500);
    Test_Seq = Activity_Dataset(501:end);
    
    if Method==1
        disp('ACTIVITY + FlatMM')
        st=1;
        %[AFMM AFSD AFBar AFConf] = Activity_11events(Train_Seq,Test_Seq,st);
        [AFMM_Best ignore AFBar_Best AFConf_Best] = Activity_11events(Train_Seq,Test_Seq,length(Train_Seq))
%         save Activity_FLAT_Results.mat AFMM AFSD AFBar AFConf AFMM_Best AFBar_Best AFConf_Best
    elseif Method==2
        disp('ACTIVITY + CLHBC')
        st=1;
        %[ACMM ACSD ACBar ACConf] = Activity_11events_CLHBCTEST(Train_Seq,Test_Seq,st);
        [ACMM_Best ignore ACBar_Best ACConf_Best] = Activity_11events_CLHBCTEST(Train_Seq,Test_Seq,length(Train_Seq))
%         save Activity_CLHBC_Results.mat ACMM ACSD ACBar ACConf ACMM_Best ACBar_Best ACConf_Best
    elseif Method==3
        disp('ACTIVITY + DP')
        sizes=11;
        
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat'];
        load(matfilename);
        for i=1:length(All_Topologies)
            i/length(All_Topologies)
            [ADPMM_Best10{i} ignore ADPBar_Best10{i} ADPConf_Best10{i} AInD10{i}]=complete_top_best_ACTIVITY(All_Topologies{i},Train_Seq,Test_Seq,sizes,length(Train_Seq))
            
%             save ACTIVITY_DP_Results.mat ADPMM_Best10 ADPBar_Best10 ADPConf_Best10
        end
        
    end
    
    
elseif filenumber==6
    load Driving_Events.mat %Data available by request (Contact for details)
    n=112; %size of test set
       
    m=1;c=1;
    Driving_Events=fix_annotation_errors_D(Driving_Events);
    Train_Seqs=Driving_Events(1:end-n)';
    Test_Seqs=Driving_Events(end-n+1:end)';
    permuts=perms(1:1:10);
    
    if Method==1
        disp('Drive + FlatMM')
        
        %[DFMM DFSD DFBar DFConf ] = FlatMM_D(Driving_Events,Train_Seqs,Test_Seqs,n,1);
        [DFMM_Best Ignore DFBar_Best DFConf_Best] = FlatMM_D(Driving_Events,Train_Seqs,Test_Seqs,n,length(Train_Seqs))
        
%         save Drive_Flat_Results.mat DFMM DFSD DFBar DFConf DFMM_Best DFBar_Best DFConf_Best
%         
%          for i=1:100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = FlatMM_D(Driving_Events,Train_Seqs,Test_Seqs,n,length(Train_Seqs));
%          end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i}';
%         end
%         
%         
%         HFlat_Confmatrix=mat2tmat(Fsumm./100);
%         HFlat_EventsPrediction=FsumnCC./100;
%         HFlat_mean=mean(TFMM_Best);
%         HFlat_std=std(TFMM_Best);
%         
%         save HFlat.mat HFlat_Confmatrix HFlat_EventsPrediction HFlat_mean HFlat_std
%         
%         
%         
        
        
        
        
        
        
        
    elseif Method==2
        disp('Drive + CLHBC')
        %[DCMM DCSD DCBar DCConf] = CLHBC_D(Driving_Events,Train_Seqs,Test_Seqs,n,1);
        [DCMM_Best Ignore DCBar_Best DCConf_Best] = CLHBC_D(Driving_Events,Train_Seqs,Test_Seqs,n,length(Train_Seqs))
        
%         save Drive_CLHBC_Results.mat DCMM DCSD DCBar DCConf DCMM_Best DCBar_Best DCConf_Best
%         
%         
%         for i=1:100
%          [TFMM_Best(i) Ignore TFBar_Best{i} TFConf_Best{i}] = CLHBC_D(Driving_Events,Train_Seqs,Test_Seqs,n,length(Train_Seqs));
%          end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TFConf_Best{i};
%             FsumnCC=FsumnCC+TFBar_Best{i}';
%         end
%         
%         
%         HCLHBC_Confmatrix=mat2tmat(Fsumm./100);
%         HCLHBC_EventsPrediction=FsumnCC./100;
%         HCLHBC_mean=mean(TFMM_Best);
%         HCLHBC_std=std(TFMM_Best);
%         
%         save HCLHBC.mat HCLHBC_Confmatrix HCLHBC_EventsPrediction HCLHBC_mean HCLHBC_std
%         
       
        
    elseif Method==3
        disp('Drive + DP')
        sizes=10;
        permuts = perms(1:sizes);
        matfilename = ['All_Topologies_alpha_0.01_0.01_0.1_gamma_0.05_0.05_0.5_size_'...
            num2str(sizes) '_iterations_500.mat'];
        load(matfilename);
        for i=1:length(All_Topologies)
            i/length(All_Topologies)
            [DDPMM_Best{i} ignore DDPBar_Best{i} DDPConf_Best{i} DInD{i}]=complete_top_best_D(All_Topologies{i},Driving_Events,Train_Seqs,Test_Seqs,permuts,n,length(Train_Seqs));
            %[DPMM{i} DPSD{i} DPBar{i} DPConf{i}]=complete_top(All_Topologies{i},Vocabulary,permuts,n,Voc,1,InD{i});
            
            %save Drive_DP_Results.mat DDPMM_Best DDPBar_Best DDPConf_Best DInD
        end
        
        
        for i=1:length(All_Topologies)
        [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_best_replacedpermD(All_Topologies{i},Driving_Events,Train_Seqs,Test_Seqs,permuts,n,length(Train_Seqs));
        [i/length(All_Topologies) TDMM_Best(i) max(TDMM_Best)]
        %if max(TDMM_Best)>82, pause,end
        end
        
%         for i=1:100
%         [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_best_replacedpermD(All_Topologies{2978},Driving_Events,Train_Seqs,Test_Seqs,permuts,n,length(Train_Seqs));
%         i,if TDMM_Best(i)>65, TDMM_Best(i),pause, end %complement with uncommenting Drive_A.mat in complete_top_best_replacedpermD
%         end
%         
%         for i=1:100
%         [TDMM_Best(i) Ignore TDBar_Best{i} TDConf_Best{i}] = complete_top_best_replacedpermD(All_Topologies{2978},Driving_Events,Train_Seqs,Test_Seqs,permuts,n,length(Train_Seqs));
%         TDMM_Best(i)
%         end
%         
%         
%         Fsumm=zeros(10,10);
%         FsumnCC=zeros(1,10);
%         FsumMM=0;
%         for i=1:100
%             Fsumm=Fsumm+TDConf_Best{i};
%             FsumnCC=FsumnCC+TDBar_Best{i}';
%         end
%         
%         
%         HD_Confmatrix=mat2tmat(Fsumm./100);
%         HD_EventsPrediction=FsumnCC./100;
%         HD_mean=mean(TDMM_Best);
%         HD_std=std(TDMM_Best);
%         
%         save HD.mat HD_Confmatrix HD_EventsPrediction HD_mean HD_std
        
        
    end
end