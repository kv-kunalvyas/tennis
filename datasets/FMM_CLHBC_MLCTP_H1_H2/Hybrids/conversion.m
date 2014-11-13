function [newevents, f] = conversion(footage_data)

evCount=0;
containsServe=0;
prevEvent=' ';
%newevents=' ';
k=1;
for j=1:length(footage_data.grid_events)
symbol=footage_data.grid_events{j};
if(~isempty(symbol))
evCount=evCount+1;
if(strcmp(symbol(1),'S'))
containsServe=1;
end
tokens=strsplit(symbol,' ');
y=str2num(tokens{2});
x=str2num(tokens{3});
[event]=decodeEvents(symbol,prevEvent);
%fprintf('%s\n',event);
prevEvent=event;
f(k) = footage_data.event_frame(j);
newevents(k,1) = {event};
k=k+1;
end
end