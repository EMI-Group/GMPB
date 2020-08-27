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
function MPB = EnvironmentalChange(MPB,MPBnumber)
for ii=1 : MPBnumber
    for jj = 1: MPB{ii}.PeakNumber
        %/* Change peak center location */
        R = randn(1,MPB{ii}.Dimension);
        Shift = MPB{ii}.ShiftSeverity  * (R/pdist2(R,zeros(size(R))));
        for kk = 1 : MPB{ii}.Dimension
            if ((MPB{ii}.PeaksPosition(jj,kk) + Shift(kk)) < MPB{ii}.MinCoordinate)
                MPB{ii}.PeaksPosition(jj,kk) = (2 * MPB{ii}.MinCoordinate) - MPB{ii}.PeaksPosition(jj,kk) - Shift(kk);
            elseif ((MPB{ii}.PeaksPosition(jj,kk) + Shift(kk)) > MPB{ii}.MaxCoordinate)
                MPB{ii}.PeaksPosition(jj,kk) = (2 * MPB{ii}.MaxCoordinate) - MPB{ii}.PeaksPosition(jj,kk)	- Shift(kk);
            else
                MPB{ii}.PeaksPosition(jj,kk) = MPB{ii}.PeaksPosition(jj,kk) + Shift(kk);
            end
        end
        %/* change width */
        if MPB{ii}.EllipticalPeaks==0
            offset = MPB{ii}.WidthSeverity * randn;
            for kk = 1 : MPB{ii}.Dimension
                if ((MPB{ii}.PeaksWidth(jj,kk) + offset) < MPB{ii}.MinWidth)
                    MPB{ii}.PeaksWidth(jj,kk) = 2 * MPB{ii}.MinWidth - MPB{ii}.PeaksWidth(jj,kk) - offset;
                elseif ((MPB{ii}.PeaksWidth(jj,kk) + offset) > MPB{ii}.MaxWidth)
                    MPB{ii}.PeaksWidth(jj,kk) = 2 * MPB{ii}.MaxWidth -MPB{ii}.PeaksWidth(jj,kk) - offset;
                else
                    MPB{ii}.PeaksWidth(jj,kk) = MPB{ii}.PeaksWidth(jj,kk) + offset;
                end
            end
        else
            offset = MPB{ii}.WidthSeverity * randn(1,MPB{ii}.Dimension);
            for kk = 1 : MPB{ii}.Dimension
                if ((MPB{ii}.PeaksWidth(jj,kk) + offset(kk)) < MPB{ii}.MinWidth)
                    MPB{ii}.PeaksWidth(jj,kk) = 2 * MPB{ii}.MinWidth - MPB{ii}.PeaksWidth(jj,kk) - offset(kk);
                elseif ((MPB{ii}.PeaksWidth(jj,kk) + offset(kk)) > MPB{ii}.MaxWidth)
                    MPB{ii}.PeaksWidth(jj,kk) = 2 * MPB{ii}.MaxWidth -MPB{ii}.PeaksWidth(jj,kk) - offset(kk);
                else
                    MPB{ii}.PeaksWidth(jj,kk) = MPB{ii}.PeaksWidth(jj,kk) + offset(kk);
                end
            end
        end
        %/* change height */
        offset = MPB{ii}.HeightSeverity * randn;
        if ((MPB{ii}.PeaksHeight(jj) + offset) < MPB{ii}.MinHeight)
            MPB{ii}.PeaksHeight(jj) = 2 * MPB{ii}.MinHeight - MPB{ii}.PeaksHeight(jj) - offset;
        elseif ((MPB{ii}.PeaksHeight(jj) + offset) > MPB{ii}.MaxHeight)
            MPB{ii}.PeaksHeight(jj) = 2 * MPB{ii}.MaxHeight - MPB{ii}.PeaksHeight(jj) - offset;
        else
            MPB{ii}.PeaksHeight(jj) = MPB{ii}.PeaksHeight(jj) + offset;
        end
        %/* change Eta */
        offset = MPB{ii}.EtaSeverity * randn(1,4);
        for kk=1 : 4
            if ((MPB{ii}.eta(jj,kk) + offset(kk)) < MPB{ii}.MinEta)
                MPB{ii}.eta(jj,kk) = 2 * MPB{ii}.MinEta - MPB{ii}.eta(jj,kk) - offset(kk);
            elseif ((MPB{ii}.eta(jj,kk) + offset(kk)) > MPB{ii}.MaxEta)
                MPB{ii}.eta(jj,kk) = 2 * MPB{ii}.MaxEta - MPB{ii}.eta(jj,kk) - offset(kk);
            else
                MPB{ii}.eta(jj,kk) = MPB{ii}.eta(jj,kk) + offset(kk);
            end
        end
        %/* change tau */
        offset = MPB{ii}.TauSeverity * randn;
        if ((MPB{ii}.tau(jj) + offset) < MPB{ii}.MinTau)
            MPB{ii}.tau(jj) = 2 * MPB{ii}.MinTau - MPB{ii}.tau(jj) - offset;
        elseif ((MPB{ii}.tau(jj) + offset) > MPB{ii}.MaxTau)
            MPB{ii}.tau(jj) = 2 * MPB{ii}.MaxTau - MPB{ii}.tau(jj) - offset;
        else
            MPB{ii}.tau(jj) = MPB{ii}.tau(jj) + offset;
        end
        %/* change angle */
        offset = MPB{ii}.AngleSeverity * randn;
        if ((MPB{ii}.PeaksAngle(jj) + offset) < MPB{ii}.MinAngle)
            MPB{ii}.PeaksAngle(jj) = 2 * MPB{ii}.MinAngle - MPB{ii}.PeaksAngle(jj) - offset;
        elseif ((MPB{ii}.PeaksAngle(jj) + offset) > MPB{ii}.MaxAngle)
            MPB{ii}.PeaksAngle(jj) = 2 * MPB{ii}.MaxAngle - MPB{ii}.PeaksAngle(jj) - offset;
        else
            MPB{ii}.PeaksAngle(jj) = MPB{ii}.PeaksAngle(jj) + offset;
        end
        %/* change rotation matrix */
        if MPB{ii}.Dimension>1
            MPB{ii}.RotationMatrix(:,:,jj) = MPB{ii}.InitialRotationMatrix(:,:,jj) * Rotation(MPB{ii}.PeaksAngle(jj),MPB{ii}.Dimension);
        end
    end
end