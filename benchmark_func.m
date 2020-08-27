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
% e-mail: danial.yazdani AT gmail.com
%         danial.yazdani AT yahoo dot com
% Copyright notice: (c) 2020 Danial Yazdani
%**************************************************************************************************
function [result,CtrlFlag,Benchmark] = benchmark_func(X,Benchmark)
%%%%%%%%%%%%global  Benchmark MPB evals ChangeFrequency
global OfflineError;
persistent evals CurrentFE FitnessHistory Optimum;
CtrlFlag = 0;
if isempty(evals)
    evals = 0;
    CurrentFE = 0;
    FitnessHistory = NaN(1,Benchmark.MaxEvals);
end
if isempty(Optimum)
    Optimum = OptimumValue(Benchmark);
end
[SolutionNumber,~] = size(X);
result = NaN(SolutionNumber,1);
for jj=1 : SolutionNumber
    x = X(jj,:)';
    fit = 0;
    ldim = 1;
    for ii=1 : Benchmark.MPBnumber
        solution = x(Benchmark.PermutationMap(ldim:ldim+Benchmark.MPB{ii}.Dimension-1));
        f=zeros(Benchmark.MPB{ii}.PeakNumber,1);
        if ~isnan(solution)
            for k=1 : Benchmark.MPB{ii}.PeakNumber
                a = Transform((solution - Benchmark.MPB{ii}.PeaksPosition(k,:)')'*Benchmark.MPB{ii}.RotationMatrix(:,:,k)',Benchmark.MPB{ii}.tau(k),Benchmark.MPB{ii}.eta(k,:));
                b = Transform(Benchmark.MPB{ii}.RotationMatrix(:,:,k) * (solution - Benchmark.MPB{ii}.PeaksPosition(k,:)'),Benchmark.MPB{ii}.tau(k),Benchmark.MPB{ii}.eta(k,:));
                f(k) = Benchmark.MPB{ii}.PeaksHeight(k) - sqrt( a * diag(Benchmark.MPB{ii}.PeaksWidth(k,:).^2) * b);
            end
            f = max(f) * Benchmark.MPB{ii}.Weight;
        end
        ldim = ldim + Benchmark.MPB{ii}.Dimension;
        fit = fit + f;
    end
    result(jj) = fit;
    evals = evals + 1;
    CurrentFE = CurrentFE + 1;
    CurrentError = Optimum - result(jj);
    if CurrentFE > 1
        if FitnessHistory(evals-1)<CurrentError
            FitnessHistory(evals) = FitnessHistory(evals-1);
        else
            FitnessHistory(evals) = CurrentError;
        end
    else
        FitnessHistory(evals) =   CurrentError;
    end
    
    if evals == Benchmark.MaxEvals
        CtrlFlag = 3;
        clear evals;
        OfflineError = mean(FitnessHistory);
        break;
    end
    if ~rem(evals,Benchmark.ChangeFrequency)
        Benchmark.MPB = EnvironmentalChange(Benchmark.MPB,Benchmark.MPBnumber);
        clear Optimum;
        CtrlFlag = 1;
        CurrentFE = 0;
        Benchmark.Environmentcounter = Benchmark.Environmentcounter +1;
        break;
    end
    if CurrentFE == Benchmark.Budget
        CtrlFlag = 2;
        break;
    end
end
end

function Y = Transform(X,tau,eta)
Y = X;
tmp = (X > 0);
Y(tmp) = log(X(tmp));
Y(tmp) = exp(Y(tmp) + tau*(sin(eta(1).*Y(tmp)) + sin(eta(2).*Y(tmp))));
tmp = (X < 0);
Y(tmp) = log(-X(tmp));
Y(tmp) = -exp(Y(tmp) + tau*(sin(eta(3).*Y(tmp)) + sin(eta(4).*Y(tmp))));
end