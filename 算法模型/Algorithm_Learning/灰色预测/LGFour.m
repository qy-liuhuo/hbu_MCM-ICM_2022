function [result,result1,result2,result3, x0_fitting, relative_residuals, eta, predict_num] = LGFour(x0,num,time_point)
    % LGFour - Description
    % -----参数说明------
    % result1 ,2 ,3 分别是传统GM 新信息模型 新陈代谢模型 的预测值
    % result 是三个模型的均值
    % 其余参数与GM_11()函数一致
    % x0 : 要预测的原始数据
    % num为原始数据量
    % time_point为时间节点

    % result : 预测值
    % x0_fitting : 对原始数据的拟合值
    % relative_residuals : 对模型进行评价时计算得到的相对残差
    % eta : 对模型进行评价时计算得到的级比偏差

    % Long description
    disp('因为数据只有4期,直接将三种方法的结果求平均即可')
    predict_num = input('请输入预测的期数: ');
    disp(' ')
    disp('---下面是传统的GM(1,1)模型预测的详细过程---')
    [result1, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num);
    disp(' ')
    disp('---下面是进行新信息的GM(1,1)模型预测的详细过程---')
    result2 = GM_NewInfro(x0, predict_num);
    disp(' ')
    disp('---下面是进行新陈代谢的GM(1,1)模型预测的详细过程---')
    result3 = GM_Metabolism(x0, predict_num);
    result = (result1+result2+result3)/3;
    %*********************************************************************

    disp('对原始数据的拟合结果:')
    for i = 1:num
        disp(strcat(num2str(time_point(i)), ' : ',num2str(x0_fitting(i))))
    end

    %*********************************************************************
   
    disp(strcat('传统GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result1(i))))
    end

    disp(strcat('新信息GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result2(i))))
    end

    disp(strcat('新陈代谢GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result3(i))))
    end

    %**********************************************************************

    disp(strcat('三种方法求平均得到的往后预测',num2str(predict_num),'期的得到的结果：'))
    for i = 1 : predict_num
        disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result(i))))
    end

    
end