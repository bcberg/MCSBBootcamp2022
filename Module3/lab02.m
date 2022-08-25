% lab02.m
% Brady Berg

clear
close all
format compact

%% Project 2 part c

r = 0.1;
K = 0.6;
numMonths = 100;
numStarts = 5;
popStart = rand([1,numStarts]);
figure(1)
hold on;
for idx = 1:numStarts
    popCurve = zeros(1,numMonths);
    popCurve(1) = popStart(idx);
    for jdx = 2:numMonths
        popCurve(jdx) = popCurve(jdx-1) + r * (1 - popCurve(jdx-1) / K) ...
        * popCurve(jdx-1);
    end
    plot(1:numMonths,popCurve,'DisplayName',num2str(popStart(idx),4))
end
legend('show','Location','southeast')

%% Part d

r = 2.1;
K = 0.6;
numMonths = 100;
numStarts = 5;
popStart = 0.6 * rand([1,numStarts]);
figure(2)
hold on;
for idx = 1:numStarts
    popCurve = zeros(1,numMonths);
    popCurve(1) = popStart(idx);
    for jdx = 2:numMonths
        popCurve(jdx) = popCurve(jdx-1) + r * (1 - popCurve(jdx-1) / K) ...
        * popCurve(jdx-1);
    end
    plot(1:numMonths,popCurve,'DisplayName',num2str(popStart(idx),4))
end
legend('show','Location','southeast')
hold off;

%% Part e

r = 2.5;
K = 0.6;
popCurve(1) = 0.1;
for jdx = 2:numMonths
        popCurve(jdx) = popCurve(jdx-1) + r * (1 - popCurve(jdx-1) / K) ...
            * popCurve(jdx-1);
end
figure(3)
plot(1:numMonths,popCurve)

%% Part g

resolution = 100;
r = linspace(0,3,resolution+2);
r = r(2:(end-1));
numMonths = 400;
figure(4)
hold on;
for rate = r
    popCurve = zeros(1,numMonths);
    popCurve(1) = 0.1;
    for idx = 2:numMonths
        popCurve(idx) = popCurve(idx-1) + rate * (1 - popCurve(idx-1) / K) ...
            * popCurve(idx-1);
    end
    steadyVals = popCurve(3*end/4:end);
    plot(rate * ones(length(steadyVals)), steadyVals, '*k')
end