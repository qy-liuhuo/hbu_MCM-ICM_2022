function [result,result1,result2,result3, x0_fitting, relative_residuals, eta, predict_num] = LGFour(x0,num,time_point)
    % LGFour - Description
    % -----����˵��------
    % result1 ,2 ,3 �ֱ��Ǵ�ͳGM ����Ϣģ�� �³´�лģ�� ��Ԥ��ֵ
    % result ������ģ�͵ľ�ֵ
    % ���������GM_11()����һ��
    % x0 : ҪԤ���ԭʼ����
    % numΪԭʼ������
    % time_pointΪʱ��ڵ�

    % result : Ԥ��ֵ
    % x0_fitting : ��ԭʼ���ݵ����ֵ
    % relative_residuals : ��ģ�ͽ�������ʱ����õ�����Բв�
    % eta : ��ģ�ͽ�������ʱ����õ��ļ���ƫ��

    % Long description
    disp('��Ϊ����ֻ��4��,ֱ�ӽ����ַ����Ľ����ƽ������')
    predict_num = input('������Ԥ�������: ');
    disp(' ')
    disp('---�����Ǵ�ͳ��GM(1,1)ģ��Ԥ�����ϸ����---')
    [result1, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num);
    disp(' ')
    disp('---�����ǽ�������Ϣ��GM(1,1)ģ��Ԥ�����ϸ����---')
    result2 = GM_NewInfro(x0, predict_num);
    disp(' ')
    disp('---�����ǽ����³´�л��GM(1,1)ģ��Ԥ�����ϸ����---')
    result3 = GM_Metabolism(x0, predict_num);
    result = (result1+result2+result3)/3;
    %*********************************************************************

    disp('��ԭʼ���ݵ���Ͻ��:')
    for i = 1:num
        disp(strcat(num2str(time_point(i)), ' : ',num2str(x0_fitting(i))))
    end

    %*********************************************************************
   
    disp(strcat('��ͳGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result1(i))))
    end

    disp(strcat('����ϢGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result2(i))))
    end

    disp(strcat('�³´�лGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result3(i))))
    end

    %**********************************************************************

    disp(strcat('���ַ�����ƽ���õ�������Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result(i))))
    end

    
end