function robo = configRobot(filename)

robo = struct('largura',0,'comprimento',0,'entreEixos',0,'distEixo',0,...
    'raioRoda',0,'posP',[0;0;0],'velP',[0;0],'numSensores',0,'posSensores',[]);

if(~exist(filename,"file"))
    error('Digite o nome do arquivo corretamente');
else
    [header,values]=textread(filename,'%s %f','delimiter',',');
end

nParam = size(header,1);
numSenCord = nParam-6;
if(numSenCord > 0)
    validity = mod(numSenCord,2);
    if(validity)
        error('Erro no numero de coordenadas');
    end
end


for i=1:6
    switch header{i}
        case {"W" "w"}
            robo.largura = values(i);
        case {"L" "l"}
            robo.comprimento = values(i);
        case {"b" "B"}
            robo.entreEixos = values(i);
        case {"lcg"}
            robo.distEixo = values(i);
        case {"rw"}
            robo.raioRoda = values(i);
        case {"nSen" "nsen"}
            robo.numSensores = values(i);
        otherwise
            error("Parametros errados na configuracao");
    end
end

if(~(numSenCord/2 == robo.numSensores))
    error("Numero de Sensores diferente das coordenadas");
else
    for i=1:robo.numSensores
        robo.posSensores(i,1) = values(2*i+5);
        robo.posSensores(i,2) = values(2*i+6);
    end
end

end