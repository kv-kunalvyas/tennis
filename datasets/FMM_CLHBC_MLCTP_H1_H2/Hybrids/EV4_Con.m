clear
for i=1:25
    i
    [LH_Train(i) TrMatrix{i}] = EV4_Hierarchy(i);
end
[LH_Test TeMatrix] = EV4_Hierarchy_Test(i+1);

plot(abs(LH_Train-LH_Test))

for i=1:length(LH_Train)
    A = TrMatrix{i};
    B = TeMatrix;
    
     
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

subplot(2,3,1)
plot(JS_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('Jensen–Shannon divergence')

subplot(2,3,2)
plot(L2_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('L2 Distance')

subplot(2,3,3)
plot(L1_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('L1 Distance')

subplot(2,3,4)
plot(Norm_Corr_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('normalize correlations')

subplot(2,3,5)
plot(hamming_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('Hamming Distance')

subplot(2,3,6)
plot(Minkowski_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('Minkowski Distance')

figure, subplot(2,1,1)
plot(JS_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('Jensen–Shannon divergence')

subplot(2,1,2)
plot(Norm_Corr_Distance,'LineWidth',2)
xlabel('Number of Training Sequences')
ylabel('normalize correlations')


