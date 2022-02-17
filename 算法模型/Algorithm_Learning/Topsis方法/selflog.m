function [lnp] = selflog(p)
% selflog - Description
% ���庯��,�������pΪ0ʱ,����ֵΪ0
% Long description
n = length(p);
lnp = zeros(n,1);
    for i =1:n
        if (p(i) == 0)
            lnp(i) = 0;
        else
            lnp(i) = log(p(i));
        end
    end
end