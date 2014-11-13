Dataset = 1; %1-badminton,2-tennis,3-tennisvamp,4-driver,5-msn,6-activity,
set(0,'DefaultAxesFontSize',14)
set(0,'DefaultAxesFontWeight','bold')
Methods = {'Flat MM';'ML-HDP'; 'CLHBC' };

switch(Dataset)
    case 1
        disp('Badminton')
        load Badminton_Flat_Results.mat
        load Badminton_CLHBC_Results.mat
        load Badminton_DP_Results.mat
        %load HMM stuff
        EV_Badminton = {'SF';'SN';'HF';'HN';'BIN';'BIF';'BON';'BOF'};
        [un ind_Badminton]=max(cell2mat(DPMM_Best));
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        hold on
        %subplot(2,3,1),
        plot(BFMM,'r','linewidth',2),hold on,plot(BCMM,'b','linewidth',2)
        title('Mean prediction accuracy')
        xlabel('Training Window Size')
        ylabel('Mean Accuracy')
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        bar([BFMM_Best 0 0],0.5,'r');
        hold on
        bar([0 DPMM_Best{ind_Badminton} 0],0.5,'g');
        bar([0 0 BCMM_Best],0.5,'b');
        title('Maximum Accuracy')
        xlabel('Method')
        ylabel('Percentage Accuracy')
        xticklabel_rotate([],45,Methods,'FontSize',get(gca,'FontSize'),'FontWeight',get(gca,'FontWeight'))
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        h1 = bar([BFBar_Best ;DPBar_Best{ind_Badminton}';BCBar_Best]');
        set(h1(1),'facecolor','r') % use color name
        set(h1(2),'facecolor','g') % or use RGB triple
        set(h1(3),'facecolor','b')
        title('Individual event prediction accuracy - Maximum Training Window')
        xlabel('Event type')
        axis([0 9 0 100])
        xticklabel_rotate([],45,EV_Badminton)
        ylabel('Percentage Accuracy')
        figureHandle = gcf;
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        plotConfMatrix(BFConf_Best,EV_Badminton,EV_Badminton)
        text(60,-40,'Confusion Matrix - Flat MM')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        plotConfMatrix(DPConf_Best{ind_Badminton},EV_Badminton,EV_Badminton)
        text(60,-40,'Confusion Matrix - ML-HDP')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        plotConfMatrix(BCConf_Best,EV_Badminton,EV_Badminton)
        text(60,-40,'Confusion Matrix - CLHBC')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
               
    case 2
        disp('Tennis')
        load Tennis_Flat_Results10.mat
        load Tennis_CLHBC_Results10.mat
        load Tennis_DP_Results.mat
        %load HMM stuff
        EV_Tennis =  {'SF'; 'SN'; 'HF'; 'HN'; 'BIN'; 'BIF'; 'BON' ;'BOF';'BOFS';'BONS'};
        [un2 ind_Tennis]=max(cell2mat(TDPMM_Best10));
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        hold on
        subplot(2,3,1),
        plot(TFMM10,'r','linewidth',2),hold on,plot(TCMM10,'b','linewidth',2)
        axis([0 80 0 100])
        title('Mean prediction accuracy')
        xlabel('Training Window Size')
        ylabel('Mean Accuracy')
        subplot(2,3,2),
        bar([TFMM_Best10 0 0],0.5,'r');
        hold on
        bar([0 TDPMM_Best10{ind_Tennis} 0],0.5,'g');
        bar([0 0 TCMM_Best10],0.5,'b');
        title('Maximum Accuracy')
        xlabel('Method')
        ylabel('Percentage Accuracy')
        axis([0.5000    3.5000         0   100])
        xticklabel_rotate([],45,Methods)
        subplot(2,3,3),
        h1 = bar([TFBar_Best10 ;TDPBar_Best10{ind_Tennis};TCBar_Best10]');
        set(h1(1),'facecolor','r') % use color name
        set(h1(2),'facecolor','g') % or use RGB triple
        set(h1(3),'facecolor','b')
        title('Individual event prediction accuracy - Maximum Training Window')
        xlabel('Event type')
        axis([0 11 0 100])
        xticklabel_rotate([],45,EV_Tennis)
        ylabel('Percentage Accuracy')
        figureHandle = gcf;
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,4)
        plotConfMatrix(TFConf_Best10,EV_Tennis,EV_Tennis)
        text(60,-50,'Confusion Matrix - Flat MM')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,5)
        plotConfMatrix(TDPConf_Best10{ind_Tennis},EV_Tennis,EV_Tennis)
        text(60,-50,'Confusion Matrix - ML-HDP')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,6)
        plotConfMatrix(TCConf_Best10,EV_Tennis,EV_Tennis)
        text(60,-50,'Confusion Matrix - CLHBC')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        
        
    case 3
        disp('Tennis Vampire')
        %RUN models
        EV_Tennis =  {'SF'; 'SN'; 'HF'; 'HN'; 'BIN'; 'BIF'; 'BON' ;'BOF';'BOFS';'BONS'};
        
        
        
    case 4
        disp('Driver')
        %RUN models
        EV_Drive ={'S';'TSt';'TLe';'TRi';'LR';'LA';'LG';'SiLL';'SiRR';'Sp'};
        %[un5 ind_Drive]=max(cell2mat(DDPMM_Best));
        
    case 5
        disp('MSN')
        load MSN_Flat_Results.mat
        load MSN_CLHBC_Results.mat
        load MSN_DP_Results.mat
        %load HMM stuff
        EV_MSN = {'MH';'MNA';'MNL';'MNW';'MNB';'MNS';'MIH';'MIL';'MITe';'MITr';'MO'};
        [un4 ind_MSN]=max(cell2mat(MSNDPMM_Best10));
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        hold on
        subplot(2,3,1),
        plot(MSNFMM,'r','linewidth',2),hold on,plot(MSNCMM,'b','linewidth',2)
        axis([0 5000 0 100])
        title('Mean prediction accuracy')
        xlabel('Training Window Size')
        ylabel('Mean Accuracy')
        subplot(2,3,2),
        bar([MSNFMM_Best 0 0],0.5,'r');
        hold on
        bar([0 MSNDPMM_Best10{ind_MSN} 0],0.5,'g');
        bar([0 0 MSNCMM_Best],0.5,'b');
        title('Maximum Accuracy')
        xlabel('Method')
        ylabel('Percentage Accuracy')
        xticklabel_rotate([],45,Methods)
        axis([0.5000    3.5000         0   100])
        subplot(2,3,3),
        h1 = bar([MSNFBar_Best ;MSNDPBar_Best10{ind_MSN};MSNCBar_Best]');
        set(h1(1),'facecolor','r') % use color name
        set(h1(2),'facecolor','g') % or use RGB triple
        set(h1(3),'facecolor','b')
        title('Individual event prediction accuracy - Maximum Training Window')
        xlabel('Event type')
        axis([0 12 0 100])
        xticklabel_rotate([],45,EV_MSN)
        ylabel('Percentage Accuracy')
        figureHandle = gcf;
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,4)
        plotConfMatrix(MSNFConf_Best,EV_MSN,EV_MSN)
        text(60,-50,'Confusion Matrix - Flat MM')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,5)
        plotConfMatrix(MSNDPConf_Best10{ind_MSN},EV_MSN,EV_MSN)
        text(60,-50,'Confusion Matrix - ML-HDP')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,6)
        plotConfMatrix(MSNCConf_Best,EV_MSN,EV_MSN)
        text(60,-50,'Confusion Matrix - CLHBC')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        
    case 6
        disp('Activity')
        load Activity_FLAT_Results.mat
        load Activity_CLHBC_Results.mat
        load ACTIVITY_DP_Results.mat
        %load HMM stuff
        EV_Activity = {'F';'L';'LD';'O';'S';'SD';'SG';'StL';'StS';'StSG';'W'};
        
        
        % 'falling''lying''lying down''on all fours''sitting''sitting down''sitting on the ground'
        %'standing up from lying''standing up from sitting''standing up from sitting on the ground''walking'
        
        
        [un3 ind_Activity]=max(cell2mat(ADPMM_Best10));
        fullscreen = get(0,'ScreenSize');
        figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
        hold on
        subplot(2,3,1),
        plot(AFMM,'r','linewidth',2),hold on,plot(ACMM,'b','linewidth',2)
        title('Mean prediction accuracy')
        xlabel('Training Window Size')
        ylabel('Mean Accuracy')
        subplot(2,3,2),
        bar([AFMM_Best 0 0],0.5,'r');
        hold on
        bar([0 ADPMM_Best10{ind_Activity} 0],0.5,'g');
        bar([0 0 ACMM_Best],0.5,'b');
        title('Maximum Accuracy')
        xlabel('Method')
        ylabel('Percentage Accuracy')
        xticklabel_rotate([],45,Methods)
        subplot(2,3,3),
        h1 = bar([AFBar_Best ;ADPBar_Best10{ind_Activity};ACBar_Best]');
        set(h1(1),'facecolor','r') % use color name
        set(h1(2),'facecolor','g') % or use RGB triple
        set(h1(3),'facecolor','b')
        title('Individual event prediction accuracy - Maximum Training Window')
        xlabel('Event type')
        axis([0 12 0 100])
        xticklabel_rotate([],45,EV_Activity)
        ylabel('Percentage Accuracy')
        figureHandle = gcf;
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,4)
        plotConfMatrix(AFConf_Best,EV_Activity,EV_Activity)
        text(60,-50,'Confusion Matrix - Flat MM')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,5)
        plotConfMatrix(ADPConf_Best10{ind_Activity},EV_Activity,EV_Activity)
        text(60,-50,'Confusion Matrix - ML-HDP')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        subplot(2,3,6)
        plotConfMatrix(ACConf_Best,EV_Activity,EV_Activity)
        text(60,-50,'Confusion Matrix - CLHBC')
        set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
        
        
