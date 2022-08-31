% lab05.m
% Brady Berg

clear
close all
format compact

%% Initial model

%{
% oscillatory conditions
epsilon = 0.08;
a = 0.5;
b = 0.2;
initial = [0,-0.5];
%}

% excitability conditions
epsilon = 0.08;
a = 1.0;
b = 0.2;
% initial = [-1.5,-0.5];  % direct to steady state
initial = [0,-0.5];     % indirect to steady state

dvdt = @(v,w) v - v^3/3 - w;
dwdt = @(v,w) epsilon * (v + a - b*w);

sys = @(t,x) [dvdt(x(1),x(2));
                dwdt(x(1),x(2))];

[T,X] = ode45(sys, [0,100], initial);

steadyV = X(end,1);
steadyW = X(end,2);

figure(1)
plot(T,X(:,1),'-r', T,X(:,2),'-b')
legend('voltage', 'ion pump activity')

%% Adding in an injection

I0 = 1.0;
tStart = 40;
tStop = 47;
I = @(t) I0 * (t>tStart) .* (t<tStop);
dvdt = @(t,v,w) v - v.^3/3 - w + I(t);
dwdt = @(v,w) epsilon * (v + a - b*w);

sys = @(t,x) [dvdt(t,x(1),x(2));
                dwdt(x(1),x(2))];

[T,X] = ode45(sys, [0,100], [steadyV; steadyW]);

figure(2)
plot(T,X(:,1),'-r', T,X(:,2),'-b')
legend('voltage', 'ion pump activity')

%% Chain of cells

epsilon = 0.08;
a = 1.0;
b = 0.2;
D = 0.9;    % electrical connectivity
I0 = 1.0;

dvdt = @(t,x) x(1:10) - (1/3) * x(1:10).^3 - x(11:20) + ... 
    D * ([x(10);x(1:9)] - 2*x(1:10) + [x(2:10);x(1)]);
dwdt = @(t,x) epsilon * (x(1:10) + a - b*x(11:20));

sys = @(t,x) [dvdt(t,x); dwdt(t,x)];
[T,X] = ode45(sys, [0,100], rand(1,20));
figure(3)
plot(T,X)

% for idx = 2:9
%     if idx == 4
%         tStart = 40;
%         tStop = 47;
%         I(idx) = @(t) I0 * (t<tStart) .* (t>tStop);
%         dvdt(idx) = @(t,v,w) v(idx) - (1/3) * v(idx).^3 - w(idx) + I(t) ...
%             + D * (v(idx-1) - 2*v(idx) + v(idx+1));
%     else
%         dvdt(idx) = @(t,v,w) v(idx) - (1/3) * v(idx).^3 - w(idx) ...
%             + D * (v(idx-1) - 2*v(idx) + v(idx+1));
%     end
%     dwdt(idx) = @(t,v,w) epsilon * (v(idx) + a - b*w(idx));
% end
