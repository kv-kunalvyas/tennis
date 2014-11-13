load Activity_Flat
AF = nMM;
AFb = nCC;
load Activity_CLHBC
AC = nMM;
ACb = nCC;
load MSN_Flat_Complete
MF = nMM;
MFb = nCC;
load MSN_CLHBC_Complete
MC = nMM;
MCb = nCC;


set(0,'DefaultAxesFontSize',14)
set(0,'DefaultAxesFontWeight','bold')
fullscreen = get(0,'ScreenSize');
figure('Position',[0 -50 fullscreen(3) fullscreen(4)])
hold on
subplot(1,2,1), 
plot(AF,'linewidth',2),hold on, plot(AC,'r','linewidth',2), 
title('Localization Data for Person Activity Data set')
axis([1 500 0 100]), 
subplot(1,2,2),
bar([AFb ;ACb]'),axis([0    12     0   100])
title('Localization Data for Person Activity Data set')
xticklabel_rotate(1:11,45,EV_activity)

figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14,'fontWeight','bold')


EV_MSN = {'MSN-Home';'MSN-News-ALL';'MSN-News-Local';'MSN-News-Weather';...
    'MSN-News-Business';'MSN-News-Sports';'MSN-Interests-Health';...
    'MSN-Interests-Living';'MSN-Interests-Tech';'MSN-Interests-Travel';'MSN-Others'};
fullscreen = get(0,'ScreenSize');
figure('Position',[0 -50 fullscreen(3) fullscreen(4)])

hold on
subplot(1,2,1),
plot(MF,'linewidth',2),hold on, plot(MC,'r','linewidth',2), 
title('MSNBC.com Anonymous Web Data - Dataset')
axis([1 length(MF) 0 100]),
subplot(1,2,2),
bar([MFb ;MCb]'),axis([0    12     0   100])
title('MSNBC.com Anonymous Web Data - Dataset')
xticklabel_rotate(1:11,45,EV_MSN)

figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14,'fontWeight','bold')