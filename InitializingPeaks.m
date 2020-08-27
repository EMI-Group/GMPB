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
function MPB = InitializingPeaks(d,ii,D,ScenarioNumber)
MPB.id            = ii;
MPB.Dimension     = d;
MPB.MinCoordinate = -50;
MPB.MaxCoordinate = 50;
MPB.MinHeight     = 30;
MPB.MaxHeight     = 70;
MPB.MinWidth      = 1;
MPB.MaxWidth      = 12;
MPB.MinAngle      = -pi;
MPB.MaxAngle      =pi;
MPB.MaxTau        = 0.4;
MPB.MinTau        = 0;
MPB.MaxEta        = 25;
MPB.MinEta        = 10;
switch  ScenarioNumber
    case 1%Traditional MPB (default setting)
        MPB.Weight         = (d/D) * 1;%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 25;
        MPB.ShiftSeverity  = 2;
        MPB.HeightSeverity = 7;
        MPB.WidthSeverity  = 1;
        MPB.AngleSeverity  = 0;
        MPB.TauSeverity    = 0;
        MPB.EtaSeverity    = 0;
        MPB.EllipticalPeaks= 0;
        MPB.InitialRotationMatrix = repmat(eye(d),1,1,MPB.PeakNumber);%Using Identity matrices for rotation does not rotate peaks.
    case 2
        MPB.Weight         = (d/D) * 1;%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 25;
        MPB.ShiftSeverity  = 2;
        MPB.HeightSeverity = 7;
        MPB.WidthSeverity  = 1;
        MPB.AngleSeverity  = pi/9;
        MPB.TauSeverity    = 0;
        MPB.EtaSeverity    = 0;
        MPB.EllipticalPeaks= 1;
        MPB.InitialRotationMatrix = NaN(d,d,MPB.PeakNumber);
        for ii=1 : MPB.PeakNumber
            [MPB.InitialRotationMatrix(:,:,ii) , ~] = qr(rand(d));
        end
    case 3
        MPB.Weight         = (d/D) * 1;%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 25;
        MPB.ShiftSeverity  = 2;
        MPB.HeightSeverity = 7;
        MPB.WidthSeverity  = 1;
        MPB.AngleSeverity  = 0;
        MPB.TauSeverity    = 0.05;
        MPB.EtaSeverity    = 2;
        MPB.EllipticalPeaks= 0;
        MPB.InitialRotationMatrix = repmat(eye(d),1,1,MPB.PeakNumber);%Using Identity matrices for rotation does not rotate peaks.
    case 4
        MPB.Weight         = (d/D) * 1;%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 25;
        MPB.ShiftSeverity  = 2;
        MPB.HeightSeverity = 7;
        MPB.WidthSeverity  = 1;
        MPB.AngleSeverity  = pi/9;
        MPB.TauSeverity    = 0.05;
        MPB.EtaSeverity    = 2;
        MPB.EllipticalPeaks= 1;
        MPB.InitialRotationMatrix = NaN(d,d,MPB.PeakNumber);
        for ii=1 : MPB.PeakNumber
            [MPB.InitialRotationMatrix(:,:,ii) , ~] = qr(rand(d));
        end
    case 5
        MPB.Weight         = (d/D) * (0.5 + rand*2.5);%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 14 + ceil(rand*21);%in{5...15}
        MPB.ShiftSeverity  = 1 + rand*2;
        MPB.HeightSeverity = 5 + rand*4;
        MPB.WidthSeverity  = 0.5 + rand*1;
        MPB.AngleSeverity  = 0;
        MPB.TauSeverity    = 0;
        MPB.EtaSeverity    = 0;
        MPB.EllipticalPeaks= 0;
        MPB.InitialRotationMatrix = repmat(eye(d),1,1,MPB.PeakNumber);%Using Identity matrices for rotation does not rotate peaks.
    case 6
        MPB.Weight         = (d/D) * (0.5 + rand*2.5);%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 14 + ceil(rand*21);%in{5...15}
        MPB.ShiftSeverity  = 1 + rand*2;
        MPB.HeightSeverity = 5 + rand*4;
        MPB.WidthSeverity  = 0.5 + rand*1;
        MPB.AngleSeverity  = (pi/12) + rand*(pi/12);
        MPB.TauSeverity    = 0;
        MPB.EtaSeverity    = 0;
        MPB.EllipticalPeaks= 1;
        MPB.InitialRotationMatrix = NaN(d,d,MPB.PeakNumber);
        for ii=1 : MPB.PeakNumber
            [MPB.InitialRotationMatrix(:,:,ii) , ~] = qr(rand(d));
        end
    case 7
        MPB.Weight         = (d/D) * (0.5 + rand*2.5);%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 14 + ceil(rand*21);%in{5...15}
        MPB.ShiftSeverity  = 1 + rand*2;
        MPB.HeightSeverity = 5 + rand*4;
        MPB.WidthSeverity  = 0.5 + rand*1;
        MPB.AngleSeverity  = 0;
        MPB.TauSeverity    = 0.025 + rand*0.05;
        MPB.EtaSeverity    = 1 + rand*2;
        MPB.EllipticalPeaks = 0;
        MPB.InitialRotationMatrix = repmat(eye(d),1,1,MPB.PeakNumber);%Using Identity matrices for rotation does not rotate peaks.
    case 8
        MPB.Weight         = (d/D) * (0.5 + rand*2.5);%automatic weight (Eq.17) * manual weight (Eq.18);
        MPB.PeakNumber     = 14 + ceil(rand*21);%in{5...15}
        MPB.ShiftSeverity  = 1 + rand*2;
        MPB.HeightSeverity = 5 + rand*4;
        MPB.WidthSeverity  = 0.5 + rand*1;
        MPB.AngleSeverity  = (pi/12) + rand*(pi/12);
        MPB.TauSeverity    = 0.025 + rand*0.05;
        MPB.EtaSeverity    = 1 + rand*2;
        MPB.EllipticalPeaks = 1;
        MPB.InitialRotationMatrix = NaN(d,d,MPB.PeakNumber);
        for ii=1 : MPB.PeakNumber
            [MPB.InitialRotationMatrix(:,:,ii) , ~] = qr(rand(d));
        end
