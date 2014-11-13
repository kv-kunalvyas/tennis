iterations=500;
sizes=13; %8 for badminton, 16 for tennis, 11 for MSN and HumanActivity
depth=10;
k=1;
A = 0.01:0.01:0.01;
B = 0.05:0.05:0.5;
for al=0.01:0.01:0.01
    for ga=0.05:0.05:0.5
        sizes
        disp('Generating Topologies...')
        disp(strcat(num2str(k/(length(A)*length(B))*100), '%'))
        MLHDP_Complete(al,ga,iterations,sizes,depth)
        
        k=k+1;
    end
end

Final_Topologies_Listing(A,B,sizes,iterations,depth)