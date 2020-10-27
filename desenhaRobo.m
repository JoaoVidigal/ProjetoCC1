function handleRect = desenhaRobo(robot,sensorsStates)
%vertices(2,4) ->BL, BR. TR, TL  
 
 vertices(1,1)= -0.5*robot.comprimento-robot.distEixo;
 vertices(2,1)= -0.5*robot.largura;
 vertices(1,2)= 0.5*robot.comprimento-robot.distEixo;
 vertices(2,2)= -0.5*robot.largura;
 vertices(1,3)= 0.5*robot.comprimento-robot.distEixo;
 vertices(2,3)= 0.5*robot.largura;
 vertices(1,4)= -0.5*robot.comprimento-robot.distEixo;
 vertices(2,4)= 0.5*robot.largura;
 
 R = [cos(robot.posP(3)) -sin(robot.posP(3));sin(robot.posP(3)) cos(robot.posP(3))];
 
 for i=1:4
  rotateVertices(:,i) = R*vertices(:,i);
  vertices(1,i) = rotateVertices(1,i) + robot.posP(1);
  vertices(2,i) = rotateVertices(2,i) + robot.posP(2);
 end

 for i=1:4
   haux(i) = line([vertices(1,i) vertices(1,mod(i,4)+1)],...
          [vertices(2,i) vertices(2,mod(i,4)+1)],'LineWidth',3);
 end
  
   
  haux(5) = fill(gca,vertices(1,:),vertices(2,:),[0 0.6 1]);
  
  for i=1:robot.numSensores
    sensorCentre = R*(robot.posSensores(i,:)'-[robot.distEixo;0])+robot.posP(1:2);
    if(round(sensorsStates(i)))
        faceColor = [1 0 0];
    else
        faceColor = [0 1 0];
    end
    
    haux(5+i) = rectangle(gca,"Position",...
    [sensorCentre(1)-0.5 sensorCentre(2)-0.5 1 1],...
    "Curvature",1,"EdgeColor",'k',"FaceColor", faceColor);  
  end
  
handleRect = haux;
end