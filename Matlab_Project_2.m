
clc;close all; clear;
m = 1;
x = 0:0.001:0.18; %radius in cm, 0.1 micron intervals
t = 0:1:720; %t in seconds (5 minutes), 1-second intervals

%Properties - placed in functions
%c_A_inf = 0; concentration outside of microsphere
%c_A_initial = 2; Initial concentration of drug in microsphere, mg/cm^3
% D_AB = 3e-10; % diffusivity of drug in microsphere in cm^2/s
% h_m = 6e-5; % cm/s

sol = pdepe(m,@Microspherepde,@Microsphereic,@Microspherebc,x,t);
% Extract the first solution component as u; only one PDE solved
u = sol(:,:,1);

% A surface plot is often a good way to study a solution.
surf(x,t,u)    
title('Drug Diffusion in Microsphere: Concentration(mg/cm^3) as f (x,t)')
xlabel('radius r (cm)')
ylabel('Time t (s)')

%The concentration profile at the final time.
figure
plot(x,u(end,:))
title(['Solution at t = ', num2str(t(end)), ' s'])
xlabel('Radius r(cm) ')
ylabel('u(r,2)')

% Concentration at r = 0 at all times
figure
plot(t,u(:,1))
title('Concentration at r = 0 (center).')
xlabel('time t(s)')
ylabel('Concentration (mg/cm^3)')

% Visualize with a color map.
figure
imagesc(x,t,sol)
colorbar
xlabel('radius (cm)')
ylabel('Time (s)')
title('Drug Diffusion in Microsphere')

%% 
function [c,f,s] = Microspherepde(x,t,u,DuDx)
D_AB =0.000024; % diffusivity of drug in microsphere in cm^2/s
c = 1/D_AB;
f = DuDx;
s = 0;
end
%% 
%% 
function [pl,ql,pr,qr] = Microspherebc(xl,ul,xr,ur,t)
fluxTissue = 0.00073;
D_AB = 0.000024; % diffusivity of drug in microsphere in cm^2/s
Ca = 0;
ur = Ca;
pl = fluxTissue;
ql = D_AB;

pr = ur;
qr = 0;
end
%% 
%% 
function u0 = Microsphereic(x)
u0 = 2; % Initial drug concentration of 2 mg/cm^3
end