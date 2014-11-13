%load hierarchical2
%hCC2=hCC;
%hMM2=hMM;
%clear hCC hMM

% load DP.mat
% hCCD=nCC;
% hMMD=nMM;
% clear nCC nMM


load min_curve
load max_curve
load DP_N

load DP.mat
hCCD=nCC;
hMMD=nMM;
clear nCC nMM

load DP_N.mat
hCCN=nCC;
hMMN=nMM;
clear nCC nMM

load non_hierarchical.mat
load hierarchical.mat

figure
%plot(hMMD,'color','g','LineWidth',2)
grey = [0.8,0.8,0.8];
patch([[1:77] fliplr([1:77])], [min_curve,fliplr(max_curve)],grey,'LineWidth',2)
hold on
plot(nMM,'color','r','LineWidth',2)
%plot(hMM2,'color','b','LineWidth',2)
plot(hMM,'color','b','LineWidth',2)

plot(hMMN,'color','g','LineWidth',2)
plot(hMMD,'color','c','LineWidth',2)

axis([0 80 0 100])

xlabel('Training Window Size')
ylabel('Mean Accuracy')
h1=legend( 'HDP-Cartesian Ensemble','Flat Labelled Markov Model',sprintf('3-State Two Level Cartesian Product Label-Based\nHierarchical Bottom-up Clustering'),'ML-HDP-hHMM LR','ML-HDP-hMM Relaxed');
set(h1, 'Location', 'NorthOutside')


%plot(repmat(mean(hMMD),1,length(hMM2)),'--g')
plot(repmat(mean(nMM),1,length(nMM)),'--r')
%plot(repmat(mean(hMM2),1,length(hMM2)),'--b')
plot(repmat(mean(hMM),1,length(hMM)),'--b')
plot(repmat(mean(hMMN),1,length(hMM)),'--g')
plot(repmat(mean(hMMD),1,length(hMM)),'--c')

% figure
% bar([hCCD,nCC,hCC2,hCC])
% set(gca,'XTick',1:8)
% set(gca,'xTickLabel',{'SF'; 'SN' ; 'HF' ; 'HN' ; 'BIF' ; 'BIN' ; 'BOF' ; 'BON'})
% h1=legend( 'HDP-Cartesian Ensemble','Flat Labelled Markov Model',sprintf('3-State Two Level Cartesian Product Label-Based\nHierarchical Bottom-up Clustering'));
% set(h2, 'Location', 'NorthOutside')