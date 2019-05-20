function [velocities,aux] = kinematics(robot,wheelSpeeds,auxOld)
%auxOld = w1,w2,w11,w12,w21,w22
%Transfer function:
%         0.5934 z + 0.03869
%z^(-1) * ------------------
%             z - 0.3679


auxOld(5) = auxOld(3);
auxOld(6) = auxOld(4);
auxOld(3) = wheelSpeeds(1);
auxOld(4) = wheelSpeeds(2);

%Função do motor 1
%auxOld(1) = 0.9521*auxOld(1) + 0.04877*auxOld(5); %1ms
auxOld(1) = 0.3679*auxOld(1) + 0.5934*auxOld(3) + 0.03869*auxOld(5); %10 ms
%Função do motor 2
%auxOld(2) = 0.9521*auxOld(2) + 0.04877*auxOld(6); %1ms
auxOld(2) = 0.3679*auxOld(2) + 0.5934*auxOld(4) + 0.03869*auxOld(6); %10 ms

velocities(1) = min(0.5*robot.raioRoda*(auxOld(1)+auxOld(2)),100);
velocities(2) = min((robot.raioRoda/robot.entreEixos)*(auxOld(1)-auxOld(2)),2);

aux = auxOld;

end