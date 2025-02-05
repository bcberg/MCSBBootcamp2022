% lab03.m
% Brady Berg

clear
close all
format compact

%% Section 2.3

% ------------------------------------------------------
A     = 1.1; % fluorescence intensity units
omega = 2.6; % rad/s
A_0   = 0.01;

u=@(t) A*sin(omega*t)+A_0;

tArray = linspace(0,1.6,200);
uArray = u(tArray); % an array of samples of u
% ------------------------------------------------------

% analytical solutions (in real life, we might not know these)
dudtExact      =  A*omega*cos(omega*tArray);
du2dt2Exact    = -A*omega^2*sin(omega*tArray);
du3dt3Exact    = -A*omega^3*cos(omega*tArray);

% Take the sample and add a bit of noise
uObserved = u(tArray) + (1e-6)*randn(size(tArray)); % original noise std. dev. 1e-1

figure(1)
plot(tArray,uObserved, '+')

% create finite-difference derivatives for first derivative, second derivative and third derivative
dudt   = diff(uObserved)./diff(tArray);
du2dt2 = diff(dudt)./diff(tArray(1:end-1));
du3dt3 = diff(du2dt2)./diff(tArray(1:end-2));

% and plot them
figure(2)
subplot(3,1,1); hold on;
plot(tArray(1:end-1), dudt);
plot(tArray, dudtExact, '--r');
xlabel('t');
ylabel('dudt');

subplot(3,1,2); hold on;
plot(tArray(1:end-2), du2dt2);
plot(tArray, du2dt2Exact, '-r');
xlabel('t');
ylabel('du2dt2')

subplot(3,1,3); hold on;
plot(tArray(1:end-3), du3dt3);
plot(tArray, du3dt3Exact, '-r');
plot(tArray, du3dt3Exact*0.9, 'm--')
plot(tArray, du3dt3Exact*1.1, 'm--')
xlabel('t');
ylabel('du3dt3')

% computing percent error pointwise
perError3 = 100 * abs((du3dt3 - du3dt3Exact(1:end-3)) ./ du3dt3Exact(1:end-3));
display(max(perError3))

% computing percent error of the mean absolute value
meanAbsNoisy = sum(abs(du3dt3)) / length(du3dt3);
meanAbsExact = sum(abs(du3dt3Exact)) / length(du3dt3Exact);
perErrorMeanAbs = 100 * abs((meanAbsNoisy - meanAbsExact) / meanAbsExact);
display(perErrorMeanAbs)

% computing percent error of the mean value
meanNoisy = sum(du3dt3) / length(du3dt3);
meanExact = sum(du3dt3Exact) / length(du3dt3Exact);
perErrorMean = 100 * abs((meanNoisy - meanExact) / meanExact);
display(perErrorMean)