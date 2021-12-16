%% Wesley Schumacher
% ME ID:627-566
% MCEN Independent Study
% Fall 2021
% Modeling a Force Vectored Car

%% House-keeping Runner function
clc; close all;


%% Acceleration vs velocity modle
%How fast can we turn before we slip
R = 0.1; %[m]
V = 0:0.01:0.923; % [m/s]
Vslip = 0.923:0.01:1.2;
Ac = V.^2./R; % [m/s^2]
Acslip = Vslip.^2./R; % [m/s^2]

figure(1)
plot(V,Ac,'b','linewidth',2)
hold on
plot(Vslip,Acslip,'r','linewidth',2)
title("At what Velocity will the centripetal force be greater than friction force");
xlabel("Velocity [m/s]")
ylabel("centripetal acceleration [m/s^2]")
legend('No-slip','Slip','Location','southeast')

%% Center of Mass
%from Solid works model
X = 0.07012902;
Y = 0.12523711;
Z = 0.15635870;
figure(2)
plot3(X,Y,Z,"b*")
hold on
xlabel("x")
ylabel("y")
zlabel("z")
plot3(0.05,0.14523711,0.16,"r*")
title('Center of Mass differences between model')
legend('SolidWorks Model','Real World','Location','southeast')





%% How fast can we turn?
%Constants 

m = 0.309 ; %[kg]
com_string = 0.06; %[m]
String_len= 0.51; %[m]
Com_TVC=0.019; %[m]
Period = 0.751;  %[s]

MMOI = (m * 9.81 * Period^2 * com_string^2) / (4 * pi^2 * String_len); %0.0480
fprintf(' Mass Moment of Inertia: %f [kg m^2] \n', MMOI)
Izz = 0.00046111; % from solidworks
fprintf(' Mass Moment of Inertia From Solid Works: %f [kg m^2] \n', Izz)
MomentArm = 0.019;
I = (MMOI + Izz) / 2;

b = 0.001;   % Small Dampener;

%Transfer function Gtheta(Turning)
Gtheta=tf(1,[I b 0]);
Sine = tf(1,[1 0 1]);
figure(3)
impulse(Sine*Gtheta)

figure(4)
%Transfer Function Gx(Straight)
Gx = tf(1,[0 m b]);
impulse(Sine*Gx)