end










%================================================================================================

%  UNUSED CODE
% % %
% % % plot(AF,'linewidth',2),hold on, plot(AC,'r','linewidth',2),
% % % title('Localization Data for Person Activity Data set')
% % % axis([1 500 0 100]),
% % % subplot(1,2,2),
% % % bar([AFb ;ACb]'),axis([0    12     0   100])
% % % title('Localization Data for Person Activity Data set')
% % % xticklabel_rotate(1:11,45,EV_activity)
% % %
% % % figureHandle = gcf;
% % % %# make all text in the figure to size 14 and bold
% % % set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')
% % %
% % %
% % %
% % % fullscreen = get(0,'ScreenSize');
% % % figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
% % %
% % % hold on
% % % subplot(1,2,1),
% % % plot(MF,'linewidth',2),hold on, plot(MC,'r','linewidth',2),
% % % title('MSNBC.com Anonymous Web Data - Dataset')
% % % axis([1 length(MF) 0 100]),
% % % subplot(1,2,2),
% % % bar([MFb ;MCb]'),axis([0    12     0   100])
% % % title('MSNBC.com Anonymous Web Data - Dataset')
% % % xticklabel_rotate(1:11,45,EV_MSN)
% % %
% % % figureHandle = gcf;
% % % %# make all text in the figure to size 14 and bold
% % % set(findall(figureHandle,'type','text'),'fontSize',11,'fontWeight','bold')