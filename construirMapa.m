function h = construirMapa(mapa)
h = figure('Name','Simulation Screen','visible','off');
xlim([1 64]);
ylim([1 48]);
for i=1:75
  for j=1:47
    if(mapa(48-j,i)==1)
      rectangle('Position',[i,j,1,1],'Curvature',0, 'EdgeColor','k','FaceColor','k');     
      pause(0.03);
    end
  end
end

line(gca,[20 20],[41 47],'LineWidth',10,'Color','r');
set(h,'visible','on');
% h= figure('Name','Simulation Screen','visible','on');
end