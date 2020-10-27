function [velocities,aux] = kinematics(robot,wheelSpeeds,auxOld)
%auxOld = w1,w2,wd11,wd12,wd21,wd22
%Transfer function:
%         0.5934 z + 0.03869
%z^(-1) * ------------------
%             z - 0.3679


%Função do motor 1
auxOld(1) = 0.3679*auxOld(1) + 0.5934*auxOld(3) + 0.03869*auxOld(5); %10 ms
%Função do motor 2
auxOld(2) = 0.3679*auxOld(2) + 0.5934*auxOld(4) + 0.03869*auxOld(6); %10 ms

auxOld(5) = auxOld(3);
auxOld(6) = auxOld(4);
auxOld(3) = wheelSpeeds(1);
auxOld(4) = wheelSpeeds(2);

w_motor_direita = min(auxOld(1),20);
w_motor_esquerda = min(auxOld(2),20);
w_motor_direita = max(w_motor_direita,-20);
w_motor_esquerda = max(w_motor_esquerda,-20);

velocities(1) = 0.5*robot.raioRoda*(w_motor_direita+w_motor_esquerda);
velocities(2) = (robot.raioRoda/robot.entreEixos)*(w_motor_direita-w_motor_esquerda);

aux = auxOld;

end