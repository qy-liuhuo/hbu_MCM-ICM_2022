function [Result] = Zjzzxh(x,best)
% Zjzzxh - Description
% �м�ֵ���򻯴���
% Long description
    M = max(abs(x-best));
    Result = 1 - abs(x-best) / M;
    
end