function PSO = Reaction(PSO,Benchmark)
[~,SortedList]=sort(PSO.particle.PbestValue);
for jj=1: PSO.NumberOfRandomizingParticles
    PSO.particle.X(SortedList(jj),:) =  PSO.MinCoordinate + (( PSO.MaxCoordinate- PSO.MinCoordinate).*rand(1,PSO.Dimension));
    PSO.particle.Velocity(SortedList(jj),:) = zeros(1,PSO.Dimension);
    PSO.particle.PbestPosition(SortedList(jj),:) = PSO.particle.X(SortedList(jj),:);
end
[PSO.particle.PbestValue,~,~] = benchmark_func(PSO.particle.PbestPosition , Benchmark);
[PSO.particle.GbestValue,BestPbestID] = max(PSO.particle.PbestValue);
PSO.particle.GbestPosition = PSO.particle.PbestPosition(BestPbestID,:);
end