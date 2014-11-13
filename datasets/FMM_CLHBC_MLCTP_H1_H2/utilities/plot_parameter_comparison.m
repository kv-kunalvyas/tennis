%plot comparison wrt parameters

load top-1and0.1.mat
M{1,1}=nMM{1,1};
load top-1and0.2.mat
M{1,2}=nMM{1,2};
%load top-1and0.3
M{1,3}=0;
load top-1and0.4.mat
M{1,4}=nMM{1,4};
load top-1and0.5.mat
M{1,5}=nMM{1,5};
load top-1and0.6.mat
M{1,6}=nMM{1,6};
load top-1and0.7.mat
M{1,7}=nMM{1,7};
load top-1and0.8.mat
M{1,8}=nMM{1,8};
load top-1and0.9.mat
M{1,9}=nMM{1,9};
load top-1and1.mat
M{1,10}=nMM{1,10};

clear nMM
nMM=M;
 figure,
 bar3([-[max(cell2mat(nMM{1,1}.C)) max(cell2mat(nMM{1,2}.C))  0 ...
max(cell2mat(nMM{1,4}.C)) max(cell2mat(nMM{1,5}.C)) max(cell2mat(nMM{1,6}.C))...
max(cell2mat(nMM{1,7}.C)) max(cell2mat(nMM{1,8}.C)) max(cell2mat(nMM{1,9}.C))...
max(cell2mat(nMM{1,10}.C))];[length(nMM{1,1}.C) length(nMM{1,2}.C) 0 ... length(nMM{1,3}.C)...
length(nMM{1,4}.C) length(nMM{1,5}.C) length(nMM{1,6}.C) length(nMM{1,7}.C) length(nMM{1,8}.C)...
length(nMM{1,9}.C) length(nMM{1,10}.C)]]')
set(gca,'XTickLabel',{'Accuracy','Count'})
set(gca,'YTickLabel',{'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'})
set(gca,'ZTickLabel',{'100%','50%','0','50','100','150'})
colormap(summer)

