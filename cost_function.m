function output = cost_function(matrix,path)
    n_sites = size(matrix,1);
    total_time = 0;
    for i = 1:n_sites - 1
        total_time = total_time + matrix(path(i),path(i + 1));
    end
    output = total_time + matrix(path(n_sites),path(1));
end