function index = nthmin(vector, n)
    for i = 1 : (n - 1)
        [~,position] = min(vector);
        vector(position) = Inf;
    end
    [~, index] = min(vector);
end