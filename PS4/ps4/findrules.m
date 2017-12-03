function findrules( D, smin, amin )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

I = items(D);
L = apriori(I,D,smin);
n = length(L);

for i = 1:n
    s = L{i};
    xy = getcount(s,D);
    m = length(L{i});
    for j = 1:m
        c = combnk(s,j);
        for k = 1:size(c,1)
            if size(setdiff(s,c(k,:)),2) ~= 0
                x = getcount(c(k,:),D);
                a = xy/x;
                if xy/x >= amin 
                    disp(rule2str(c(k,:),setdiff(s,c(k,:)), D))
                end
            end
        end
    end
end

end

function [L] = apriori( I, D, smin)

F = {};
m = numexamples(D);

%Generate F <-- {{i} | i e I ^ s({i} >= smin}
for i = 1:size(I,2)  
    num = getcount(I(i),D);    
    if num/m >= smin
        F = [F I(i)];
    end
end

L = F;

while length(F) > 0
    Fsize = length(F);
    C = apriorigen(F,D,smin);
    F = {};
    set_size = length(C{1});
    for i = 1:length(C)
        num = getcount(C{i},D);
        support = num/m;
        if num/m >= smin
            F = [F C{i}];
        end
    end
    L = [L F];
end

end

function [C] = apriorigen(L, D, smin)

m = numexamples(D);
n = length(L);
C = {};
for i = 1:n
    for j = i+1:n
            a = L{i};
            b = L{j};
            [X, IX] = setdiff(b(:,1:end-1),a(:,1:end-1),'sorted');
            if size(X,2) == 0
                u = union(L{i},L{j});
                num = getcount(u,D);
                C = [C u];
            end
    end
end

end


