positionData = readmatrix([PortMap('Data') 'Track_Position_6.dat']);
xdata = positionData(:, 1)./0.0034757142857144;
ydata = positionData(:, 2)./0.0033477272727273;
zdata = positionData(:, 3);
% Data normalization
xdata = xdata - mean(xdata);
ydata = ydata - mean(ydata);
zdata = zdata - mean(zdata);
plot(xdata);
hold on
plot(ydata);
hold on 
plot(zdata);
xlabel('t')
ylabel('position')
legend('x', 'y', 'z')

% x = [20, 34, 38, 59, 66, 72, 86, 90, 98, 105, 112, 125, 149, 161];
% y = [694.628, 694.544, 694.502, 694.502, 694.481, 694.460, 694.460, 694.438, 694.460, 694.460, 694.481, 694.481, 694.481, 694.460];
% plot(x-20, y)
% xlabel('t(min)')
% ylabel('wavelength(nm)')