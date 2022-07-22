Task = XValidation(:,:,1,1);
Schedule = [14.00000,12.00000,11.00000,8.00000,0.00000,0.00000,0.00000,10.00000,10.00000,9.00000,7.00000,6.00000,5.00000,6.00000,4.00000
];
Schedule = [15.00000,0.00000,13.00000,14.00000,0.00000,0.00000,0.00000,11.00000,12.00000,10.00000,9.00000,8.00000,7.00000,6.00000,5.00000
];
fprintf("cost is %f\n",overallCost(Schedule,Task));
function cost = overallCost(schedule, tasks)
    drop_len = length(schedule(schedule == 0));
    [~,idx] = sort(schedule,'descend');
    drop_cost = droppingCost(idx(15-drop_len+1:15),tasks);
    delay_cost = computeDelayCost(idx(1:15-drop_len)', tasks);
    cost = drop_cost + delay_cost;
end


function costs = computeDelayCost(Ts,tasks)
len = size(Ts,2);
times = zeros(1,len);
costs = zeros(1,len);
for i = 1 : size(Ts,1)
    tks = tasks(:,Ts(i,:));
    exe_times = max(tks(1,:),times);
    times = exe_times + tks(3,:);
    costs = costs + (exe_times - tks(1,:)).*tks(4,:).*...
        (exe_times <= (tks(1,:)+tks(2,:)));
    costs = costs + tks(5,:).*(exe_times > (tks(1,:)+tks(2,:)));
end
end

function c = droppingCost(DR_p, tasks)
c = sum(tasks(5,DR_p));
end