function [pi, thetap, TM, Div] = mlhdp(alpha,gamma,pi_i)
if nargin==3
    pi=pi_i;
else  
%STICK BREAKING CONSTRUCTION
% nn = floor(2 + (10-1).*rand(1,1));
% beta = betarnd(1,alpha, 1,nn);
% neg = cumprod(1-beta);
% pi = beta .* [1 neg(1:end-1)];       %size of pi gives the number of states which will have CRP under it

pi = CRPgenerate(alpha);
end

TMat2=zeros(length(pi),length(pi));
if length(pi)~=1
    for m = 1:length(pi)
         beta=betarnd(1,alpha,1,length(pi));
         neg=cumprod(1-beta);
        Ru{m}=beta.*[1 neg(1:end-1)]*pi(m);
%        Ru{m}=CRPgenerate(alpha);
    end
    
    for nn=1:length(Ru)
        TMat2(nn,:)=Ru{nn};
    end
else
    TMat2=1;
end

TMat2=mat2tmat(TMat2);
% CHINESE RESTAURANT PROCESS
for jj=1:length(pi)                             %INNER CRP
    thetap{jj} = CRPgenerate(gamma);    
end

ci = cell2mat(thetap);

c=1;


if length(ci)~=1
    for m = 1:length(ci)
         beta=betarnd(1,alpha,1,length(ci));
         neg=cumprod(1-beta);
         Rl{m}=beta.*[1 neg(1:end-1)]*ci(m);
        
%        Rl{m}=CRPgenerate(gamma);
    end
    
    for nn=1:length(Rl)
        TMat3(nn,:)=Rl{nn};
    end
else
    TMat3=1;
end

TMat3=mat2tmat(TMat3);
Div = cellfun(@length,thetap);

for i=1:length(Div)-1
    if i==1 
        TMat3(Div(i)+1:Div(i)+Div(i+1),:)=circshift(TMat3(Div(i)+1:Div(i)+Div(i+1),:),[0 Div(i)+1]);
        P = Div(i)+Div(i+1);
    else
        TMat3(P+1:P+Div(i+1),:)=circshift(TMat3(P+1:P+Div(i+1),:),[0 P+Div(i)+1]);
        P=P+Div(i+1);
    end
end
        
Si = size(TMat2);
for i=1:length(Div)
     if i==1, A{i} = 1:Div(i); prev=Div(i);
     else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
     end
end

D=zeros(length(ci),length(ci));
 
 for i=1:length(A)
     for j=1:length(A)
         D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
     end
 end
 LH = log(prod(D(D>0)));
 TMatrix = mat2tmat(D);

TM=TMatrix;