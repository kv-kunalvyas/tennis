%for alpha < 1 and gamma 0.05:0.05:0.5
clear
for i=1:1:1 %1:1:8
    for j=1:1:100
        matFilename{i,j} = ['APR-top-' num2str(i/100) 'and' num2str(j/100) '_' num2str(100) 'nMM.mat'];
    
        load(matFilename{i,j})
    
        MeaN(i,j/1)=mean(cell2mat(nMM{end}.C));
        MaX(i,j/1)=max(cell2mat(nMM{end}.C));
        if cell2mat(nMM{end}.C)==0
            Count(i,j/1)=0;
        else
            Count(i,j/1)=length(nMM{end}.C);
        end
    
    
    end
end

%CODE FOR SUBPLOT!!
for i=1:1:1
    
    MEAN = MeaN(i,:);
    MAX = MaX(i,:);
    COUNT = Count(i,:);
    
    if i<5
        %figure(1)
        %subplot(4,1,i)
        figure
        bar(-COUNT',0.4)
        hold on
        bar(MAX',0.4,'r')
        bar(MEAN',0.2,'g')
        set(gca,'XTick',1:1:10)
        set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
        set(gca,'YTick',[-200:40:0 20 40 60 80 100])
        set(gca,'YTickLabel',{'200','160','120','80','40','0','20','40','60','80','100'})
        title(['\alpha=  ',num2str(i/100)])
        xlabel('\gamma')
        ylabel('                                    Topologies Count                                                                                                     Accuracy')
        colormap(summer)
        axis([0    12  -200   100])
    elseif i>4 && i<9 
        %figure(2)
        %subplot(4,1,i-4)
        figure
        bar(-COUNT',0.4)
        hold on
        bar(MAX',0.4,'r')
        bar(MEAN',0.2,'g')
        set(gca,'XTick',1:1:10)
        set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
        set(gca,'YTick',[-200:40:0 20 40 60 80 100])
        set(gca,'YTickLabel',{'200','160','120','80','40','0','20','40','60','80','100'})
        title(['\alpha=  ',num2str(i/100)])
        xlabel('\gamma')
        ylabel('                                    Topologies Count                                                                                                     Accuracy')
        colormap(summer)
        axis([0    12  -200   100])
    end
    
end

figure, plot(MaX'), legend({'\alpha=0.1','\alpha=0.2','\alpha=0.3','\alpha=0.4','\alpha=0.5'...
    ,'\alpha=0.6','\alpha=0.7','\alpha=0.8'})
set(gca,'XTick',1:1:10)
set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
axis([1 10 0 100])
xlabel('\gamma')
ylabel('Maximum Accuracy')
figure, plot(MeaN'), legend({'\alpha=0.1','\alpha=0.2','\alpha=0.3','\alpha=0.4','\alpha=0.5'...
    ,'\alpha=0.6','\alpha=0.7','\alpha=0.8'})
set(gca,'XTick',1:1:10)
set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
axis([1 10 0 100])
xlabel('\gamma')
ylabel('Mean Accuracy')


figure,imagesc(MaX)
ylabel('\alpha','FontSize',15)
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10],'XTickLabel',{'0.05','0.1','0.15','0.2','0.25','0.3','0.35'...
        ,'0.4','0.45','0.5','0.1'}...
        ,'FontSize',15)
    
 xlabel('\gamma','FontSize',15)

set(gca,'YTick',[1 2 3 4 5 6 7 8 9 10],'YTickLabel',{'0.01','0.02','0.03','0.04','0.05','0.06','0.07','0.08','0.09','0.1'})    

        