mat=zeros(98,4);
for i=1:98
    mat(i,1:length(mean((char(cellstr(char(playshots{i}))')-0)')))=mean((char(cellstr(char(playshots{i}))')-0)');
end


mat2=unique(mat,'rows');
imagesc(log10(mat2))

a = colormap(hot);
b = a(end:-1:20,:);
colormap(b)
