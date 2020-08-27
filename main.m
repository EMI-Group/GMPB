%*********************************Generalized Moving Peaks Benchmark (GMPB)***********************
%Author: Danial Yazdani
%Last Edited: January 15, 2020
%
% ------------
% Reference:
% ------------
%
%  D. Yazdani et al.,
%            "Benchmarking Continuous Dynamic Optimization: Survey and Generalized Test Suite,"
%            IEEE Transactions on Cybernetics (2020).
% 
% ------------
% Description:
% ------------
% 
%  This is the source code of the Generalized Moving Peaks Benchmark (GMPB),
%  which is proposed in the aforementioned reference. This code includes
%  eight scenarios which are explained in Tables II & III of the reference.
% 
%  A simple single-swarm Particle Swarm Optimization (PSO) is used as the optimizer. 
%  In this method, to address the diversity loss issue, a predefined percentage of 
%  the best particles are kept after each environmental change, while the rest are
%  randomized across the search space. In this code, it is assumed that the algorithm 
%  is informed about the environmental changes and it does not need to detect them. 
%
% -------
% Inputs (benchmark):
% -------
% 
%    ScenarioNumber : Scenario number. Eight different scenarios have been 
%                     defined in the code whose parameter settings and 
%                     characteristics are defined in Tables II & III of refrence. 
% 
%    RunNumber      : Number of runs (recommended to run at least 31 times).
%
%
% --------
% Outputs:
% --------
%    E_bbc  : It contains the median, mean, and standard error of the average
%             of errors of the best found position before all envioronmental 
%             changes (best before change). Note that since Benchmark.Budget
%             is set to 4999 (Benchmark.ChangeFrequency -1), this is E_bbc. 
%             In case that the researcher whants to apply the Quick Recovery,
%             Benchmark.Budget can be set to smaller numbers. This number 
%             indicate the time after each environmental change where the 
%             algorithm must choose a solution for deployment/implementation. 
% 
% 
%    E_o:     It contains the median, mean, and standard error of the offline
%             error which is the average of the erros of the best solution
%             over all fitness evaluations.
%
% --------
% License:
% --------
% This program is to be used under the terms of the GNU General Public License 
% (http://www.gnu.org/copyleft/gpl.html).
% Author: Danial Yazdani
% e-mail: danial.yazdani AT gmail dot com
%         danial.yazdani AT yahoo dot com
% Copyright notice: (c) 2020 Danial Yazdani
%**************************************************************************************************
clear all;close all;clc;
global OfflineError;
RunNumber = 31;
FinalResults = NaN(3,RunNumber);
for test=1 : RunNumber
    rng(test);%This random seed setting is used to initialize the GMPB
    CtrlFlag = 0;%   This is a flag that controls the optimizer when an environmental change has happended, 
                 %   or when the solution needs to be fetched/implemented (after using the predefined FE budget 
                 %   in each environment), and when the optimization process has been finished.
    ScenarioNumber = 4;
    Benchmark = BenchmarkGenerator(ScenarioNumber);
    rng('shuffle');%Set a random seed for the optimizer
    %% Optimizer part
    Results = NaN(2,Benchmark.EnvironmentNumber);
    PSO.Dimension = Benchmark.Dimension;
    PSO.PopulationSize = 50;
    PSO.RandomizingPercentage = 0.5;
    PSO.NumberOfRandomizingParticles = ceil(PSO.PopulationSize*PSO.RandomizingPercentage);
    PSO.MaxCoordinate   = Benchmark.UB;
    PSO.MinCoordinate = Benchmark.LB;
    PSO.x = 0.729843788;
    PSO.c1 = 2.05;
    PSO.c2 = 2.05;
    [PSO.particle,~,~] = InitializingPSO(PSO.Dimension,PSO.MinCoordinate,PSO.MaxCoordinate,PSO.PopulationSize,Benchmark);
    %% main loop of the optimizer
    while 1
        [PSO,CtrlFlag,Benchmark] = PSOprocedure(PSO,Benchmark);
        if CtrlFlag==1%When an environmental change has happened
            PSO = Reaction(PSO,Benchmark);
            CtrlFlag = 0;
        elseif CtrlFlag==2%When the computational budget in the current environment has been finished
            Results(1,Benchmark.Environmentcounter) = PSO.particle.GbestValue;
            Results(2,Benchmark.Environmentcounter) = OptimumValue(Benchmark);
            CtrlFlag = 0;
            disp([ScenarioNumber,test,Benchmark.Environmentcounter]);
        end
        if  CtrlFlag==3%When termination criteria has been met
            break;
        end
    end
    FinalResults(1,test) = mean(Results(1,:));
    FinalResults(2,test) = mean(Results(2,:));
    FinalResults(3,test) = OfflineError;
end
%% Output
E_bbc(1) = median(FinalResults(2,:)-FinalResults(1,:));
E_bbc(2) = mean(FinalResults(2,:)-FinalResults(1,:));
E_bbc(3) = std(FinalResults(2,:)-FinalResults(1,:))/sqrt(RunNumber);
E_o(1) = median(FinalResults(3,:));
E_o(2) = mean(FinalResults(3,:));
E_o(3) = std(FinalResults(3,:))/sqrt(RunNumber);