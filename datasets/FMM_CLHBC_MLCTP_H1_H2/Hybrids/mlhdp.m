

function [pi, theta, TM] = mlhdp(alpha,gamma,pi_i)


if nargin==3
    pi=pi_i;
else  

    
%STICK BREAKING CONSTRUCTION
nn = floor(2 + (10-1).*rand(1,1));
beta = betarnd(1,alpha, 1,nn);
neg = cumprod(1-beta);
pi = beta .* [1 neg(1:end-1)];       %size of pi gives the number of states which will have CRP under it
end


% CHINESE RESTAURANT PROCESS
for jj=1:length(pi)                             %INNER CRP
    
    theta{jj} = CRPgenerate(gamma);
    
end

TM=zeros(1);

total=sum(cellfun('length',theta),2);
M = zeros(total);

V = cell2mat(theta);

D = zeros(1,1,1,1);

for i=1:length(pi)
    
    for j=1:length(theta{i})
        
        if length(theta{i})~=1
            if i==length(pi)
                
                if j~=length(theta{i})
                    D(i,j,i,j)=theta{i}(j);
                    D(i,j,i,j+1)=1-D(i,j,i,j);
                else
                    D(i,j,i,j)=theta{i}(j);
                    D(i,j,i,1)=(1-D(i,j,i,j))*(pi(i));
                    D(i,j,1,1)=(1-D(i,j,i,j))*(1-pi(i));
                end
                
            else
                
                if j~=length(theta{i})
                    D(i,j,i,j)=theta{i}(j);
                    D(i,j,i,j+1)=1-D(i,j,i,j);
                else
                    D(i,j,i,j)=theta{i}(j);
                    D(i,j,i+1,1)=(1-D(i,j,i,j))*(1-pi(i));
                    D(i,j,i,1)=(1-D(i,j,i,j))*(pi(i));
                end
                
            end
        end
        
        if length(theta{i})==1
            
            if i==length(pi)
                D(i,j,i,j)=theta{i}(j)*pi(i);
                D(i,j,1,1)=1-D(i,j,i,j);
            end
            
            if i~=length(pi)
                D(i,j,i,j)=theta{i}(j)*pi(i);
                D(i,j,i+1,1)=1-D(i,j,i,j);
            end
            
            
            
        end
    end
end

[a,b,c,d]=ind2sub(size(D),find(D>0));
X=[a,b,c,d,D(D>0)];
X=sortrows(X);

if isempty(X)
    TM = 1;
else
A = [X(:,1) X(:,2)];
B = [X(:,3) X(:,4)];
C = X(:,5);

UA = unique(A,'rows');

[tf1 Ro] = ismember(A,UA,'rows');
[tf2 Co] = ismember(B,UA,'rows');


for i=1:length(Ro)
    TM(Ro(i),Co(i))=C(i);
end

end

