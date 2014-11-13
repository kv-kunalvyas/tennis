function TM = Compute_Dat2TENNIS(Seq,Topology,Tree)
%  part1{1}=part{88};
% clear part
%  part=part1;


if isequal(Topology.Level_elements,[1 10])
    Div=Tree{2};
    [BASE NU] = Build_master_topology_Tennis_10events(Seq);
    TMat_Ulevel = zeros(length(Div),length(Div));
    
    for j=1:length(Div)
        if j==1, A{j} = 1:Div(j); prev=Div(j);
        else A{j}=prev+1:prev+Div(j); prev=prev+Div(j);
        end
    end
    
    for i=1:length(A)
        for j=1:length(A)
            
            
            LL=sum(sum(BASE(A{i},A{j})));
            
            Li=LL;
            TMat_Ulevel(i,j)=Li;
            clear LL
        end
    end
    
    %TMat_Ulevel=mat2tmat(TMat_Ulevel);
    
    TM=prob_inject(BASE,TMat_Ulevel,Div);
    
    
else


[TMat{length(Topology.Level_elements)} NU] = Build_master_topology_Tennis_10events(Seq);
k=1;
for i=length(Topology.Level_elements):-1:3
    Div = Tree{i};
    TMat{length(Topology.Level_elements)-k} = zeros(length(Div),length(Div));
    
    for j=1:length(Div)
        if j==1, A{j} = 1:Div(j); prev=Div(j);
        else A{j}=prev+1:prev+Div(j); prev=prev+Div(j);
        end
    end
    
    if i==length(Topology.Level_elements)
        BASE=TMat{length(Topology.Level_elements)};
    else
        BASE=TMat{length(Topology.Level_elements)-k+1};
    end
    
    for i=1:length(A)
        for j=1:length(A)
            
            
            LL=sum(sum(BASE(A{i},A{j})));
            
            Li=LL;
            TMat{length(Topology.Level_elements)-k}(i,j)=Li;
            clear LL
        end
    end
    
    %TMat{length(Topology.Level_elements)-k} = mat2tmat(TMat{length(Topology.Level_elements)-k});
    
    clear Div
    clear A
    k=k+1;
end


if Topology.height==1
    TM=zeros(10,10);
else
for i=3:1:length(Topology.Level_elements)
    Div = Tree{i};
    
    if i==3
        FinalTM=prob_inject(TMat{i},TMat{i-1},Div);
    else
        FinalTM = prob_inject(TMat{i},FinalTM,Div);
    end
     clear Div
end
    TM=FinalTM;
end

end
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % for p=1:length(part)
% %     
% %     Div = part{p};
% %     TMat2{p} = zeros(length(Div),length(Div));
% %     
% %     for j=1:length(Div)
% %         if j==1, A{j} = 1:Div(j); prev=Div(j);
% %         else A{j}=prev+1:prev+Div(j); prev=prev+Div(j);
% %         end
% %     end
% %     
% %     for i=1:length(A)
% %         for j=1:length(A)
% %             
% %             
% %             LL=sum(sum(TMat3(A{i},A{j})));
% %             
% %             Li=LL;
% %             TMat2{p}(i,j)=Li;
% %             clear LL
% %         end
% %     end
% %     
% %     TMat2{p} = mat2tmat(TMat2{p});
% %     
% %     clear Div
% %     clear A
% % end
% % 
% % 
% % 
% % for p=1:length(part)
% %     
% %     Div = part{p};
% %     
% %     D{p}=prob_inject(TMat3,TMat2{p},Div);
% %     
% %     
% % end
% % 
% % 
% % 
% % 
% % TM = D;