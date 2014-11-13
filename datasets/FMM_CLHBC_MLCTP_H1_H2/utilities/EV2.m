%EV2
Vocabulary=main('switched');
load master_topology

%load indices_for_shots4
%Vocabulary=Vocabulary(indices,:);
k=1;
for i=1:length(Vocabulary)
i
Train_Seq=Vocabulary(1:i,:);
Test_Seq=Vocabulary((length(Vocabulary)-20+1):end,:);

Train_T{k}=Build_master_topology(Train_Seq);
Test_T{k}=Build_master_topology(Test_Seq);
k=k+1;
end

%Distance
for i=1:length(Train_T)
    A = Train_T{i};
    B = Test_T{i};
    
     
    %Jenson-Shannon Distance
    JS_Distance(i)=(abs(KLDiv(A(:)',B(:)'))+abs(KLDiv(B(:)',A(:)')))/2;
    
    % Euclidean distances (L2)
    L2_Distance(i) = mean(mean(slmetric_pw(A+eps, B+eps, 'eucdist')));
    
    % compute the city block distances (L1)
    L1_Distance(i) = mean(mean(slmetric_pw(A, B, 'cityblk')));
    
    % compute the normalize correlations
    Norm_Corr_Distance(i) = mean(mean(slmetric_pw(A, B, 'nrmcorr')));
    
    % compute hamming distances
    hamming_Distance(i) = mean(mean(slmetric_pw(A, B, 'hamming', 0.5)));
    
    % Compute the parameterized metrics
    
    % compute Minkowski distance of order 3
    Minkowski_Distance(i) = mean(mean(slmetric_pw(A, B, 'minkowski', 3)));
end

figure,
subplot(2,3,1), hold on 
plot(JS_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('Jensen�Shannon divergence')

subplot(2,3,2), hold on
plot(L2_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('L2 Distance')

subplot(2,3,3), hold on
plot(L1_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('L1 Distance')

subplot(2,3,4), hold on
plot(Norm_Corr_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('normalize correlations')

subplot(2,3,5), hold on
plot(hamming_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('Hamming Distance')

subplot(2,3,6), hold on
plot(Minkowski_Distance,'LineWidth',2,'color','r'), xlabel('Number of Training Sequences'), ylabel('Minkowski Distance')

%Likelihood Computation

for i=1:length(Train_T)
    
    A = log(prod(Train_T{i}(Train_T{i}>0)));
    B = log(prod(Test_T{i}(Test_T{i}>0)));
    
    diff(i)=abs(A-B);
    
end

figure, plot(diff,'LineWidth',2), xlabel('Number of Training Sequences'), ylabel('Likelihood Difference')