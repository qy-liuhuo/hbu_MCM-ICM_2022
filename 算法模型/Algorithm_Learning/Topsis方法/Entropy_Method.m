function [W] = Entropy_Method( Z )
% Entropy_Method - Description
% ��Ȩ������Ȩֵ���� 

% ������n������,m��ָ�����������Ӧ����Ȩ
% ----����----
% Z Ϊn*m�ľ��� (Ҫ�������򻯺ͱ�׼������,��Ԫ���в����ڸ���)
% ----���----
% W : ��Ȩ m * 1��������

% Long description

%************������Ȩ*************
[n,m] = size(Z);
D = zeros(1 , m);% ��ʼ��������Ϣֵ��������
    for i =1:m
        x = Z(:,i);
        p = x / sum(x);
        %ע�� : p�п���Ϊ0,��ʱ����ln(p)*pʱ,Matlab�᷵��NaN
        %���Զ��庯�� selflog()
        e = -sum(p .* selflog(p)) / log(n);
        D(i) = 1 - e;
    end
%����Ϣֵ��һ��,�õ�Ȩ��
W = D ./ sum(D);

end