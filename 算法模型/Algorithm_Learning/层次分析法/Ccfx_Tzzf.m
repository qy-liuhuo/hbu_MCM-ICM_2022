function Weight_result = Ccfx_Tzzf(A)
% Ccfx_Tzzf - Description
% ����ֵ����Ȩ��
% Long description

% ��һ��:�������A���������ֵ�Լ����Ӧ����������
%V����������, D��������ֵ���ɵĶԽǾ���(���˶Խ���Ԫ����,����λ��Ԫ��ȫΪ0)
[V,D] = eig(A);    
Max_eig_Value = max(D(:));

% �ڶ���:�ҵ��������ֵ���ڵ�λ��
% �ҳ�D������һ����Max_eig_Value��ȵ�Ԫ�ص�λ��
[r,c] = find(D == Max_eig_Value, 1);

%����Ȩ�ؽ��
Weight_result=(V(:,c) ./ sum(V(:,c)));

end