function Out_TM = DPHMM(In_TM,Topology,Tree)

basetm=In_TM;
rr=1;
z=1;m=3;
for i=Topology.height:-1:2
    TT{z} = Tree{i};
    if i==Topology.height
        tm_hmm = basetm;
        randtr{rr} = rand(length(TT{z}));
        [seqforhmm,stateshmm] = hmmgenerate(511,In_TM,ones(length(Topology.TM),1));
        randem{rr} = rand(length(TT{z}),max(seqforhmm));
        [esttr estem]=hmmtrain(seqforhmm(1:511),randtr{rr},randem{rr});
        TR{1}=basetm;
        TR{2}=esttr;
        rr=rr+1;
    else
        esttrb=esttr;
        estemb=estem;
        randtr{rr} = rand(length(TT{z}));
        [seqhmm,stateshmm] = hmmgenerate(511,esttrb,estemb);
        randem{rr} = rand(length(TT{z}),max(seqhmm));
        [esttr estem]=hmmtrain(seqhmm,randtr{rr},randem{rr});
        tm_hmm=esttrb;
        TR{m}=esttr;
        m=m+1;
        rr=rr+1;
    end
        
        k=i;
        z=z+1;
end

for i=1:Topology.height-1
    if i==1, FinalTM=TR{1}; end
    FinalTM = prob_inject(FinalTM,TR{i+1},TT{i});
end    
    
Out_TM=FinalTM;