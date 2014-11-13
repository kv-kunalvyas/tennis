% % Search value 'v' in sorted vector 'x' and find index and value
% % with respect to vector x that is equal or closest to 'v'.
% % 
% % If more than one value is equal then anyone can be returned
% % (this is property of binary search).
% % If more than one value is closest then first occurred is returned
% % (this is property of linear search).
% % 
% % 
% % Algorithm
% % First binary search is used to find v in x. If not found
% % then range obtained by binary search is searched linearly
% % to find the closest value.
% % 
% % INPUT:
% % x: vector of numeric values,
% % x should already be sorted in ascending order
% %    (e.g. 2,7,20,...120)
% % v: numeric value to be search in x
% %  
% % OUTPUT:
% % i: index of v with respect to x. 
% % cv: value that is equal or closest to v in x 
       
function [i,cv] = searchclosest(x,v)

i=[];
from=1;
to=length(x);

% % Phase 1: Binary Search
while from<=to
    mid = round((from + to)/2);    
    diff = x(mid)-v;
    if diff==0
        i=mid;
        cv=v;
        return
    elseif diff<0     % x(mid) < v
        from=mid+1;
    else              % x(mid) > v
        to=mid-1;			
    end
end

% % Phase 2: Linear Search
% % Remember Bineary search could not find the value in x
% % Therefore from > to. Search range is to:from
y=x(to:from);             %vector to be serach for closest value
[ignore,mini]=min(abs(y-v));
cv=y(mini);
% % cv: closest value
% % mini: local index of minium (closest) value with respect to y

% % find global index of closest value with respect to x
i=to+mini-1;

% % % --------------------------------
% % % Author: Dr. Murtaza Khan
% % % Email : drkhanmurtaza@gmail.com
% % % --------------------------------


