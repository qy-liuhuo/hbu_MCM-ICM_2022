function [Ressult] = Qjzzxh(x,a,b)
% Qjzzxh - Description
% ����ֵ���򻰴���
% Long description

r_x = size(x,1);  % row of x 
M = max([a-min(x),max(x)-b]);


Ressult = zeros(r_x,1);   %zeros�����÷�: zeros(3)  zeros(3,1)  ones(3)
% ��ʼ��posit_xȫΪ0  ��ʼ����Ŀ���ǽ�ʡ����ʱ��
for i = 1: r_x
    if x(i) < a
        Ressult(i) = 1-(a-x(i))/M;
    elseif x(i) > b
        Ressult(i) = 1-(x(i)-b)/M;
    else
        Ressult(i) = 1;
    end
end   

end