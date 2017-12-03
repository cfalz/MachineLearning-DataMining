% Cody Falzone SID:860929046
% April 7, 2017
% CS171 PS1


function h = plotdata(fname)
% h = plotdata(filename);
% Plots the data in the file passed in variable "filename" in a signle figure.
% Each feature (column) in the data file is plotted against the last column
% (the  y value) as a scatter plot. 
% The Handle for the figure is then returned. 

A = load(fname);    % Load the file specificed by fname into matrix A.
[m,n] = size(A);    % Get the demensions of A.
c = n-1;            % Get the features of A.
r = ceil(c/4);      % Determine the amount of rows needed, allowing 4 plots to a row.
y = A(:,n);         % Plotting against the last column of A.

% For all the features(columns), Create a subplot of type scatter against y.
for i = 1:c
    subplot(r,4,i); 
    h = scatter(A(:,i),y,7,'filled');
    str = sprintf('Feature %d', i);
    xlabel(str);
    ylabel('y');
    h.MarkerFaceColor = 'b';
    h.Marker = 'o';
end

