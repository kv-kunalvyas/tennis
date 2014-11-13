function TM = Compute_Dat(part,Seq)
%part{1}=[2 2 4]';
Sizzz=size(Seq);
AS=Seq;
Seq=Seq';
Seq=Seq(:);
ind=~cellfun(@isempty,Seq);
Seq=Seq(ind);
OSeq=Seq;
k=1;
for i=1:length(Seq)
         if strcmp(Seq{i},'SF'), Seq_numbered(k) = 1; k=k+1;
            elseif strcmp(Seq{i},'SN'), Seq_numbered(k) = 2; k=k+1;
            elseif strcmp(Seq{i},'HF'), Seq_numbered(k) = 3; k=k+1;
            elseif strcmp(Seq{i},'HN'), Seq_numbered(k) = 4; k=k+1;
            elseif strcmp(Seq{i},'BIN'), Seq_numbered(k) = 5; k=k+1;
            elseif strcmp(Seq{i},'BIF'), Seq_numbered(k) = 6; k=k+1;
            elseif strcmp(Seq{i},'BON'), Seq_numbered(k) = 7; k=k+1;
            elseif strcmp(Seq{i},'BOF'), Seq_numbered(k) = 8; k=k+1;
            elseif strcmp(Seq{i},'BOFS'), Seq_numbered(k) = 9; k=k+1;
            elseif strcmp(Seq{i},'BONS'), Seq_numbered(k) = 10; k=k+1;   
            end
        end

TMat3 = Build_master_topology(Seq);

 for p=1:length(part)
      Div = part{p};
     TMat2{p} = zeros(length(Div),length(Div));
 
 for j=1:length(Div)
     if j==1, A{j} = 1:Div(j); prev=Div(j);
     else A{j}=prev+1:prev+Div(j); prev=prev+Div(j);
     end
 end


%%%%%%%%%%%%%%%% BW %%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRRR = ones(length(Div))./length(Div);
% EMMM = ones(length(Div),8);
% k=1;
% for i=1:length(Div)
%     EMMM(i,k:k+Div(i)-1)=EMMM(i,k:k+Div(i)-1)+1;
%     k=k+Div(i);
% end
% 
% for i=1:length(Div)
%     EMMM(i,:)=EMMM(i,:)./sum(EMMM(i,:));
% end


%TRRR = randn(length(Div));
%EMMM = randn(length(Div),8);


%[estTR estEM] = hmmtrain(Seq_numbered,TRRR,EMMM);
% TMat2{p}=estTR;

%%%%%%%%%%%%%%%% BW %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% CLHBC %%%%%%%%%%%%%%
% 
for i=1:length(A)
    for j=1:length(A)
        
        %D(A{i},A{j}) = TMat3(A{i},A{j})*TMat2(i,j);
        
        LL=TMat3(A{i},A{j})*TMat3(A{i},A{j})';
        Li = prod(LL(LL>0));
        TMat2{p}(i,j)=Li;
        clear LL
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%% CLHBC %%%%%%%%%%%%%%

clear Div
clear A
end


for p=1:length(part)
    p/length(part)*100;
    Div = part{p};
    
for j=1:length(Div)
    if j==1, A{j} = 1:Div(j); prev=Div(j);
    else A{j}=prev+1:prev+Div(j); prev=prev+Div(j);
    end
end

D{p}=zeros(8,8);

for i=1:length(A)
    for j=1:length(A)
        
        D{p}(A{i},A{j}) = TMat3(A{i},A{j})*TMat2{p}(i,j);
        
    end
end
D{p}=mat2tmat(D{p});
clear Div
clear A
end

TM=D{1};
%D is TMat3 and TMat2

%TM = prob_inject(TMat3,estTR,part{1});





