%Depth Variation
alpha = 0.01:0.01:0.1;
gamma = 0.05:0.05:0.5;

for i=1:1:length(alpha)
    for j=1:1:length(gamma)
        matFilename{i,j} = ['top-alpha_' num2str(alpha(i)) '_and_gamma_' num2str(gamma(j)) '.mat'];
    
    load(matFilename{i,j})
    
    T = Topologies{end};
    for DD=1:length(T)
        Depth{i,j}(DD)=T{DD}.height;
        N_of_States{i,j}(DD)=length(cell2mat([T{DD}.Tree{1:end}]));
               
    end
    
    
    
    
    end
end


for i=1:length(alpha)
    for j=1:length(gamma)
        
        Mean(i,j) = mean(Depth{i,j});
        Mean_state_no(i,j)=mean(N_of_States{i,j});
        STD(i,j) = std(Depth{i,j},1);
        VAR(i,j) = var(Depth{i,j},1);
        Total(i,j) = length(Depth{i,j});
        
        
       
    end
        
end

%bar(Mean)


figure,errorb(Mean,STD)


a = colormap(summer);
b = a(1:7:end,:);
colormap(b)



    legend('\gamma=0.05','\gamma=0.1','\gamma=0.15','\gamma=0.2','\gamma=0.25',...
        '\gamma=0.3','\gamma=0.35','\gamma=0.4','\gamma=0.45','\gamma=0.5')
    
    xlabel('\alpha')
    set(gca,'XTickLabel',{'0.01','0.02','0.03','0.04','0.05','0.06','0.07','0.08','0.09','0.1'},...
        'FontSize',15)
    
    ylabel('Topologies Height','FontSize',15)
 axis([0 11 0 5])
% figure,bar(Total)
% colormap(summer)

figure, plot(mean(Mean'),'linewidth',2)
hold on, errorbar(mean(Mean'),mean(STD'),'xr')


xlabel('\alpha','FontSize',15)
    set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10],'XTickLabel',{'0.01','0.02','0.03','0.04','0.05','0.06','0.07','0.08','0.09','0.1'})    

    ylabel('Topologies Height','FontSize',15)
    
    axis([0 11 0 5])
    
    
    
figure, plot(mean(Mean),'linewidth',2)
hold on, errorbar(mean(Mean),mean(STD),'xr')


xlabel('\gamma','FontSize',15)
    set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10],'XTickLabel',{'0.05','0.1','0.15','0.2','0.25','0.3','0.35','0.4','0.45','0.5'})    

    ylabel('Topologies Height','FontSize',15)
    
    axis([0 11 0 5])    
    
    
    
    
    
    figure,plotyy(1:10,mean(Mean),1:10,mean(Mean_state_no))
    
    
    
    
    