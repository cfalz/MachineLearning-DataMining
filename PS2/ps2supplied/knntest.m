% Cody Falzone SID: 860929046
% April 17, 2017
% CS171 PS2



function [err,C] = knntest(TrainX, TrainY, TestX, TestY, k, lnorm)
%
% a stub
% your solution should report the total number of errors on the Test
% set using k-nearest neighbors with the supplied k and lnorm
% (lnorm=1 for Manhattan and 2 for Euclidean)
% It should also report C, the confusion matrix.  The i-j element of
% C is the fraction of the total examples who were labeled as class i
% and the true label was class j


[vr,vc] = size(TestX); % The size of the Testing set.
[tr,tc] = size(TrainX); % The size of the training set.

d = zeros(tr,1); % a column vector with same rows as the training set.
                 % to store the distance from a point in the validation
                 % set to each point in the training set.

correct = 0;
cr = max(TestY);
C = zeros(cr+1,cr+1);

for i = 1:vr
    %Relipcate the current validation set point to be the same size as
    %The training set points. Take the euclidean distance between the
    %points, sum(xi - yi)^2.
    if lnorm == 1
        d = sum(abs(TrainX - repmat(TestX(i,:), tr, 1)), 2);
    else
        d = sum((TrainX - repmat(TestX(i,:), tr, 1)).^2, 2); 
    end
    [sorted, id] = sort(d);
    ikneighbors = id(1:k,:);
    voters = TrainY(ikneighbors);
    [M,F] = mode(voters(:));
    predict = M+1;
    actual = TestY(i)+1;
    C(predict,actual) = C(predict,actual) + 1;
    if M == TestY(i)
        correct = correct + 1;
    end            

end

accuracy = correct/vr;
err = 1 - accuracy;
C = C/vr;




