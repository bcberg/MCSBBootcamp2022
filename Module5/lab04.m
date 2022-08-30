% lab04.m
% Brady Berg

clear
close all
format compact

%% Configuring system of ODEs

kAon = 10;  % (s*uM)^-1
kAoff = 10; % s^-1
kIon = 10;  % (s*uM)^-1
kIoff = 10; % s^-1
kIcat = 10; % s^-1
kAcat = 100;    % s^-1

Ptot = 1;   % uM
Ktot = 1;   % uM

% order of conc variable: A, AP, I, IK

dAdt = @(conc) -kAon * (Ptot - conc(2)) .* conc(1) + kAoff * conc(2) ...
    + kAcat * conc(4);
dAPdt = @(conc) kAon * (Ptot - conc(2)) .* conc(1) - kAoff * conc(2) ...
    - kIcat * conc(2);
dIdt = @(conc) -kIon * (Ktot - conc(4)) .* conc(3) + kIoff * conc(4) ...
    + kIcat * conc(2);
dIKdt = @(conc) kIon * (Ktot - conc(4)) .* conc(3) - kIoff * conc(4) ...
    - kAcat * conc(4);

system = @(t,conc) [dAdt(conc); dAPdt(conc); dIdt(conc); dIKdt(conc)];

init = [0; 0; 1; 0];
[T,X] = ode45(system, [0,10], init);

figure(1)
subplot(2,2,1)  % plot for A
plot(T,X(:,1))
xlabel('time (s)')
ylabel('[A] (uM)')

subplot(2,2,2)  % plot for AP
plot(T,X(:,2))
xlabel('time (s)')
ylabel('[AP] (uM)')

subplot(2,2,3)  % plot for I
plot(T,X(:,3))
xlabel('time (s)')
ylabel('[I] (uM)')

subplot(2,2,4)  % plot for IK
plot(T,X(:,4))
xlabel('time (s)')
ylabel('[IK] (uM)')

%% Parameter sweep (Ktot)

N = 1e2;
param = logspace(-3,2,N);
steadyA = zeros(N,2);
Iparam = [1,100];
for jdx = [1,2]
    for idx = 1:N % for Ktot = logspace(-3,2,75)
        % Ptot unchanged
        Ktot = param(idx);
        dAdt = @(conc) -kAon * (Ptot - conc(2)) .* conc(1) + kAoff * conc(2) ...
            + kAcat * conc(4);
        dAPdt = @(conc) kAon * (Ptot - conc(2)) .* conc(1) - kAoff * conc(2) ...
            - kIcat * conc(2);
        dIdt = @(conc) -kIon * (Ktot - conc(4)) .* conc(3) + kIoff * conc(4) ...
            + kIcat * conc(2);
        dIKdt = @(conc) kIon * (Ktot - conc(4)) .* conc(3) - kIoff * conc(4) ...
            - kAcat * conc(4);

        system = @(t,conc) [dAdt(conc); dAPdt(conc); dIdt(conc); dIKdt(conc)];
        init = [0; 0; Iparam(jdx); 0];
        [T,X] = ode45(system, [0,10], init);

        steadyA(idx,jdx) = X(end,1);    % pick off steady state value for A
    end
end

figure(2)
yyaxis left
semilogx(param, steadyA(:,1))
ylabel('Steady state [A]')
yyaxis right
semilogx(param, steadyA(:,2))
xlabel('[K_{tot}] (uM)')
ylabel('Steady state [A] (uM)')
legend('I_{tot} = 1uM', 'I_{tot} = 100uM', 'Location', 'southeast')