function [result] = GM_Metabolism(x0, predict_num)
    % GM_Metabolism - Description
    % ---输入变量---
    % x0 : 要预测的原始数据
    % predict_num : 向后预测的期数
    % ---输出变量---
    % result : 预测值

    %初始化用来保存预测值的向量
    result = zeros(predict_num,1); 
    for i = 1 : predict_num  
        %将预测一期的结果保存到result中
        result(i) = GM_11(x0, 1);  
        %更新x0向量,此时x0多了新的预测信息,并且删除了最开始的那个向量
        x0 = [x0(2:end); result(i)]; 
    end
    
end