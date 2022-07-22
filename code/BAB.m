function T_optimal = BAB(tasks)
% Branch & Bound Algorithm
% tasks: 2-dim array
T_optimal.valid = false;
stack = Stack();
UB = inf;
n = Node();
n.PF = 1:size(tasks,2);
stack.add(n);
node_add = 0;
node_rm = 0;

while (stack.size ~= 0)
    n = stack.top();
    if(~isempty(n.PF))
        j = n.PF(end);
        n.PF(end)=[];
        T_p = n.T.deepcopy();
        T_p.addTask(j,tasks);
        PF_p = [n.PF, n.NS];
        PF_p = unique(PF_p);
        NS_p = [];
        n.NS = unique([n.NS, j]);
        
        dropped_idx = (tasks(1,PF_p)+tasks(2,PF_p)) < T_p.time;
        DR_p = [n.DR,PF_p(dropped_idx)];
        PF_p(dropped_idx) = [];

        C_p = T_p.delay_cost + droppingCost(DR_p, tasks);

        b1 = isActive(T_p, n.T, PF_p, tasks);
        b2 = isLOWSActive(T_p,tasks);
        if( b1 && b2&& C_p < UB)
            n_t =  Node();
            n_t.init(T_p, PF_p, NS_p, DR_p)
            stack.add(n_t);
            node_add = node_add + 1;
        end
        
    else
        drc =  droppingCost(n.DR,tasks);
        C = n.T.delay_cost + drc;
        if(isempty(n.NS) && C < UB)
            UB = C;
            T_optimal.schedule = n.T.task_indices;
            T_optimal.delay_cost = n.T.delay_cost;
            T_optimal.time = n.T.time;
            T_optimal.drop_cost = drc;
            T_optimal.node_add = node_add;
            T_optimal.node_rm = node_rm;
            T_optimal.valid = true;
        end
        stack.remove();
        node_rm = node_rm + 1;
    end
end
end

function c = droppingCost(DR_p, tasks)
c = sum(tasks(5,DR_p));
end

function b = isActive(T_p, T, PF_p, tasks)
b = true;
added_task_idx = T_p.task_indices(end);
added_task = tasks(:, added_task_idx);
origin_time = T.time;
for i = 1 : length(PF_p)
    idx = PF_p(i);
    task = tasks(:,idx);
    t = max(task(1),origin_time) + task(3);
    t = max(added_task(1), t) + added_task(3);
    b = b && (t > T_p.time);
end
end

function b = isLOWSActive(T_p,tasks)
len = length(T_p.task_indices);
if len == 1
    b = true;
    return;
end
Ts = repmat(T_p.task_indices',1,len-1);
for i = 1 : len-1
    Ts(i:i+1,i) = Ts(i+1:-1:i,i);
end
c = computeDelayCost(Ts,tasks);
b = all(c >= T_p.delay_cost);
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
