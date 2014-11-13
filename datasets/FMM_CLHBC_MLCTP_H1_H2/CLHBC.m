%N=1 badminton, N=2 Driving

function Final_CP_TM = CLHBC(F,Voc,N)


if N==1

F=F';
F=F(:);
F=F(~cellfun(@isempty,F));
F=char(F);    
sizeofF=size(F);
tt=sizeofF(1);
    
    
Seq=Voc';
Seq=Seq(:);
Seq=Seq(~cellfun(@isempty,Seq));
Seq=char(Seq);
sizeofseq=size(Seq);

for n=1:sizeofseq(1,2)
    sequencerow{n} = Seq(:,n);
    
end

for n=1:sizeofF(1,2)
    sequencerowt{n} = F(:,n);
end

%for base
Seq = cellstr(Seq);
[ign1 ign2 numbered_seq] = unique(Seq);
train=cellstr(F);
[ignt1 ignt2 numbered_seq2] = unique(train);
ign1b = ign1;
ignt1b = ignt1;
for i=1:length(train)
        [a b] = ismember(train(i,:),ign1);
        Seq_train(i) = b;
end

%[basetm SeqB] = Build_master_topology(base,1); %1 for badminton, none for
%drive --- for comparison to Build_transition_matrix

basetm = Gen_Transition_Matrix(Seq_train,length(ign1));


L = length(sequencerow);

%number of levels = L if labels are consistent, L-1 if non-consistent by 1

%first bottom level has tm = basetm

for i=1:L
    check(i)=~isempty(find(sequencerow{i}==' '));
end

Le=length(find(check==0));

for i=1:Le-2
    if i==1, level2seq = strcat(sequencerow{i},sequencerow{i+1});
        level2trainseq = strcat(sequencerowt{i},sequencerowt{i+1});
    else level2seq=strcat(level2seq,sequencerow{i+1});
        level2trainseq = strcat(level2trainseq,sequencerowt{i+1});
    end
   
end
    
%for level2     
clear Seq
Seq = cellstr(level2seq);
[ign1 ign2 numbered_seq] = unique(Seq);
train=cellstr(level2trainseq);
[ignt1 ignt2 numbered_seq2] = unique(train);



for i=1:length(train)
        [a b] = ismember(train(i,:),ign1);
        Seq_train(i) = b;
end

l2tm = Gen_Transition_Matrix(Seq_train,length(ign1));
   
    
%to get injection parameter Div

BASE = char(ign1b);
BASE = BASE(:,1:2);
BASE = cellstr(BASE);

[un un2 A]=unique(BASE);
[b m n] =unique(A);

x=n;
y = zeros(size(x));
for i = 1:length(x)
y(i) = sum(x==x(i));
end

Div =y(m);

NuM1 = [7 8 5 6 3 1 4 2];
basetm = basetm(NuM1,NuM1);

NuM2 = [3 2 1];
l2tm = l2tm(NuM2,NuM2);
Div=Div(NuM2);
Final_CP_TM = prob_inject(basetm,l2tm,Div);
   
    
elseif N==2

        tt=100;        
load Driving_Eventsfix1
Seq = Driving_Events';    

Seq=char(Seq);
sizeofseq=size(Seq);

for n=1:sizeofseq(1,2)
    sequencerow{n} = Seq(:,n);
end
    
Seq = cellstr(Seq);
[ign1 ign2 numbered_seq] = unique(Seq);
train=Seq(1:tt,:);
[ignt1 ignt2 numbered_seq2] = unique(train);

for i=1:length(train)
        [a b] = ismember(train(i,:),ign1);
        Seq_train(i) = b;
end



%[basetm SeqB] = Build_master_topology(base,1); %1 for badminton, none for drive


basetm = Gen_Transition_Matrix(Seq_train,length(ign1));
Final_CP_TM=0;

end