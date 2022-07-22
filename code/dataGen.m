clear;clc;close all;
N = 10;
simulations = 2e6;

uni_dist_start = [1,50];
uni_dist_deadline_diff = [2,12];
uni_dist_length = [2,11];
uni_dist_delay_weight = [1,5];
uni_dist_drop_cost = [100,500];
uni_dist = @(ab,N) ab(1) + (ab(2)-ab(1)).*(rand(1,N));
% train with 1, test with 2
rng(2023);

tasks_data = table('Size',[N*5,simulations], 'VariableTypes', repmat("singlenan",1,simulations));
schedules_data = table('Size',[N,simulations], 'VariableTypes', repmat("singlenan",1,simulations));
fprintf("start generation\n");
for s = 1 : simulations
    % start time, deadline diff, length, delay, drop
    if(rem(s,1000) == 0)
        fprintf("%d\n",s);
    end
    tasks = [
            uni_dist(uni_dist_start,N)
            uni_dist(uni_dist_deadline_diff,N)
            uni_dist(uni_dist_length,N)
            uni_dist(uni_dist_delay_weight,N)
            uni_dist(uni_dist_drop_cost,N)
            ];
    optimal = BAB(tasks);
    while(~optimal.valid)
        tasks = [
            uni_dist(uni_dist_start,N)
            uni_dist(uni_dist_deadline_diff,N)
            uni_dist(uni_dist_length,N)
            uni_dist(uni_dist_delay_weight,N)
            uni_dist(uni_dist_drop_cost,N)
            ];
         optimal = BAB(tasks);
    end

    schedules_data{1:length(optimal.schedule),s}  = optimal.schedule';
    tasks_data{:,s} = reshape(tasks,[N*5,1]); % column
end

save("table_data_2e6.mat","tasks_data", "schedules_data")



