% Cody Falzone SID:860929046
% Sunday May 7, 2017
% CS171 PS4


function [ W1, Wf ] = trainneuralnet( X, Y, nhid, lambda )

[W1, Wf] = train(X, Y, nhid, lambda, 700000, 0.0001);

end


function [ W1, Wf ] = train(X, Y, nhid, lambda, iterations, stop_value)

max = 0;
i = 1;

[x_rows x_cols] = size(X);
gridX = getgridpts(X);
X = [ones(x_rows, 1) X];
[x_rows x_cols] = size(X);
    
W1 = randn(x_cols,nhid);
Wf = randn(nhid+1,1);

[gridX_rows gridX_cols] = size(gridX);
[~, ~, f] = forward_propagation(nhid, [ones(gridX_rows, 1) gridX] , W1, Wf);
plotdecision(X(:,2:end), Y, gridX, f);
drawnow


while 1  
    
   
    [a1, z1, f] = forward_propagation(nhid, X, W1, Wf);
    d = f - Y;
    d = d/x_rows;
    [dw, dw1, max, max1] = backward_propagation(a1, z1, Wf, d, X, lambda, i);
    
    
    if max < stop_value
        if max1 < stop_value
            disp(" [+] Converged Successfully. :^) ");
            i
            break
        end
    end
    
    W1 = W1 - dw1;
    Wf = Wf - dw; 

    i = i + 1;
    b = mod(i, 1000);
    
    if b == 0
        [gridX_rows gridX_cols] = size(gridX);
        [~, ~, f] = forward_propagation(nhid, [ones(gridX_rows, 1) gridX] , W1, Wf);
        plotdecision(X(:,2:end), Y, gridX, f);
        drawnow 
    end
    
    if i > iterations
        disp("[-] Exceeded Maximum Iterations. :^( ")
        break
    end
end

end

function [a1, z1, f] = forward_propagation(nhid, X, W1, Wf)
[x_rows x_cols] = size(X);
a1 = X * W1;

z1 = sigmoid(a1);
z1 = [ones(x_rows,1) z1];

a = z1 * Wf;
f = sigmoid(a);

gridY = f;
end

function [ dw, dw1, max, max1 ] = backward_propagation( a1, z1, Wf, d, X, lambda, iteration)

gp = sigmoid_prime(a1);
wtd = d * Wf';
wtd = wtd(:,2:end);

d1 = wtd .* gp;
eta = 0.1;
[ dw, max ]= delta_w(eta, d, z1, lambda);
[ dw1, max1 ] = delta_w(eta, d1, X, lambda);

end


function [ sig ] = sigmoid( a )
% Return the sigmoid of input a. g(a)
    sig = 1 ./ (1 + exp(-a));
end

function [ sig_prime ] = sigmoid_prime( a )
% g'(a)
    sig_prime = sigmoid(a) .* (1 - sigmoid(a));
end


function [ dw, m ] = delta_w( eta, delta, z, lambda )

    t = ( z' * delta);
    m = max(max(t));

    dw = t;
    dw = dw + (-eta * 2 * lambda * dw);
   
end





