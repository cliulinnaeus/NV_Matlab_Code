function [ScaleT, ScaleStr] = GetScale(tmax)
if tmax >= 0 && tmax <= 100e-3
    ScaleT = 1e3;
    ScaleStr = 'ps';
elseif tmax > 100e-3 && tmax <= 100
    ScaleT = 1;
    ScaleStr = 'ns';
elseif tmax > 100 && tmax <= 100e3
    ScaleT = 1e-3;
    ScaleStr = '{\mu}s';
elseif tmax > 100e3 && tmax <= 100e6
    ScaleT = 1e-6;
    ScaleStr = 'ms';
elseif tmax > 100e6 && tmax <= 1000e9
    ScaleT = 1e-9;
    ScaleStr = 's';
end