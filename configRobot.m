function robo = configRobot(filename)

robo = struct('largura',0,'comprimento',0,'entreEixos',0,'distEixo',0,...
    'raioRoda',0,'posP',[0;0;0],'velP',[0;0],'numSensores',0,'posSensores',[]);

if(~exist(filename,"file"))
    error('Digite o nome do arquivo corretamente');
else
    fid = fopen(filename,'r');
    cell_text=textscan(fid,'%s %f','delimiter',',');
    fclose(fid);
end

nParam = size(cell_text{1},1);
numSenCord = nParam-6;
if(numSenCord > 0)
    validity = mod(numSenCord,2);
    if(validity)
        error('Erro no numero de coordenadas');
    end
end


for i=1:6
    switch cell_text{1}{i}
        case {"W" "w"}
            robo.largura = cell_text{2}(i);
        case {"L" "l"}
            robo.comprimento = cell_text{2}(i);
        case {"b" "B"}
            robo.entreEixos = cell_text{2}(i);
        case {"lcg"}
            robo.distEixo = cell_text{2}(i);
        case {"rw"}
            robo.raioRoda = cell_text{2}(i);
        case {"nSen" "nsen"}
            robo.numSensores = cell_text{2}(i);
        otherwise
            error("Parametros errados na configuracao");
    end
end

if(~(numSenCord/2 == robo.numSensores))
    error("Numero de Sensores diferente das coordenadas");
else
    for i=1:robo.numSensores
        robo.posSensores(i,1) = cell_text{2}(2*i+5);
        robo.posSensores(i,2) = cell_text{2}(2*i+6);
    end
end

end