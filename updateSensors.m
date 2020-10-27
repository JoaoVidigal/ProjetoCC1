function   sensorsStates = updateSensors(robot,mapa)
  
  %% Se o quadrado em volta for inteiro branco, o sensor tem 99% de chance de
  %retornar 1. Se o sensor está no branco, mas há um preto próximo, o sensor 
  %tem 40% de chance de retornar 1, 40% de retornar um valor aleatório entre
  %0.99 e 0.8, 19% de retornar um valor entre 0.79 e 0.6, e 1% de retornar um
  %valor entre 0.59 e 0.4. Se o sensor estiver no preto, ele tem 70% de chance
  %de retornar 0, 25% de chance de retornar [0.01,0.2], 4% de chance de
  %retornar [0.21,0.4] e 1% de retornar 0.41 a 0.6.
  [mapRow,mapCol] = size(mapa);
  for i=1:robot.numSensores
    sensorPosition(1) = round((robot.posSensores(i,1)-robot.distEixo)...
      *cos(robot.posP(3))-robot.posSensores(i,2)*sin(robot.posP(3)) + robot.posP(1));
    sensorPosition(2) = round((robot.posSensores(i,2))*cos(robot.posP(3))...
   +(robot.posSensores(i,1)-robot.distEixo)*sin(robot.posP(3)) + robot.posP(2));
   
   pixelsPos = [mapRow-sensorPosition(2);sensorPosition(1)+1];
   pixelsPos(:,2) = pixelsPos(:,1) +[1;0];
   pixelsPos(:,3) = pixelsPos(:,1) +[-1;0];
   pixelsPos(:,4) = pixelsPos(:,1) +[0;1];
   pixelsPos(:,5) = pixelsPos(:,1) +[0;-1];
   
   outOfboundsX = sum(pixelsPos(1,:)>mapCol);
   outOfboundsX = outOfboundsX + sum(pixelsPos(1,:)<1);
   outOfboundsY = sum(pixelsPos(2,:)>mapRow);
   outOfboundsY = outOfboundsY + sum(pixelsPos(2,:)<1);   
   
   if(outOfboundsX||outOfboundsY)
    error('A sensor is out of bounds!');
  else
    pixel = mapa(pixelsPos(1,1),pixelsPos(2,1));
   pixelpx1= mapa(pixelsPos(1,2),pixelsPos(2,2));
   pixelmx1= mapa(pixelsPos(1,3),pixelsPos(2,3));
   pixelpy1= mapa(pixelsPos(1,4),pixelsPos(2,4));
   pixelmy1= mapa(pixelsPos(1,5),pixelsPos(2,5));
##   if(sensorPosition(2)==0)
##    pixel = mapa(mapRow,sensorPosition(1));
##   elseif(sensorPosition(2)==49)
##    pixel = mapa(1,sensorPosition(1));
##   else
##      pixel = mapa(mapRow-sensorPosition(2),sensorPosition(1)+1); %1 no mapa é preto
##   end

##   
##    if(49-sensorPosition(2)>0 && sensorPosition(1)+1 >0)
##      pixelpx1 = mapa(49-sensorPosition(2),sensorPosition(1)+1);
##    else
##      error("pixelpx1 saiu");
##    end
##    
##    if(49-sensorPosition(2)-1>0 && sensorPosition(1)>0)
##      pixelpy1 = mapa(49-sensorPosition(2)-1,sensorPosition(1));
##    else
##      pixelpy1 = mapa(49-sensorPosition(2),sensorPosition(1));
##    end
##    
##    if(49-sensorPosition(2)>0 && sensorPosition(1)-1>0)
##       pixelmx1 = mapa(49-sensorPosition(2),sensorPosition(1)-1);
##    else
##      pixelmx1 = mapa(49-sensorPosition(2),sensorPosition(1));
##    end
##    
##    if(49-sensorPosition(2)+1>0 && sensorPosition(1)>0)
##      pixelmy1 = mapa(49-sensorPosition(2)+1,sensorPosition(1));
##    else
##      error("pixelmy1 saiu");
##    end    
##    

    
  
  if(pixel == 1)
    choice = rand(1,1);
    if(choice<=0.7)
      sensorsStates(i) = 0;
    elseif(choice>0.7 && choice <=0.95)
      sensorsStates(i) = 0.01 + 0.19*rand(1,1);
    elseif(choice>0.95&&choice<=0.99)
      sensorsStates(i) = 0.21 + 0.19*rand(1,1);
    else
      sensorsStates(i) = 0.41 + 0.19*rand(1,1);
    end
  else
    if(pixelmx1+pixelmy1+pixelpx1+pixelpy1>0)
      choice = rand(1,1);
      if(choice<=0.4)
        sensorsStates(i) = 1;
      elseif(choice>0.4 && choice <=0.8)
        sensorsStates(i) = 0.8 + 0.19*rand(1,1);
      elseif(choice>0.8&&choice<=0.99)
        sensorsStates(i) = 0.6 + 0.19*rand(1,1);
      else
        sensorsStates(i) = 0.4 + 0.19*rand(1,1);
      end
    else
      choice = rand(1,1);
      if(choice<=0.99)
        sensorsStates(i) = 1;
      else
        sensorsStates(i) = 0.9 + 0.09*rand(1,1);
      end       
    end
  end
  end
  
  %encoders
  %motor 1
  sensorsStates(robot.numSensores+1) = (2*robot.velP(1) + robot.entreEixos*...
    robot.velP(2))/(2*robot.raioRoda);
  sensorsStates(robot.numSensores+2) = (2*robot.velP(1) - robot.entreEixos*...
    robot.velP(2))/(2*robot.raioRoda);
  % 2% de chance de ler errado
  choice = rand(1,1);
  if(choice<=0.02)
    sensorsStates(robot.numSensores+1) = sensorsStates(robot.numSensores+1) -0.01 + 0.02*rand(1,1);
    sensorsStates(robot.numSensores+2) = sensorsStates(robot.numSensores+1) -0.01 + 0.02*rand(1,1);
  end
  

end