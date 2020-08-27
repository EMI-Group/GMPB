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
function OptVal = OptimumValue(Benchmark)
fit = NaN(1,Benchmark.MPBnumber);
for ii=1 : Benchmark.MPBnumber
    fit(ii) = max(Benchmark.MPB{ii}.PeaksHeight)*Benchmark.MPB{ii}.Weight;
end
OptVal = sum(fit);  