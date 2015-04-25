% close all;
% clear all;
% clc;

load('travel_data.mat');
%Travel data contains matrix of distances between cities and coordinates of 
%each city. The same information is contained in travel_data.xlsx.
n_cities = numel(cities); %number of cities

%Simulated annealing algorithm---------------------------------------------
path = 1:n_cities; %initial solution
path0 = path; %initial solution for plot
temperature = 1e5;
final_temperature = 0.1;
cooling_factor = 0.99;
i = 1;
while temperature > final_temperature
    
    %Swap two cities in path randomly
    new_path = path;
    swap_point1 = randi(n_cities - 1);
    swap_point2 = randi(n_cities - 1);
    new_path(swap_point1) = path(swap_point2);
    new_path(swap_point2) = path(swap_point1);
    
    %Calculate cost function, its difference and decide whether to update
    %path or not
    cost = cost_function(distances,path); %for record
    delta_cost = cost - cost_function(distances,new_path);
    if exp(delta_cost/temperature) > rand;
        path = new_path;
    end
    
    %Record cost for plot
    record(i) = cost;
    i = i + 1;
    
    %Update temperature
    temperature = temperature*cooling_factor;
end
%Simulated annealing algorithm---------------------------------------------

colors = [
    1 0 0
    1 0.4 0.4
    0.95 0.95 0
    0 0.9 0
    0 0.9 0.9
    0 0 1
    0.7 0 0.9
    0.3 0.5 0
    0.0 0.3 0.6
    0 0 0
];

%Cost vs Iteratoins plot
figure;
plot(record);
grid on;
xlabel('Iterations');
ylabel('Cost');

%Cities locations and path with initial solution
figure;
hold on;
for i = 1:n_cities;
    plot(latitudes(i),longitudes(i),'.','color',colors(i,:),'MarkerSize',20);
end
legend(cities,'location','eastoutside');
plot([latitudes(path0)',latitudes(path0(1))],[longitudes(path0)',longitudes(path0(1))],'-black');
hold off;
xlabel('Latitude');
ylabel('Longitude');
title('Initial solution');

%Cities locations and path with final solution
figure;
hold on;
for i = 1:n_cities;
    plot(latitudes(i),longitudes(i),'.','color',colors(i,:),'MarkerSize',20);
end
legend(cities,'location','eastoutside');
plot([latitudes(path)',latitudes(path(1))],[longitudes(path)',longitudes(path(1))],'-black');
hold off;
xlabel('Latitude');
ylabel('Longitude');
title('Final solution');