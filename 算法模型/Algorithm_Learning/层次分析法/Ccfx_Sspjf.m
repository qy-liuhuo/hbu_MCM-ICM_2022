function Weight_result = Ccfx_Sspjf(A)
% Ccfx_Sspjf - Description
% ����ƽ��������Ȩ��ֵ
% Long description

% ��һ��:���жϾ������й�һ��(ÿһ��Ԫ�س����������еĺ�)
[n,m] = size(A);
% ���ÿһ�е�Ԫ�صĺ�
Sum_A = sum(A);
% ƽ�̹�����Ԫ�غ;���
SUM_A = repmat(Sum_A,[n,1]);
Stand_A=A ./ SUM_A;

%����Ȩ�ؽ��
Weight_result=(sum(Stand_A,2) / n);


end