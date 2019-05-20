%% Trabalho CC1 - Seguidor de linha
%Limpa o Ambiente de Trabalho, Fecha Janelas e limpa a Janela de Comandos
clear all;
close all;
clc;

%Coleta informações do robô´ a ser construído
filename = input('Digite o nome do Arquivo, com o.txt\n','s');

%Configura os parâmetros do robô.
robot = configRobot(filename);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Espaço reservado para vocês checarem a validade da construção do robô´.
% Eu sugiro uma função que aceite a variável (struct) robot como 
% argumento, por exemplo: checkRobotValidity(robot);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Carrega o mapa a ser utilizado
%whos mapa
%  Name       Size            Bytes  Class     Attributes
%
%  mapa      48x76            29184  double    
 mapa = dlmread("map.csv",";");

hFigure = construirMapa(mapa);
%Largada em [20,44] e orientação em 0
robot.posP = [20;44;0];
%%
%definir as condições de parada
isSimulationFinished = false;
timeout = 150;

%definir as condições de simulação
deltaTime = 0.01; %10ms -> não alterar
tempo = 0;
vetorAuxiliar = zeros(6,1); %-> Não usar
%% sensorsStates
% sensorsStates é o vetor com os estados dos detectores de faixa, onde preto
% total=0 e branco total =1. O sensor de faixa devolve um número entre [0,1].
% A velocidade dos motores medidas com encoders (rad/s), sendo o motor 1,
% o direito e o motor 2 o esquerdo. 
sensorsStates = zeros(robot.numSensores+2,1);
wheelSpeeds = zeros(2,1);

tic;
while(~isSimulationFinished)
  
  %Percepção, retorna os valores dos sensores entre [0,1]; Não alterar
  sensorsStates = updateSensors(robot,mapa);
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 % Espaço reservado para ser feita a lógica de controle, os estados dos
 % sensores servirão de entrada e a saída deve ser a velocidade desejada
 % nas rodas do carrinho. A função pode ser, por exemplo: 
 % wheelSpeeds = controlAction(sensorsStates);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 wheelSpeeds = controlAction_andre(sensorsStates);
  %Cinemática - Não Alterar
  [robot.velP,vetorAuxiliar] = kinematics(robot,wheelSpeeds,vetorAuxiliar);
  
  %atualizar os estados
  robot.posP(1) = robot.posP(1) + ...
      robot.velP(1)*cos(robot.posP(3))*deltaTime;
  robot.posP(2) = robot.posP(2) + ...
      robot.velP(1)*sin(robot.posP(3))*deltaTime;
  robot.posP(3) =  robot.posP(3) + ...
      robot.velP(2)*deltaTime;
  tempo = tempo + deltaTime;
  
  %desenha carro
  hold on;
  haux = desenhaRobo(robot);
  pause(0.001);
  for i=1:size(haux,2)
    delete(haux(i));
  end
  title(gca,['Simulation Time: ', num2str(tempo), 's| Real Time: ', ...
      num2str(toc)]);
  %verificar as consições de parada
  isSimulationFinished = checkBoundaryConditions(robot,tempo,timeout);
  end