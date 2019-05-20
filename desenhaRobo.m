function handleRect = desenhaRobo(robot)
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
  
  haux(5) = fill(gca,vertices(1,:),vertices(2,:),'g');
%  screenSizeVec = get(0,"screensize")(3:4);

%if(screenSizeVec(1)<640 || screenSizeVec(2) <480)
%  error("Error! Screen too small!!!");
%endif

%  set(gcf,"Position",[screenSizeVec(1)/2-320,screenSizeVec(2)/2-240,640,480]);
%  set(gca,"position",[0 0 1 1]);          
%  xlim([1 64]);
%  ylim([1 48]);
handleRect = haux;
end