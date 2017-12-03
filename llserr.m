% Cody Falzone SID:860929046
% April 7, 2017
% CS171 PS1


function avg_sq_err = llserr( X, Y, w, b)
% s = llserr( X, Y, w, b )
% X - a data matrix of features.
% Y - a vector of target output.
% w - a weight vector.
% b - an offset.
%
% Using w and b, it should predict from each row in X the target,
% Compare to the actual target (in Y) and find the squared error.
% Report the average squared error over all such rows.

[m,n] = size(X); % Get the rows and columns of X.
X = [ ones(m,1) X ]; % Addings row of all ones for the offset b.
w = [ b; w ]; % Adding the offset into the weights vector.
predicted = X * w; % Predict the output.

avg_sq_err_matrix = (Y - predicted) .^2; %Calculate the squared error.
[m,n] = size(avg_sq_err_matrix); % Get the size of the matrix.
avg_sq_err = sum(avg_sq_err_matrix') / m; % Sum all elements of the error matrix, and divide by the number of elements.


end

