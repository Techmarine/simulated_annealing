function output = cost_function(matrix,path)
    n = size(matrix,1);
    total = 0;
    for i = 1:n - 1
        total = total + matrix(path(i),path(i + 1));
    end
    output = total + matrix(path(n),path(1));
end