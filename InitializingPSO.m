function [Pso,CtrlFlag,Benchmark] = InitializingPSO(Dimension,MinCoordinate,MaxCoordinate,PopulationSize,Benchmark)
Pso.Gbest_past_environment = NaN(1,Dimension);
Pso.Velocity = zeros(PopulationSize,Dimension);
Pso.Shifts = [];
Pso.X = MinCoordinate + ((MaxCoordinate-MinCoordinate).*rand(PopulationSize,Dimension));
[Pso.FitnessValue,CtrlFlag,Benchmark] = benchmark_func(Pso.X,Benchmark);
Pso.PbestPosition = Pso.X;
Pso.PbestValue = Pso.FitnessValue;
[Pso.GbestValue,GbestID] = max(Pso.PbestValue);
Pso.GbestPosition = Pso.PbestPosition(GbestID,:);
end