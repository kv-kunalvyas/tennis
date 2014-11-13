function MLHDP_Complete(alpha,gamma,iterations,sizes,depth)

%alpha = 1:1:10;%:0.1:10;
%gamma = 0.1:0.1:1;


for i=1:length(alpha)
    for j=1:length(gamma)
        Topologies{floor(alpha(i)*100),floor(gamma(j)*100)}=runner(alpha(i),gamma(j),iterations,sizes,depth);
        matFilename = ['top-alpha_' num2str(alpha(i)) '_and_gamma_' num2str(gamma(j)) '_Type_' num2str(sizes) '_Iterations_' num2str(iterations) '_D_' num2str(depth) '.mat'];
        save(matFilename,'Topologies')
        clear Topologies
    end
end

        %matFilename = ['top-alpha_' num2str(alpha(1)) '_to_' num2str(alpha(1)) '_and_gamma_' num2str(gamma(1)) '_to_' num2str(gamma(end)) '.mat'];
        %save(matFilename,'Topologies')
