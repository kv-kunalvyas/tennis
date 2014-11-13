clear
for i=1:1:10
    for j=5:5:50
        matFilename{i,j} = ['top-' num2str(i) 'and' num2str(j/100) 'nMM.mat'];
    
        load(matFilename{i,j})
    
        MeaN(i,j/5)=mean(cell2mat(nMM{end}.C));
        MaX(i,j/5)=max(cell2mat(nMM{end}.C));
        if cell2mat(nMM{end}.C)==0
            Count(i,j/5)=0;
        else
            Count(i,j/5)=length(nMM{end}.C);
        end
    
    
    end
end

%CODE FOR SUBPLOT!!
for i=1:1:10
    
    MEAN = MeaN(i,:);
    MAX = MaX(i,:);
    COUNT = Count(i,:);
    
    if i<5
        figure(1)
        subplot(4,1,i)
        bar(-COUNT')
        hold on
        bar(MAX','r')
        bar(MEAN',0.2,'g')
        set(gca,'XTick',1:1:10)
        set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
        set(gca,'YTick',[-200:40:0 20 40 60 80 100])
        set(gca,'YTickLabel',{'200','160','120','80','40','0','20','40','60','80','100'})
        title(['alpha=  ',num2str(i)])
        xlabel('gamma')
        ylabel('          Count                Accuracy')
    elseif i>4 && i<9 
        figure(2)
        subplot(4,1,i-4)
        bar(-COUNT')
        hold on
        bar(MAX','r')
        bar(MEAN',0.2,'g')
        set(gca,'XTick',1:1:10)
        set(gca,'XTickLabel',{'0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40','0.45','0.50'})
        set(gca,'YTick',[-200:40:0 20 40 60 80 100])
        set(gca,'YTickLabel',{'200','160','120','80','40','0','20','40','60','80','100'})
        title(['alpha=  ',num2str(i)])
        xlabel('gamma')
        ylabel('          Count                Accuracy')
    end
    
end
        