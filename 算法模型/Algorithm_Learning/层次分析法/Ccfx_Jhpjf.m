function Weight_result = Ccfx_Jhpjf(A)
% Ccfx_Jhpjf - Description
% 几何平均法计算权重
% Long description

[n,m] = size(A);
% 第一步:将A的元素按照行相乘得到一个新的列向量
Prduct_A = prod(A,2);

% 第二步:将新的向量的每个分量开n次方
Prduct_n_A = Prduct_A .^ (1/n);

% 第三步:对该列向量进行归一化即可得到权重向量
% 将这个列向量中的每一个元素除以这一个向量的和即可
Weight_result = Prduct_n_A ./ sum(Prduct_n_A);


end