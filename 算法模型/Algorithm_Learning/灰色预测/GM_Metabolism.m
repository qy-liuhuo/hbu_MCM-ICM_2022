function [result] = GM_Metabolism(x0, predict_num)
    % GM_Metabolism - Description
    % ---�������---
    % x0 : ҪԤ���ԭʼ����
    % predict_num : ���Ԥ�������
    % ---�������---
    % result : Ԥ��ֵ

    %��ʼ����������Ԥ��ֵ������
    result = zeros(predict_num,1); 
    for i = 1 : predict_num  
        %��Ԥ��һ�ڵĽ�����浽result��
        result(i) = GM_11(x0, 1);  
        %����x0����,��ʱx0�����µ�Ԥ����Ϣ,����ɾ�����ʼ���Ǹ�����
        x0 = [x0(2:end); result(i)]; 
    end
    
end