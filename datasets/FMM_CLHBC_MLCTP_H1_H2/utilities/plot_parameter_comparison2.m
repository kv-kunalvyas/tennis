
for i=1:1
    for j=1:50
        matFilename{i,j} = ['top-' num2str(i) 'and' num2str(j/100) '.mat'];
    
    load(matFilename{i,j})
    
    MeaN(i,j)=mean(cell2mat(nMM{end}.C));
    MaX(i,j)=max(cell2mat(nMM{end}.C));
    if cell2mat(nMM{end}.C)==0
        Count(i,j)=0;
    else
        Count(i,j)=length(nMM{end}.C);
    end
    
    
    end
end

for i=1:1
    
    MEAN = MeaN(i,:);
    MAX = MaX(i,:);
    COUNT = Count(i,:);
    
    bar([-COUNT'])
    hold on
    bar([MAX'],'r')
    bar([MEAN'],0.2,'g')
    
end
        