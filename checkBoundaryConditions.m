function condition = checkBoundaryConditions(robo,tempo,timeout)

if(tempo > timeout)
  condition=true;
  return;
end

if(robo.posP(1) >63 || robo.posP(1)<1 || robo.posP(2) >47 || robo.posP(2)<1)
  condition=true;
  return;
end

if(tempo > 10 && abs(robo.posP(1) - 20)<1 && abs(robo.posP(2) - 44)<1)
  condition=true;
 return;
end

condition=false;
end