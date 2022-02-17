function [result, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num)
    % GM_11 - Description
    % ��ͳ��GM_11ģ��
    % Long description
    % ----�������----
    % x0 : ҪԤ���ԭʼ����
    % predict_num : ���Ԥ�������
    % ----�������----
    % result : Ԥ��ֵ
    % x0_fitting : ��ԭʼ���ݵ����ֵ
    % relative_residuals : ��ģ�ͽ�������ʱ����õ�����Բв�
    % eta : ��ģ�ͽ�������ʱ����õ��ļ���ƫ��
    
    num = length(x0); %�������ݵĳ���
    x1=cumsum(x0); %����һ���ۼ�ֵ
    z1 = (x1(1:end-1) + x1(2:end)) / 2;  %������ھ�ֵ��������(����Ϊnum-1)
    %���ӵڶ��ʼ��x0����y,z1����x,������һԪ�ع� y = kx +b
    y = x0(2:end); x = z1; %��ʱ��������Ӧ����num-1,����һ��


    %********************������С���˷������������************************
    %************�ο�����P6 y=kx + b
    k = ((num-1)*sum(x.*y)-sum(x)*sum(y))/((num-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((num-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k; %ע�� : k = -a | -a���Ƿ�չϵ��, b���ǻ�������
    disp('���ڽ���GM(1,1)Ԥ���ԭʼ������: ');disp(mat2str(x0')) % mat2str���Խ������������ת��Ϊ�ַ�����ʾ
    disp(strcat('��С���˷���ϵõ��ķ�չϵ��Ϊ',num2str(-a),' , ����������',num2str(b)))
    

    %****************���ò�����δ�����ݽ���Ԥ����������********************
    %*************�ο�����P14 Ԥ�⹫ʽ************
    %*********x0_fitting���������洢��x0���е����ֵ,�����Ƚ��г�ʼ��********
    x0_fitting=zeros(num,1);  x0_fitting(1)=x0(1);
    for m = 1: num-1
        x0_fitting(m+1) = (1-exp(a))*(x0(1)-b/a)*exp(-a*m);
    end
    %********��ʼ����������Ԥ��ֵ������*********
    result = zeros(predict_num,1);  
    for i = 1: predict_num
        result(i) = (1-exp(a))*(x0(1)-b/a)*exp(-a*(num+i-1)); %���빫ʽֱ�Ӽ���
    end


    %**********************������Բв����Բв�***************************
    %*********�в����*********
    %�ӵڶ��ʼ������Բв�,��Ϊ��һ������ͬ��
    absolute_residuals = x0(2:end) - x0_fitting(2:end); 
    %������Բв�,ע�����Ҫ�Ӿ���ֵ,����Ҫʹ�õ��   
    relative_residuals = abs(absolute_residuals) ./ x0(2:end); 
    %*********���ȼ���*********
    %���㼶�� sigma(k) = x0(k)/x0(k-1)
    class_ratio = x0(2:end) ./ x0(1:end-1);  
    %���㼶��ƫ��
    eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  
end