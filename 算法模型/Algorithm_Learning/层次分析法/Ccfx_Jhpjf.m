function Weight_result = Ccfx_Jhpjf(A)
% Ccfx_Jhpjf - Description
% ����ƽ��������Ȩ��
% Long description

[n,m] = size(A);
% ��һ��:��A��Ԫ�ذ�������˵õ�һ���µ�������
Prduct_A = prod(A,2);

% �ڶ���:���µ�������ÿ��������n�η�
Prduct_n_A = Prduct_A .^ (1/n);

% ������:�Ը����������й�һ�����ɵõ�Ȩ������
% ������������е�ÿһ��Ԫ�س�����һ�������ĺͼ���
Weight_result = Prduct_n_A ./ sum(Prduct_n_A);


end