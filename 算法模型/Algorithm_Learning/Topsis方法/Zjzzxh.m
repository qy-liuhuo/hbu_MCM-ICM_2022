function [Result] = Zjzzxh(x,best)
% Zjzzxh - Description
% 中间值正向化处理
% Long description
    M = max(abs(x-best));
    Result = 1 - abs(x-best) / M;
    
end