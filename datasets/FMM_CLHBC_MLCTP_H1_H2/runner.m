function Topologies = runner

TT = zeros(1,8);

k=1;
Max_Tree_height = 3;
state_size = 8;
alpha = 1;
gamma = 0.2;
for mmm=1:1000
    mmm
    pi=1;
    
    for i=1:Max_Tree_height
        if i==1;
            [pi, theta, TM, Div] = mlhdp(alpha,gamma,pi);
            Tree{mmm}{i}={pi};
            if isequal(size(TM),[state_size state_size]) || length(TM)>8
                continue
            end
            
        else
            [pi, theta, TM, Div] = mlhdp(alpha,gamma,cell2mat(theta));
            Tree{mmm}{i}=theta;
            
            
            if length(TM)==state_size
                Inp{k} = TM;
                P(k) = length(pi);
                %T(k) = total;
                TT(k,1:length(cellfun('length',theta)))= cellfun('length',theta);
                TM_6{k}=TM;
                %nodes{k} = tree_topology(pi,theta);
                
                Topologies{k}.Div = Div;
                Topologies{k}.height = i;
                Topologies{k}.alpha = alpha;
                Topologies{k}.gamma = gamma;
                Topologies{k}.Tree = Tree{mmm};
                for nnn=1:i %height
                    Topologies{k}.Level_elements(nnn)=sum(cellfun('length',Topologies{k}.Tree{nnn}));
                end
                Topologies{k}.No_of_leaf_states = 6;
                Topologies{k}.TM = TM;
                if isequal(Topologies{k}.Level_elements(nnn),[1 2 6])
                    pause
                end
                k=k+1;
            end     
        end
    end 
end