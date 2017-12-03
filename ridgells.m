% Cody Falzone SID:860929046
% April 7, 2017
% CS171 PS1

function [w, b] = ridgells(X,Y, lambda)

[m,n] = size(X);
ones_v = ones(m,1); % Creating Vector of all ones
X = [ones_v X]; % Add vector of all ones to first column, this is wo*b
x_xt = X' * X; % X transpose times X
identity = eye(n+1); % Creating the Identity matrix
identity(1,1) = 0; % Setting first element of first row first column to zero to not penalize it.

w_2 = inv(x_xt + (lambda * identity));
w_3 = X' * Y;
w = w_2 * w_3;

% Outputs
b = w(1,:);
w = w(2:end,:);