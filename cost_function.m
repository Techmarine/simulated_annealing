function output = cost_function(matrix,path)
    n_sites = size(matrix,1);
    total = 0;
    for i = 1:n_sites - 1
        total = total + matrix(path(i),path(i + 1));
    end
    output = total + matrix(path(n_sites),path(1));
end