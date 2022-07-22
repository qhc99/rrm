function [X, Y] = loadData(N,tasks, schedules)
T = table2array(tasks);
X = single(T);
len = size(X,2);
X = reshape(X,5,N,1,len);
S = table2array(schedules);
schedules = int8(S);
Y = single(zeros(len,N*(N+1)));
fprintf("load file done\n")

for i = 1:len
    schedule = schedules(:,i);
    order = ones(N,1)*11;
    o = schedule(schedule > 0);
    l = length(o);
    order(o) = 1:l;
    Y(i,order + (0:(N+1):(N-1)*(N+1))') = 1;

    y_temp = reshape(Y(i,:),N+1,N);
    
    [~,arg] = sort(X(1,:,1,i));
    X(:,:,1,i) = X(:,arg,1,i);
    y_temp = y_temp(:,arg);
    y_temp = reshape(y_temp,(N+1)*N,1);
    Y(i,:) = y_temp;
end
X = permute(X,[4,3,1,2]);
end

