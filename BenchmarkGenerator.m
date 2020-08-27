%*********************************Generalized Moving Peaks Benchmark (GMPB)****************************************
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
function Benchmark = BenchmarkGenerator(ScenarioNumber)
Benchmark = [];
switch  ScenarioNumber
    case 1
        Benchmark.ComponentDimensions = [10];
        FullySeparableDimension = 0;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 2
        Benchmark.ComponentDimensions = [10];
        FullySeparableDimension = 0;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 3
        Benchmark.ComponentDimensions = [10];
        FullySeparableDimension = 0;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 4
        Benchmark.ComponentDimensions = [10];
        FullySeparableDimension = 0;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 5
        Benchmark.ComponentDimensions = [4,2,2];
        FullySeparableDimension = 2;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 6
        Benchmark.ComponentDimensions = [4,2,2];
        FullySeparableDimension = 2;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 7
        Benchmark.ComponentDimensions = [4,2,2];
        FullySeparableDimension = 2;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    case 8
        Benchmark.ComponentDimensions = [4,2,2];
        FullySeparableDimension = 2;
        Benchmark.ComponentDimensions = [Benchmark.ComponentDimensions,ones(1,FullySeparableDimension)];
        Benchmark.ChangeFrequency = 5000;
        Benchmark.Budget = 4999;
    otherwise
        warning('Invalid secnario number. You must choose between scenarios 1 to 8')
end
Benchmark.Dimension = sum(Benchmark.ComponentDimensions);
Benchmark.PermutationMap = randperm(Benchmark.Dimension);
Benchmark.UB = 50;
Benchmark.LB = -50;
Benchmark.MPBnumber = length(Benchmark.ComponentDimensions);
Benchmark.MPB = cell(1,Benchmark.MPBnumber);
for ii=1 : Benchmark.MPBnumber
    Benchmark.MPB{ii} = InitializingPeaks(Benchmark.ComponentDimensions(ii),ii,Benchmark.Dimension,ScenarioNumber);
end
Benchmark.EnvironmentNumber = 100;
Benchmark.Environmentcounter = 1;
Benchmark.MaxEvals = Benchmark.ChangeFrequency * Benchmark.EnvironmentNumber;