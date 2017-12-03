% Cody Falzone SID: 860929046
% April 17, 2017
% CS171 PS2


function [k,lnorm] = cvknn(Xtrain,Ytrain,Xvalid,Yvalid,maxk)
% 
% a starting shell
% your solution should find the best k (from 1 to maxk, skipping even values)
% and lnorm (1 = Manhattan distance, 2 = Euclidean distance) combination
% for k-nearest neighbor using the supplied training and validation sets
%
% In doing so, it should generate a plot (do *not* call "figure" -- the
% calling function will set up for the right figure window to be active).
% The plot should be as described and illustrated in the problem set. 

%disp("X Train: ");
%disp(Xtrain);
%disp("Y Train: ")
%disp(Ytrain)
%disp("X Valid: ");
%disp(Xvalid);
%disp("Y Valid: ")
%disp(Yvalid)


[vr,vc] = size(Xvalid); % The size of the validation set.
[tr,tc] = size(Xtrain); % The size of the training set.

d = zeros(tr,1); % a column vector with same rows as the training set.
                 % to store the distance from a point in the validation
                 % set to each point in the training set.
kv = [1:2:maxk];
[kr, kc] = size(kv);
correct_ed = zeros(1, kc);
correct_md = zeros(1, kc);

for i = 1:vr
    %Relipcate the current validation set point to be the same size as
    %The training set points. Take the euclidean distance between the
    %points, sum(xi - yi)^2.
    ed = sum((Xtrain - repmat(Xvalid(i,:), tr, 1)).^2, 2);
    md = sum(abs(Xtrain - repmat(Xvalid(i,:), tr, 1)), 2);
    
    [sorted, oied] = sort(ed);
    [sortmd, oimd] = sort(md);
    
    for j = 1:kc

        ikneighbors_ed = oied(1:kv(j),:);
        ed_voters = Ytrain(ikneighbors_ed);
        [M_ed,F_ed] = mode(ed_voters(:));
        
        ikneighbors_md = oimd(1:kv(j),:);
        md_voters = Ytrain(ikneighbors_md);
        [M_md,F_md] = mode(md_voters(:));

        if M_ed == Yvalid(i)
            correct_ed(j) = correct_ed(j) + 1;
        end
        
        if M_md == Yvalid(i)
            correct_md(j) = correct_md(j) + 1;
        end
        
    end
    
end


[max_ked,ied] = max(correct_ed);
[max_kmd,imd] = max(correct_md);


ae = correct_ed/vr;
ee = 1 - ae;
am = correct_md/vr;
em = 1 - am;
plot(kv,ee, 'g-o', 'LineWidth', 0.75);
hold on
plot(kv,em, 'b-o', 'LineWidth', 0.75);
xlabel('k')
ylabel('error')
legend('Euclidean', 'Manhattan', 'Location', 'southeast');
hold off

if max_ked > max_kmd
    k = kv(ied);
    lnorm = 2;
elseif max_ked < max_kmd
    k = kv(imd);
    lnorm = 1;
else
    if ied < imd
        k = kv(ied);
        lnorm = 2;
    else
        k = kv(imd);
        lnorm = 1;
    end
        
end




    







