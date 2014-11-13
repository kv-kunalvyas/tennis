function Final_Topologies_Listing(alpha,gamma,sizes,iterations,depth)

%alpha=0.01:0.01:0.1;gamma=0.05:0.05:0.5;
%alpha=0.01;gamma=0.05:0.05:0.15;
%alpha=0.01:0.01:0.01;gamma=0.05:0.05:0.5;
sizes=13;
iterations=500;
depth=10;
k=1;

for i=1:length(alpha)
    for j=1:length(gamma)
        matFilename = ['top-alpha_' num2str(alpha(i)) '_and_gamma_' num2str(gamma(j)) '_Type_' num2str(sizes) '_Iterations_' num2str(iterations) '_D_' num2str(depth) '.mat'];
        load(matFilename)
        if k==1
            T{k}=Topologies{end};
        else
            T{k}=[T{k-1} Topologies{end}];
        end
        k=k+1;
    end
end

All_Topologies = T{end};

%For single alpha value 0.01
%m = ['All_Topologies_alpha_0.01_gamma_0.05_0.05_0.5_size_'...
%    num2str(sizes) '_iterations_' num2str(iterations) '.mat'];
%save(m,'All_Topologies')

%%
%DEFINE DEPTH before running below


%For alpha 0.01_0.01_0.1
 m = ['All_Topologies_alpha_0.01_0.01_0.01_gamma_0.05_0.05_0.5_size_'...
     num2str(sizes) '_iterations_' num2str(iterations) '_D_' num2str(depth) '.mat'];
 save(m,'All_Topologies')