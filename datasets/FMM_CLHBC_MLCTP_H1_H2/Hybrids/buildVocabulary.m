function Vocabulary = buildVocabulary(corrected_grid_events, NgramSize)

%grid_events=corrected_grid_events;

NgramSize = 29;
Vocabulary = cell(0, NgramSize+2);
f=ones(length(corrected_grid_events),1);
currWord = cell(NgramSize+2, 1);            
for t=1:1
    % Grab all events
    
    
    events = cellstr(corrected_grid_events);
    f(corrected_grid_events(:,1)=='S')=1;
    % Build an index of serves
    serve_flag = false(numel(events),1);
    for e=1:numel(events)
        if ~isempty(events{e})
            serve_flag(e) = events{e}(1)=='S';
            event_f(e)=f(e);
        end
    end
    
    % For each serve...
    serve_idx = find(serve_flag);
    serve_f = event_f(serve_flag);
    for s=1:numel(serve_idx)
        % index of the beginning of the word
        p = serve_idx(s);
        
        % index of the end of the word:
        if s < numel(serve_idx)
            pPlus1 = serve_idx(s+1);
        else
            pPlus1 = serve_idx(end);
        end

        lastNgram = pPlus1-NgramSize;
        if lastNgram < p
            lastNgram = p;
            currNgramSize = pPlus1 - lastNgram;
        else
            currNgramSize = NgramSize;
        end
        for c=p:lastNgram
            for cw = 1:NgramSize+2
                currWord{cw} = '';
            end
            currWord(1:currNgramSize) = events(c:c+currNgramSize-1);
            Vocabulary(end+1, :) = currWord'; 
            
        end
    end
end

strVoc = Vocabulary(:,1);
for r=1:size(Vocabulary,1)
    strVoc{r} = [strVoc{r},Vocabulary{r,2:end-2}];
end

Mn = [{Vocabulary{:,end}};{Vocabulary{:,end-1}};{strVoc{:}}]';

uniqueStrVoc = unique(strVoc);


% sprintf('%s %d %d', char(floor(str/100)), (floor(rem(str,100)/10))-3, rem(str,10)-3)