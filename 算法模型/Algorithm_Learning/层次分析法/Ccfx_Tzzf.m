function Weight_result = Ccfx_Tzzf(A)
% Ccfx_Tzzf - Description
% 特征值法求权重
% Long description

% 第一步:求出矩阵A的最大特征值以及其对应的特征向量
%V是特征向量, D是由特征值构成的对角矩阵(除了对角线元素外,其余位置元素全为0)
[V,D] = eig(A);    
Max_eig_Value = max(D(:));

% 第二步:找到最大特征值所在的位置
% 找出D矩阵中一个与Max_eig_Value相等的元素的位置
[r,c] = find(D == Max_eig_Value, 1);

%返回权重结果
Weight_result=(V(:,c) ./ sum(V(:,c)));

end