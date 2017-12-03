function [ Y, pdt ] = runq1()
% Returns a vector of predicted values on the testing data given in the
% file banktestX.data.
% Also returns the learned decision tree.

ftype = [0 12 4 8 3 3 3 2 0 0 0 0 0 3 0 0 0 0 0];

data = load("banktrain.data");
[data_rows data_cols] = size(data);
r = 0.65*data_rows;

train = data(1:r,:);
trainY = train(:,end);
trainX = train(:,1:end-1);

prune = data(r:end,:);
pruneY = prune(:,end);
pruneX = prune(:,1:end-1);

dt = learndt(trainX, trainY, ftype, @giniscore);
drawdt(dt);
pdt = prunedt(dt,pruneX,pruneY);
drawdt(pdt);

testX = load("banktestX.data");
Y = predictdt(pdt, testX);

end

