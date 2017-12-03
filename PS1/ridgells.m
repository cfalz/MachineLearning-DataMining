% Cody Falzone SID:860929046
% April 7, 2017
% CS171 PS1

function [w, b] = ridgells(X,Y, lambda)

w_1 = X' * X;
[n,m] = size(X);
identity = eye(n,m);
w_2 = inv(w_1 + (lamba * identity));
w_3 = X' * Y

w = w_2 * w_3;