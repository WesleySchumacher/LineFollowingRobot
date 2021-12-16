%% Wesley Schumacher
% ME ID:627-566
% MCEN Independent Study
% Fall 2021
% MotorSpeed Analysis

%% House-keeping Runner function
clc; close all;

%Constants 

% Read in the data that was collected using WaveForms
figure(1)
%ploting the RC circuit with 33uF capacitor 
datalimit = 20;
[MotorSpeed1] = xlsread('SM1.csv');
MotorA = MotorSpeed1(1:datalimit,1); 
MotorB = MotorSpeed1(1:datalimit,2);
time =  linspace(0,2,20);

plot(time,MotorA, 'r','linewidth',4)

hold on
plot(time,MotorB, 'b','linewidth',4)

legend('Motor A','Motor B','Location','southeast')
xlabel("time [0.1 seconds]")
ylabel("Speed value(code)")
%xlim([30 145])
%ylim([0000 6500])


figure(2)
A = [];
B = [];
fid = fopen('TestKP0.05Ki0Kd0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 13 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A = [A, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B = [B, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t = 0:0.064:(length(A)-1)*0.064;
  
  plot(t,A, 'r','linewidth',1)
  hold on
  plot(t,B, 'b','linewidth',1)
  title("Test Kp= 0.05  Kd = 0.0 Ki = 0.0")
  legend('Motor A','Motor B','Location','southeast')
  xlabel("Time [seconds]")
  ylabel("Speed value(code)")


figure(3)
A = [];
B = [];
P = [];
fid = fopen('kp0.05kd0ki0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 13 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A = [A, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B = [B, double(s(2))];
            end 
        end 
    end
  fclose(fid);
  t = 0:0.064:(length(A)-1)*0.064;
  yyaxis left
  plot(t,A, 'r','linewidth',1)
  hold on
  plot(t,B, 'b','linewidth',1)
  title("Kp= 0.05  Kd = 0.0 Ki = 0.0")
  legend('Motor A','Motor B','Location','southeast')
  xlabel("Time [seconds]")
  ylabel("Speed value(code)")
  
  figure(4)
A = [];
B = [];
P = [];
fid = fopen('kp0.025kd0ki0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A = [A, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B = [B, double(s(2))];
            end 
            if s(1) == 'Position: '; 
                fprintf(' P: %f \n', double(s(2)));
                P = [P, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t = 0:0.064:(length(A)-1)*0.064;
  yyaxis left
  plot(t,A, 'r','linewidth',1)
  hold on
  plot(t,B, 'b','linewidth',1)
  yyaxis right
  %plot(t,P, '-g','linewidth',1)
  title("Kp= 0.025  Kd = 0.0 Ki = 0.0")
  legend('Motor A','Motor B','Location','southeast')
  xlabel("Time [seconds]")
  ylabel("Speed value(code)")
  
  
  
  
figure(5)
A1 = [];
B1 = [];
P1 = [];
fid = fopen('kp0.025kd0ki0v2.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A1 = [A1, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B1 = [B1, double(s(2))];
            end 
            if s(1) == 'Position:'; 
                %fprintf(' P: %f \n', double(s(2)));
                P1 = [P1, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t1 = 0:0.064:(length(A1)-1)*0.064;
  yyaxis left
  plot(t1,A1, 'r','linewidth',1)
  hold on
  plot(t1,B1, '-b','linewidth',1)
  legend('Motor A','Motor B','Location','southeast')
  ylabel("Speed value(code)")
  xlabel("Time [seconds]")
  title("Kp= 0.025  Kd = 0.0 Ki = 0.0 V2")
  yyaxis right
  plot(t1,P1/1000, 'k','linewidth',1,'DisplayName','Position')
  ylabel("Sensor Position Value[cm]")
  

  
  figure(6)
A1 = [];
B1 = [];
P1 = [];
fid = fopen('kp0.05kd0ki0v2.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A1 = [A1, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B1 = [B1, double(s(2))];
            end 
            if s(1) == 'Position:'; 
                %fprintf(' P: %f \n', double(s(2)));
                P1 = [P1, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t1 = 0:0.064:(length(A1)-1)*0.064;
  yyaxis left
  plot(t1,A1, 'r','linewidth',1)
  hold on
  plot(t1,B1, '-b','linewidth',1)
  legend('Motor A','Motor B','Location','southeast')
  ylabel("Speed value(code)")
  xlabel("Time [seconds]")
  title("Kp= 0.05  Kd = 0.0 Ki = 0.0 V2")
  yyaxis right
  plot(t1,P1/1000, 'k','linewidth',1,'DisplayName','Position')
  ylabel("Sensor Position Value[cm]")
  
  
  
figure(7)
A1 = [];
B1 = [];
P1 = [];
fid = fopen('Kp0.07Kd0Ki0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A1 = [A1, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B1 = [B1, double(s(2))];
            end 
            if s(1) == 'Position:'; 
                %fprintf(' P: %f \n', double(s(2)));
                P1 = [P1, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t1 = 0:0.064:(length(A1)-1)*0.064;
  yyaxis left
  plot(t1,A1, 'r','linewidth',1)
  hold on
  plot(t1,B1, '-b','linewidth',1)
  legend('Motor A','Motor B','Location','southeast')
  ylabel("Speed value(code)")
  xlabel("Time [seconds]")
  title("Kp= 0.07  Kd = 0.0 Ki = 0.0")
  yyaxis right
  plot(t1,P1/1000, 'k','linewidth',1,'DisplayName','Position')
  ylabel("Sensor Position Value[cm]")
  
figure(8)
A1 = [];
B1 = [];
P1 = [];
fid = fopen('Kp0.071Kd0Ki0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A1 = [A1, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B1 = [B1, double(s(2))];
            end 
            if s(1) == 'Position:'; 
                %fprintf(' P: %f \n', double(s(2)));
                P1 = [P1, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t1 = 0:0.064:(length(A1)-1)*0.064;
  yyaxis left
  plot(t1,A1, 'r','linewidth',1)
  hold on
  plot(t1,B1, '-b','linewidth',1)
  legend('Motor A','Motor B','Location','northwest')
  ylim([-130 270])
  ylabel("Speed value(code)")
  xlabel("Time [seconds]")
  title("Kp= 0.071  Kd = 0.0 Ki = 0.0")
  yyaxis right
  plot(t1,P1/1000, 'k','linewidth',1,'DisplayName','Position')
  ylabel("Sensor Position Value[cm]")
  
  figure(9)
A1 = [];
B1 = [];
P1 = [];
fid = fopen('Kp0.07Kd0.02Ki0.txt','rt');
    while true
        thisline = fgetl(fid);
        
        if(double(thisline) == -1)
            break;
        end
        if (strlength(thisline) > 6 && strlength(thisline) < 17 )
            str = string(thisline);
            s =split(str);
            if s(1) == 'MotorA:'; 
                %fprintf(' A: %f \n', double(s(2)));
                A1 = [A1, double(s(2))];
            end  
            if s(1) == 'MotorB:'; 
                %fprintf(' B: %f \n', double(s(2)));
                B1 = [B1, double(s(2))];
            end 
            if s(1) == 'Position:'; 
                %fprintf(' P: %f \n', double(s(2)));
                P1 = [P1, double(s(2))];
            end
        end 
    end
  fclose(fid);
  t1 = 0:0.064:(length(A1)-1)*0.064;
  yyaxis left
  plot(t1,A1, 'r','linewidth',1)
  hold on
  plot(t1,B1, '-b','linewidth',1)
  legend('Motor A','Motor B','Location','northwest')
  ylim([-130 270])
  ylabel("Speed value(code)")
  xlabel("Time [seconds]")
  title("Kp= 0.07  Kd = 0.02 Ki = 0.0")
  yyaxis right
  plot(t1,P1/1000, 'k','linewidth',1,'DisplayName','Position')
  ylabel("Sensor Position Value[cm]")