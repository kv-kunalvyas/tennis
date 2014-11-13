function Topologies = runner(alpha,gamma,iterations,sizes,max_depth)

TT = zeros(1,8);
k=1;
Topologies{k}.No_Output=1;
Max_Tree_height = max_depth;
state_size = sizes;

str=['alpha = ',num2str(alpha), ',gamma = ',num2str(gamma)];
disp(str);
        
for mmm=1:iterations
    
    pi=1;
    for i=1:Max_Tree_height
        if i==1;
            [pi, theta, TM] = mlhdp(alpha,gamma,pi);
            Tree{mmm}{i}={pi};
            if isequal(size(TM),[state_size state_size]) 
                if length(TM)==state_size
                Topologies{k}.No_Output=0;
                Inp{k} = TM;
                P(k) = length(pi);
                TT(k,1:length(cellfun('length',theta)))= cellfun('length',theta);
                TM_6{k}=TM;
                Topologies{k}.height = i;
                Topologies{k}.alpha = alpha;
                Topologies{k}.gamma = gamma;
                Topologies{k}.Tree = Tree{mmm};
                for nnn=1:i %height
                    Topologies{k}.Level_elements(nnn)=sum(cellfun('length',Topologies{k}.Tree{nnn}));
                end
                Topologies{k}.No_of_leaf_states = 6;
                Topologies{k}.TM = TM;
                k=k+1;
                end     
            end
        else
            [pi, theta, TM] = mlhdp(alpha,gamma,cell2mat(theta));
            if length(TM)>state_size
                break
            else
            Tree{mmm}{i}=theta;
            
            if length(TM)==state_size
                Topologies{k}.No_Output=0;
                Inp{k} = TM;
                P(k) = length(pi);
                TT(k,1:length(cellfun('length',theta)))= cellfun('length',theta);
                TM_6{k}=TM;
                Topologies{k}.height = i;
                Topologies{k}.alpha = alpha;
                Topologies{k}.gamma = gamma;
                Topologies{k}.Tree = Tree{mmm};
                for nnn=1:i %height
                    Topologies{k}.Level_elements(nnn)=sum(cellfun('length',Topologies{k}.Tree{nnn}));
                end
                Topologies{k}.No_of_leaf_states = 6;
                Topologies{k}.TM = TM;
                k=k+1;
            end   
            end
        end
    end 
end