end
if MPB.EllipticalPeaks==1
    MPB.PeaksWidth = MPB.MinWidth + (MPB.MaxWidth-MPB.MinWidth)*rand(MPB.PeakNumber,d);
else
    MPB.PeaksWidth = MPB.MinWidth + (MPB.MaxWidth-MPB.MinWidth)*repmat(rand(MPB.PeakNumber,1),1,d);
end
if d>1%there is no ill-conditioning and rotation in 1-dimensional MPBs
    MPB.RotationMatrix = MPB.InitialRotationMatrix;
else
    MPB.RotationMatrix = repmat(eye(d),1,1,MPB.PeakNumber);
    MPB.AngleSeverity  = 0;
end
MPB.PeaksPosition = MPB.MinCoordinate + ((MPB.MaxCoordinate-MPB.MinCoordinate)*rand(MPB.PeakNumber,MPB.Dimension));
MPB.PeaksHeight = MPB.MinHeight + (MPB.MaxHeight-MPB.MinHeight)*rand(MPB.PeakNumber,1);
if MPB.AngleSeverity==0
    MPB.PeaksAngle = zeros(MPB.PeakNumber,1);
else
    MPB.PeaksAngle = MPB.MinAngle + (MPB.MaxAngle-MPB.MinAngle)*rand(MPB.PeakNumber,1);
end
if MPB.EtaSeverity==0 && MPB.TauSeverity==0
    MPB.tau            = zeros(MPB.PeakNumber,1);
    MPB.eta            = zeros(MPB.PeakNumber,4);
else
    MPB.tau  = MPB.MinTau + (MPB.MaxTau-MPB.MinTau)*rand(MPB.PeakNumber,1);
    MPB.eta  = MPB.MinEta + (MPB.MaxEta-MPB.MinEta)*rand(MPB.PeakNumber,4);
end
end