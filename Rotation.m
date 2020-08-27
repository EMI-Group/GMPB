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
function output = Rotation(teta,Dimension)
counter = 0;
PageNumber = Dimension * ((Dimension-1)/2);
X = NaN(Dimension,Dimension,PageNumber);
for ii=1 : Dimension
    for jj=(ii+1) : Dimension
        if ii~=jj
            TmpMatrix = eye(Dimension);
            TmpMatrix(ii,ii) = cos(teta);
            TmpMatrix(jj,jj) = cos(teta);
            TmpMatrix(ii,jj) = sin(teta);
            TmpMatrix(jj,ii) = -sin(teta);
            counter = counter + 1;
            X(:,:,counter) = TmpMatrix;
        end
    end
end
output = eye(Dimension);
for ii=1 : PageNumber
    output = output * X(:,:,ii);
end