function [result, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num)
    % GM_11 - Description
    % 传统的GM_11模型
    % Long description
    % ----输入变量----
    % x0 : 要预测的原始数据
    % predict_num : 向后预测的期数
    % ----输出变量----
    % result : 预测值
    % x0_fitting : 对原始数据的拟合值
    % relative_residuals : 对模型进行评价时计算得到的相对残差
    % eta : 对模型进行评价时计算得到的级比偏差
    
    num = length(x0); %计算数据的长度
    x1=cumsum(x0); %计算一次累加值
    z1 = (x1(1:end-1) + x1(2:end)) / 2;  %计算紧邻均值生成数列(长度为num-1)
    %将从第二项开始的x0当成y,z1当成x,来进行一元回归 y = kx +b
    y = x0(2:end); x = z1; %此时的样本数应该是num-1,少了一项


    %********************利用最小二乘法进行数据拟合************************
    %************参考资料P6 y=kx + b
    k = ((num-1)*sum(x.*y)-sum(x)*sum(y))/((num-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((num-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k; %注意 : k = -a | -a就是发展系数, b就是灰作用量
    disp('现在进行GM(1,1)预测的原始数据是: ');disp(mat2str(x0')) % mat2str可以将矩阵或者向量转换为字符串显示
    disp(strcat('最小二乘法拟合得到的发展系数为',num2str(-a),' , 灰作用量是',num2str(b)))
    

    %****************利用参数对未来数据进行预测和数据拟合********************
    %*************参考资料P14 预测公式************
    %*********x0_fitting向量用来存储对x0序列的拟合值,这里先进行初始化********
    x0_fitting=zeros(num,1);  x0_fitting(1)=x0(1);
    for m = 1: num-1
        x0_fitting(m+1) = (1-exp(a))*(x0(1)-b/a)*exp(-a*m);
    end
    %********初始化用来保存预测值的向量*********
    result = zeros(predict_num,1);  
    for i = 1: predict_num
        result(i) = (1-exp(a))*(x0(1)-b/a)*exp(-a*(num+i-1)); %带入公式直接计算
    end


    %**********************计算绝对残差和相对残差***************************
    %*********残差检验*********
    %从第二项开始计算绝对残差,因为第一项是相同的
    absolute_residuals = x0(2:end) - x0_fitting(2:end); 
    %计算相对残差,注意分子要加绝对值,而且要使用点除   
    relative_residuals = abs(absolute_residuals) ./ x0(2:end); 
    %*********级比检验*********
    %计算级比 sigma(k) = x0(k)/x0(k-1)
    class_ratio = x0(2:end) ./ x0(1:end-1);  
    %计算级比偏差
    eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  
end