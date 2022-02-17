function Weight_result = Ccfx_Sspjf(A)
% Ccfx_Sspjf - Description
% 算数平均法计算权重值
% Long description

% 第一步:将判断矩阵按照列归一化(每一个元素除以其所在列的和)
[n,m] = size(A);
% 求出每一列的元素的和
Sum_A = sum(A);
% 平铺构造列元素和矩阵
SUM_A = repmat(Sum_A,[n,1]);
Stand_A=A ./ SUM_A;

%返回权重结果
Weight_result=(sum(Stand_A,2) / n);


end