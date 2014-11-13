%find best topology

function TP = find_best_topology(Topologies,Seq)

A = Build_master_topology(Seq);

    for i=1:length(Topologies)
        B = Topologies{i}.TM;
        JS_Distance(i)=(abs(KLDiv(A(:)',B(:)'))+abs(KLDiv(A(:)',B(:)')))/2;
    end

[~, I]=min(JS_Distance);

TP = Topologies{I};
