function nodes = tree_topology(pi,theta)

A = 1:length(pi);
B = cellfun('length',theta);

nodes(1)=0;
nodes(2)=1;
k=length(nodes);
for i=1:length(A)-1
    
    nodes(B(i)+k+1)=1;
    k=length(nodes);
end
    

ind = (find(nodes==1));

for i=1:length(ind)-1
    nodes(ind(i)+1:ind(i+1)-1)=ind(i);
end
    nodes(ind(end)+1:ind(end)+B(end))=(ind(end));
    
    treeplot(nodes)
    