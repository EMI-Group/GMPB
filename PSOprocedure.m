function [PSO, CtrlFlag,Benchmark] = PSOprocedure(PSO,Benchmark)
CtrlFlag=0; %#ok<NASGU>
%% Sub-swarm movement
PSO.particle.Velocity = PSO.x * (PSO.particle.Velocity + (PSO.c1 * rand(PSO.PopulationSize , PSO.Dimension).*(PSO.particle.PbestPosition - PSO.particle.X)) + (PSO.c2*rand(PSO.PopulationSize , PSO.Dimension).*(repmat(PSO.particle.GbestPosition,PSO.PopulationSize,1) - PSO.particle.X)));
PSO.particle.X = PSO.particle.X + PSO.particle.Velocity;
for jj=1 : PSO.PopulationSize
    for kk=1 : PSO.Dimension
        if PSO.particle.X(jj,kk) > PSO.MaxCoordinate
            PSO.particle.X(jj,kk) = PSO.MaxCoordinate;
            PSO.particle.Velocity(jj,kk) = 0;
        elseif PSO.particle.X(jj,kk) < PSO.MinCoordinate
            PSO.particle.X(jj,kk) = PSO.MinCoordinate;
            PSO.particle.Velocity(jj,kk) = 0;
        end
    end
end
[tmp,CtrlFlag,Benchmark] = benchmark_func(PSO.particle.X,Benchmark);
if CtrlFlag~=0
    return;
end
PSO.particle.FitnessValue = tmp;
for jj=1 : PSO.PopulationSize
    if PSO.particle.FitnessValue(jj) > PSO.particle.PbestValue(jj)
        PSO.particle.PbestValue(jj) = PSO.particle.FitnessValue(jj);
        PSO.particle.PbestPosition(jj,:) = PSO.particle.X(jj,:);
    end
end
[BestPbestValue,BestPbestID] = max(PSO.particle.PbestValue);
if BestPbestValue>PSO.particle.GbestValue
    PSO.particle.GbestValue = BestPbestValue;
    PSO.particle.GbestPosition = PSO.particle.PbestPosition(BestPbestID,:);
end
