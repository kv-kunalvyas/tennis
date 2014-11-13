function Complete_generator(al,ga,matf,Vocabulary,permuts,n,filenumber,Method)

    


    load(matf)
    disp([al,ga])
    k=1;

if Topologies{floor(al*100),floor(ga*100)}{1}.No_Output==1
    DMM{al*100,ga*100}.C{k}=0;
else
    for i=1:length(Topologies{floor(al*100),floor(ga*100)})
        disp(strcat(num2str(i/length(Topologies{floor(al*100),floor(ga*100)})*100), '%'))
        DMM{floor(al*100),floor(ga*100)}.C{k} = complete_top(Topologies{floor(al*100),floor(ga*100)}{i},Vocabulary,permuts,n);
        k=k+1;
    end  

end

if filenumber==1
    matFilename = ['Badminton_top-' num2str(al) 'and' num2str(ga) 'DMM.mat'];
elseif filenumber==2
    matFilename = ['Tennis_top-' num2str(al) 'and' num2str(ga) 'DMM.mat'];
elseif filenumber==3
    matFilename = ['Drive_top-' num2str(al) 'and' num2str(ga) 'DMM.mat'];
end
save(matFilename,'DMM')

end