% lab06.m
% Brady Berg

clear
close all
format compact

%% Initial model implementation

lambda = 1.0;
theta = 1e3;
alpha = 2.0;
N0 = 200;

dNdt = @(t,N) lambda * N .* (1 - (N/theta).^alpha);
[T,N] = ode45(dNdt, [0, 120], N0);
figure(1)
plot(T,N)

%% Data input

sampleT = 0:20:120;
bacLB = [0.091, 0.103, 0.136, 0.211, 0.354, 0.476, 0.602];
bacSOC = [0.101, 0.106, 0.119, 0.214, 0.341, 0.498, 0.669];
figure(2)
plot(sampleT, bacLB, '-bo', sampleT, bacSOC, '-rd')
legend('LB', 'SOC', 'Location', 'southeast')

%% Compute sum of squared error

[~,N] = ode45(dNdt, sampleT, 0.1);
SSE = sum((transpose(N)-bacLB).^2);
% display(SSE)

%% Fitting parameters

bestParamLB = fminsearch(@getSSE_LB, [1e-2,1.5,10]);
lamLB = bestParamLB(1);
thLB = bestParamLB(2);
alLB = bestParamLB(3);
dNdtLB = @(t,N) lamLB * N .* (1 - (N/thLB).^alLB);
[T,N_LB] = ode45(dNdtLB, [0,180], bacLB(1));
figure(3)
plot(sampleT,bacLB,'-bo')
hold on
plot(T,N_LB,'-r')
title(['SSE = ', num2str(getSSE_LB([lamLB,thLB,alLB]))])
xlim([0,180])

%% Functions

function SSE_LB = getSSE_LB(param)
    % record dataset
    sampleT = 0:20:120;
    bacLB = [0.091, 0.103, 0.136, 0.211, 0.354, 0.476, 0.602];

    % compute model that uses the input parameters
    lam = param(1);
    th = param(2);
    al = param(3);
    dNdt = @(t,N) lam * N .* (1 - (N/th).^al);
    [~,N] = ode45(dNdt, sampleT, bacLB(1));
    
    % compare model to dataset
    SSE_LB = sum((transpose(N) - bacLB).^2);
end