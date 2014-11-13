function index=findstring(tab,str)

% find the row index containing a matching string

% returns 0 if the string is not found
index = 0;
[nrows,ncols]=size(tab);
k=1;
for idx=1:nrows

    matches = findstr(tab(idx,:),str);

    if (length(matches)>0)

        index(k)=idx;
        k=k+1;

    end;

end;



return;