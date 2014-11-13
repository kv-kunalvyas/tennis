function Vocabulary = main(method) %'switched'
if nargin<1
    method = 'non-switched';
end


switch lower(method)
    case{'switched'}
    load switched_grid_events
    corrected_grid_events=switched_grid_events;
    otherwise
    load grid_events
    corrected_grid_events=grid_events;
end   
    
maxShotsize=29;                                                             %29 for BadmintonCzechGB
badminton_pmF = zeros(4,4);
badminton_pmN = zeros(4,4);
mat_dir=zeros(6,6);
VocabularyN = zeros(1,1);
VocabularyF = zeros(1,1);
index=findstring(corrected_grid_events,'NET');
corrected_grid_events(index,:)=[];
index=findstring(corrected_grid_events,'SNL');
for i=1:length(index), corrected_grid_events(index(i),:)='SN   '; end
index=findstring(corrected_grid_events,'SNR');
for i=1:length(index), corrected_grid_events(index(i),:)='SN   '; end
index=findstring(corrected_grid_events,'SFL');
for i=1:length(index), corrected_grid_events(index(i),:)='SF   '; end
index=findstring(corrected_grid_events,'SFR');
for i=1:length(index), corrected_grid_events(index(i),:)='SF   '; end

index=findstring(corrected_grid_events,'BONS');
for i=1:length(index), corrected_grid_events(index(i),:)='BON  '; end

index=findstring(corrected_grid_events,'BOFS');
if index~=0, for i=1:length(index), corrected_grid_events(index(i),:)='BOF  '; end, end

Vocabulary = buildVocabulary(corrected_grid_events, maxShotsize);