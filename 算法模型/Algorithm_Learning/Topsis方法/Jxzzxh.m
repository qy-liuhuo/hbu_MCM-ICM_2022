function [Result] = Jxzzxh(x)
% Jxzzxh - Description
% 极小值正向化处理
% Long description
Result = max(x) - x;

%根据试题的需求可以修改正向化的方式
%Result = 1 ./ x; %要求x的数值全部大于零
end