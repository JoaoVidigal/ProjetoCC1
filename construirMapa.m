function h = construirMapa(mapa)
h = figure('Name','Simulation Screen','visible','off');
[mapRow,mapCol] = size(mapa);


for i=1:mapCol
  for j=1:mapRow
    if(mapa(mapRow+1-j,i)==1)
      rectangle('Position',[i-1,j-1,1,1],'Curvature',0, 'EdgeColor','k','FaceColor','k');     
##      pause(0.03);
    end
  end
end

line(gca,[25 25],[62 70],'LineWidth',10,'Color','r');
set(h,'visible','on');
xlim([0 mapCol-1]);
ylim([0 mapRow-1]);
axis('equal');
%screenSizeVec = get(0,"screensize")(3:4);

%if(screenSizeVec(1)<640 || screenSizeVec(2) <480)
%  error("Error! Screen too small!!!");
%end
%set(gcf, 'Position', get(0, 'Screensize'));
%set(gcf,"Position",[screenSizeVec(1)/2-320,screenSizeVec(2)/2-240,640,480]);
%set(gca,"position",[0 0 1 1]); 
% h= figure('Name','Simulation Screen','visible','on');
end