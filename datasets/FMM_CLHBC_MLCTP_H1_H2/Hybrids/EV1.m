% Training set

load Training_set

%UTr is the Topological likelihood at training
%LikTr is the likelihood of each PS
%associationTr is the association of each PS with the training set

load Test_set

%LikTe is the likelihood of each PS and so on


[sortedUTr ind] = sort(UTr);



for m=1:length(LikTe)
    f= UTr;
    val = LikTe(m); %value to find

tmp = abs(f-val);
[idx idx] = min(tmp); %index of closest value
closest = f(idx); %closest value

 if idx-associationTe(m)==0
        MM(m)=1;

    else
        MM(m)=0;

 end
end

plot(MM)


break

weighted = [0.4063 0.5625 0.5625 0.9375]*100
unweighted = [0.0938 0.0938 0.0938 0.0938]*100
plot(unweighted,'-bo','MarkerFaceColor','b','LineWidth',2)
hold on, plot(weighted,'-rd','MarkerFaceColor','r','LineWidth',2)
set(gca,'XTick',1:1:4)
xlabel('Experiment')
ylabel('Accuracy')
legend('Unweighted','Weighted')