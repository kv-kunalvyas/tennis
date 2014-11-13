function [event]=decodeEvents(symbol,event)

tokens=strsplit(symbol,' ');
y=str2num(tokens{2});
x=str2num(tokens{3});

if(strcmp(symbol(1),'S'))
    
    if(strcmp(symbol(3:end),'-3 -1'))
        event='SERVE_FAR_LEFT ';
    elseif(strcmp(symbol(3:end),'3 -1'))
        event='SERVE_NEAR_LEFT ';
    elseif(strcmp(symbol(3:end),'-3 1'))
        event='SERVE_FAR_RIGHT ';
    elseif(strcmp(symbol(3:end),'3 1') || strcmp(symbol(3:end),'2 1'))
        event='SERVE_NEAR_RIGHT ';
    else
        error('error in serve detectiond')
    end

    

end

if(strcmp(symbol(1),'B') || ((strcmp(symbol(1),'N') && ~strcmp(event(1),'S'))) )

    if(strcmp(event(1),'S'))
        if(strcmp(event,'SERVE_FAR_LEFT '))
            if(x==1 && y==1)
                event='BOUNCE_IN_NEAR_SERVE_RIGHT ';
            else
                event='BOUNCE_OUT_NEAR_SERVE ';
            end
        end
        if(strcmp(event,'SERVE_FAR_RIGHT '))
            if(x==-1 && y==1)
                event='BOUNCE_IN_NEAR_SERVE_LEFT ';
            else
                event='BOUNCE_OUT_NEAR_SERVE ';
            end
        end
        if(strcmp(event,'SERVE_NEAR_LEFT '))
            if(x==1 && y==-1)
                event='BOUNCE_IN_FAR_SERVE_RIGHT ';
            else
                event='BOUNCE_OUT_FAR_SERVE ';
            end
        end
        if(strcmp(event,'SERVE_NEAR_RIGHT '))
            if(x==-1 && y==-1)
                event='BOUNCE_IN_FAR_SERVE_LEFT ';
            else
                event='BOUNCE_OUT_FAR_SERVE ';
            end
        end
    elseif(y > 0)
        if(x<=1 && x>=-1 && y<=2)
            event='BOUNCE_IN_NEAR ';
        else
            event='BOUNCE_OUT_NEAR ';
        end
    else
        if(x<=1 && x>=-1 && y>= -2)
            event='BOUNCE_IN_FAR ';
        else
            event='BOUNCE_OUT_FAR ';
        end
    end

    prev='B';
end % end of bounce events

if(strcmp(symbol(1),'H'))
    if(y > 0)
        event='HIT_NEAR ';
    else
        event='HIT_FAR ';
    end
    prev='H';
end

if(strcmp(symbol(1),'N'))
    %if(strcmp(symbol(1),'N') && strcmp(prev,'S'))
    event='NET ';
    prev='N';
end
