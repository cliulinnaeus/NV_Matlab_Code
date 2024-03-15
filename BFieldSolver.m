%% FUCK Yuanqi



%% Input
Nu1 = 2782;
Nu2 = 3001;
[B, Theta] = func_BFieldSolver(Nu1, Nu2);
disp(B)
disp(Theta)
disp((Nu1 + Nu2) / 2)


%% Function [ref: A. A. Jerkins]
function [Out_B, Out_Theta] = func_BFieldSolver(In_Nu1, In_Nu2)
Nu = sort([In_Nu1, In_Nu2]);
Nu1 = Nu(1);
Nu2 = Nu(2);

D = 2871; % MHz
gamma = 2.8; % MHz/Gauss

B_z = 1 / (sqrt(3 * D) * 3 * gamma) ...
    * sqrt(- (D + Nu1 + Nu2) * (D + Nu1 - 2 * Nu2) * (D - 2 * Nu1 + Nu2));
B_perp = 1 / (sqrt(3 * D) * 3 * gamma) ...
    * sqrt(- (2 * D - Nu1 - Nu2) * (2 * D - Nu1 + 2 * Nu2) * (2 * D + 2 * Nu1 - Nu2));

Out_B = sqrt(B_z^2 + B_perp^2); % Gauss
Out_Theta = atan(B_perp / B_z) * 180 / pi; % deg
end