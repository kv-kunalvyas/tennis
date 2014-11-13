function Finaltm = prob_inject(TMat3,TMat2,Div)

for i=1:length(Div)
    if i==1, A{i} = 1:Div(i); prev=Div(i);
    else A{i}=prev+1:prev+Div(i); prev=prev+Div(i);
    end
end

D=zeros(length(TMat3),length(TMat3));

for i=1:length(A)
    for j=1:length(A)
        D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
    end
end

Finaltm = mat2tmat(D);