function img = split(I, Method)
    if nargin == 1
        img = splitKmeans(I);
        return;
    end

    if Method == 'kmeans'
        img = splitKmeans(I);
    elseif Method == 'maxflux'
        img = splitMaxflux(I);
    else
        msgID = 'SPLIT:Method not implemented.';
        msg = 'No such a method.';
        baseException = MException(msgID,msg);
        throw(baseException);
    end
end