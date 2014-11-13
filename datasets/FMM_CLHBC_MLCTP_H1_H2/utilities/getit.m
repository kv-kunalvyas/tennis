function c=getit(c)
if iscell(c)
   c = cellfun(@getit, c, 'UniformOutput', 0);
   c = cat(2,c{:});
else
   c = {c};
end