% lab01.m
% Brady Berg

clear
close all
format compact

%% Project 1 (abc)

iter = 22;
x = zeros(1,iter);
y = zeros(1,iter);
% try small changes in c and d for part g
c = -0.8;
d = 0.156;

x(1) = 0.1;
y(1) = 0.1;

for idx = 2:iter
    x(idx) = x(idx-1)^2 - y(idx-1)^2 + c;
    y(idx) = 2 * x(idx-1) * y(idx-1) + d;
end

figure(1)
plot(x,'-ob')
xlabel('iteration')
ylabel('x value')

figure(2)
plot(y,'-or')
xlabel('iteration')
ylabel('y value')

figure(3)
plot(x,y,'b.')
xlabel('x')
ylabel('y')

close all

%% Part d

numRand = 1e5;

xStart = -2 + 4 * rand([1,numRand]);
yStart = -2 + 4 * rand([1,numRand]);

figure(4)
plot(xStart,yStart,'.k')

%% Part e

outside = false(1,numRand);
x22 = zeros(1,numRand);
y22 = zeros(1,numRand);
for idx = 1:numRand
    newX = zeros(1,iter);
    newY = zeros(1,iter);
    newX(1) = xStart(idx);
    newY(1) = yStart(idx);
    for jdx = 2:iter
        newX(jdx) = newX(jdx-1)^2 - newY(jdx-1)^2 + c;
        newY(jdx) = 2 * newX(jdx-1) * newY(jdx-1) + d;
    end
    if abs(newX(iter)) > 2 || abs(newY(iter)) > 2
        outside(idx) = true;
    elseif isnan(newX(iter)) || isnan(newY(iter))
        outside(idx) = true;
    end
end

figure(5)
plot(xStart(outside), yStart(outside), '.r', 'MarkerSize', 2)
hold on;
plot(xStart(~outside), yStart(~outside), '.b', 'MarkerSize', 2)

%% Part h

timeOutside = zeros(1,numRand);
for idx = 1:numRand
    newX = zeros(1,iter);
    newY = zeros(1,iter);
    newX(1) = xStart(idx);
    newY(1) = yStart(idx);
    for jdx = 2:iter
        newX(jdx) = newX(jdx-1)^2 - newY(jdx-1)^2 + c;
        newY(jdx) = 2 * newX(jdx-1) * newY(jdx-1) + d;
        if abs(newX(jdx)) > 2 || abs(newY(jdx)) > 2
            timeOutside(idx) = jdx;
            break
        end
    end
    if timeOutside(idx) > 0
        continue
    end
end
figure(6)
scatter(xStart,yStart,1,timeOutside)