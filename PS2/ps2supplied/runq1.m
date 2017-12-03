% Cody Falzone SID: 860929046
% April 17, 2017
% CS171 PS2



function runq1
%   Detailed explanation goes here

data = load('phishing.dat'); % Load the data from file.
[m n] = size(data);
data = [ones(m,1) data]; % Add offset vector column of all 1's.

%Setup Training Set with 80%
Xtrain = data(1:6400,:);
Ytrain = Xtrain(:,end);
Xtrain = Xtrain(:,1:end-1);
[xtrain_rows xtrain_cols] = size(Xtrain);

%Setup Validation Set with 20%
Xvalid = data(6401:8000,:);
Yvalid = Xvalid(:,end);
Xvalid = Xvalid(:,1:end-1);

[m n] = size(Xtrain);

%Augmentations
%Linear Model
%Quadratic Model
Qtrain = Xtrain;
Qvalid = Xvalid;

% Augment the feature space.
% For all features, multiply by all features to get new features.
% Creating a quadratic model.
for i = 2:n
    for j = i:n
        new_feature = Xtrain(:,i) .* Xtrain(:,j);
        Qtrain = [Qtrain new_feature];
    end
end

for i = 2:n
    for j = i:n
        nf = Xvalid(:,i) .* Xvalid(:,j);
        Qvalid = [Qvalid nf];
    end
end

% logistic regression, including regularization.
% (lambda specifies the degree of squared regularization.)
lambda = logspace(-2,3,15);
[lr, lc] = size(lambda);

best = 0.0;
g = ['n/a' -1 -1];

for l=1:lc
    
    % Use Learn Logistic Regession to get our optimal weight vector w.
    linear_w = learnlogreg(Xtrain, Ytrain, lambda(l));
    quadratic_w = learnlogreg(Qtrain, Ytrain, lambda(l));
    
    % Predict the values on the validation set using our weight vector w. 
    linear_predict = Xvalid * linear_w;
    quadratic_predict = Qvalid * quadratic_w;
    
    % Check out predictions against the y vector of the validation set.
    linear_vector = linear_predict .* Yvalid;
    quadratic_vector = quadratic_predict .* Yvalid;
    
    % Count the correct predictions.
    linear_correct = sum(linear_vector > 0);
    quadratic_correct = sum(quadratic_vector > 0);
    
    % Get the size of the vectors.
    [cr, cc] = size(linear_vector);
    [qr, qc] = size(quadratic_vector);
    
    % Get the accuracy by number correct divided by total predictions.
    linear_accuracy = linear_correct/cr;
    quadratic_accuracy = quadratic_correct/qr;
    
    disp("Linear Accuracy: ")
    disp(linear_accuracy)
    disp("Quadratic Accuracy: ")
    disp(quadratic_accuracy)
    
    if linear_accuracy > best
        best = linear_accuracy;
        g = [1 best lambda(l)];
    end
    
    if quadratic_accuracy > best
        best = quadratic_accuracy;
        g = [2 best lambda(l)];
    end
    
    disp(g);
end

    disp("Global Best: ");
    disp(g);
