%**********************************灰色预测模型**************************************
clc,clear

%参考资料P23程序框架编写
%使用三种模型进行比较:传统GM(1,1)模型 新信息GM(1,1)模型 新陈代谢GM(1,1)模型 
%分别调用函数---GM_11() GM_NewInfro() GM_Metabolism() 以及 LGFour()
%纵坐标的含义的注意修改

%数据导入
%注意数据保存格式
data=xlsread("测试数据.xlsx");
%提取时间节点和原始数据
time_point=data(:,1);
data_raw=data(:,2);
%*****************原始数据可视化****************
%设置图像编号
figure('Name','原始数据可视化');
plot(time_point,data_raw,'o-');grid on;
set(gca,'xtick',time_point(1:1:end))
xlabel('时间节点');ylabel('原始数据');

%*****************创建错误标志位****************
ERROR = 0;
%GM(1,1)模型适用于数据期数较短的非负时间序列

%判断是否有负数
if (sum(data_raw < 0) > 0)
    disp("灰色的时间序列中存在负数")
    ERROR = 1;
end
%判断数据量是否太少
num = length(data_raw);%num 为原始数据数量

disp(strcat('原始数据的长度为',num2str(num)))
if (num<=3)
    disp("数据量太少")
    ERROR = 1;
end
%数据量太多时,考虑使用其他模型
if num > 10
    disp('原始数据量有些大,考虑使用其他模型')
end
%判断数据是否为列向量,转换为列向量
if (size(data_raw,1) == 1)
    data_raw = data_raw';
end
if (size(time_point,1) == 1)
    time_point=time_point';
end


%******************准指数规律检验*******************
%如果之前的数据检测无问题则 ERROR = 0
x0 = data_raw;
if (ERROR == 0)
    disp('------------------------------------------------------------')
    disp('准指数规律检验')
    %使用cumsum()累加函数生成 x1序列
    %注意 : 1.0e+03 *0.1740的意思是科学计数法,即10^3*0.1740 = 174
    x1 = cumsum(x0);
    rho = x0(2:end) ./ x1(1:end-1);% 计算光滑度rho(k) = x0(k)/x1(k-1)

    %********数据可视化********
    % 画出光滑度的图形,并画上0.5的直线,表示临界值
    figure('Name','准指数规律检验');
    plot(time_point(2:end),rho,'o-',[time_point(2),time_point(end)],[0.5,0.5],'-'); grid on;
    text(time_point(end-1)+0.2,0.55,'临界线')% 在坐标(time_point(end-1)+0.2,0.55)上添加文本
    set(gca,'xtick',time_point(2:1:end))%设置x轴横坐标的间隔为1
    xlabel('时间节点');ylabel('原始数据的光滑度');%给坐标轴加上标签
    
    disp(strcat('指标1:光滑比小于0.5的数据占比为',num2str(100*sum(rho<0.5)/(num-1)),'%'))
    disp(strcat('指标2:除去前两个时期外,光滑比小于0.5的数据占比为',num2str(100*sum(rho(3:end)<0.5)/(num-3)),'%'))
    disp('参考标准:指标1一般要大于60%, 指标2要大于90%,可以通过准指数规律的检验吗？(可以通过请输入1,不能请输入0)') 
    Judge = input('请输入:');
    if Judge == 0
        disp('灰色模型不太适用,请选择其他模型')
        ERROR = 1;
    end
    disp('------------------------------------------------------------')
end

%**********************模型生成************************
%当数据量大于4时,我们利用试验组来选择使用传统的GM(1,1)模型、新信息GM(1,1)模型还是新陈代谢GM(1,1)模型 
%如果数据量等于4,那么我们直接对三种方法求一个平均来进行预测
if (ERROR == 0)
    %********************数据量大于4的情况******************
    if (num > 4)
        disp('因为原始数据期数大于4,所以我们可以将数据组分为训练组和试验组')
        % 注意,如果试验组的个数只有1个,那么三种模型的结果完全相同,因此至少要取2个试验组
        if num > 7
            test_num = 3;
        else
            test_num = 2;
        end
        train_x0 = x0(1:end-test_num);%训练数据
        %mat2str可以将矩阵或者向量转换为字符串显示
        disp('训练数据是: ');disp(mat2str(train_x0')) 
        test_x0 =  x0(end-test_num+1:end);%试验数据
        disp('试验数据是: ');disp(mat2str(test_x0')) 
        disp('------------------------------------------------------------')
        %使用三种模型对训练数据进行训练,返回的result就是往后预测test_num期的数据
        disp('---下面是传统的GM(1,1)模型预测的详细过程---')
        result1 = GM_11(train_x0 , test_num);            %使用传统的GM(1,1)模型对训练数据,并预测后test_num期的结果
        disp('---下面是进行新信息的GM(1,1)模型预测的详细过程---')
        result2 = GM_NewInfro(train_x0 , test_num);        %使用新信息GM(1,1)模型对训练数据,并预测后test_num期的结果
        disp('---下面是进行新陈代谢的GM(1,1)模型预测的详细过程---')
        result3 = GM_Metabolism(train_x0 , test_num); %使用新陈代谢GM(1,1)模型对训练数据,并预测后test_num期的结果
        
        %******************比较三种模型对测试数据的预测****************
        disp('------------------------------------------------------------')
        %绘制对试验数据进行预测的图形(对于部分数据，可能三条直线预测的结果非常接近)
        test_time_point = time_point(end-test_num+1:end); %试验组对应的年份
        %************数据可视化*************
        figure('Name','试验组数据预测效果');
        plot(test_time_point,test_x0,'o-',test_time_point,result1,'*-',test_time_point,result2,'+-',test_time_point,result3,'x-'); grid on;
        set(gca,'xtick',time_point(end-test_num+1): 1 :time_point(end))% 设置x轴横坐标的间隔为1
        %注意 : 如果lengend挡图形中的直线,那么lengend的位置可以手动拖动
        legend('试验组的真实数据','传统GM(1,1)预测结果','新信息GM(1,1)预测结果','新陈代谢GM(1,1)预测结果')  
        xlabel('时间节点');ylabel('原始数据');    
        
        %***********计算误差平方和SSE 对模型进行评价**********
        SSE1 = sum((test_x0-result1).^2);
        SSE2 = sum((test_x0-result2).^2);
        SSE3 = sum((test_x0-result3).^2);
        %**************数据可视化***************
        figure('Name','试验组数据预测的误差平方和');
        bar([SSE1,SSE2,SSE3],'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.0);grid on;
        disp(strcat('传统GM(1,1)对于试验组预测的误差平方和为',num2str(SSE1)))
        disp(strcat('新信息GM(1,1)对于试验组预测的误差平方和为',num2str(SSE2)))
        disp(strcat('新陈代谢GM(1,1)对于试验组预测的误差平方和为',num2str(SSE3)))
        disp(' ')
        %选择SSE最小的模型
        test_list_infro = [SSE1,SSE2,SSE3];
        [x_choose,y_choose] = find(test_list_infro == max(max(test_list_infro)));
        Model = ["传统GM(1,1)模型","新信息GM(1,1)模型","新陈代谢GM(1,1)模型"];
        disp(strcat(Model(y_choose),'的误差平方和最小,选择其进行预测'))
        disp('------------------------------------------------------------')
        %选择适当的模型编号
        choose = y_choose;

        %*****************正式开始选用模型进行预测*************
        predict_num = input('请输入你要往后面预测的期数: ');
        % 计算使用传统GM模型的结果,用来得到另外的返回变量:
        % x0_fitting 对原始数据的拟合值, 相对残差relative_residuals和级比偏差eta
        % 先利用GM_11函数得到对原数据拟合的详细结果
        [result, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num);  
        switch (choose)
            case 2
                result = GM_NewInfro(x0, predict_num);
            case 3
                result = GM_Metabolism(x0, predict_num);
        end
        %***************输出使用最佳的模型预测出来的结果*********
        disp('------------------------------------------------------------')
        disp('对原始数据的拟合结果:')
        for i = 1 : num
            disp(strcat(num2str(time_point(i)), ' : ',num2str(x0_fitting(i))))
        end
        disp(strcat('往后预测',num2str(predict_num),'期的得到的结果:'))
        for i = 1 : predict_num
            disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result(i))))
        end
          
    else%******************数据量小于等于4的情况*****************
        %调用函数
        [result , result1 , result2 , result3 , x0_fitting , relative_residuals , eta , predict_num] = LGFour(x0 , num , time_point)
    end

        %*************数据可视化*************
        figure('Name','预测模型相对残差--级比偏差');
        subplot(1,2,1);
        %原数据中的各时期和相对残差
        plot(time_point(2 : end) , relative_residuals,'*-'); grid on;   
        legend('相对残差'); xlabel('时间节点');
        set(gca,'xtick',time_point(2 : 1 : end))  %设置x轴横坐标的间隔为1
        
        subplot(1,2,2);
        plot(time_point(2 : end), eta,'o-'); grid on;   %原数据中的各时期和级比偏差
        legend('级比偏差'); xlabel('时间节点');
        set(gca,'xtick',time_point(2 : 1 : end))  %设置x轴横坐标的间隔为1
        
        disp('----下面将输出对原数据拟合的评价结果----')
        %******************残差检验********************
        average_relative_residuals = mean(relative_residuals);  %计算平均相对残差 mean 函数用来均值
        disp(strcat('平均相对残差为',num2str(average_relative_residuals)))

        if average_relative_residuals < 0.1
            disp('残差检验的结果表明 : 该模型对原数据的拟合程度非常不错')
        elseif average_relative_residuals < 0.2
            disp('残差检验的结果表明 : 该模型对原数据的拟合程度达到一般要求')
        else
            disp('残差检验的结果表明 : 该模型对原数据的拟合程度不太好，建议使用其他模型预测')
        end
        
        %******************级比偏差检验*****************
        average_eta = mean(eta);   % 计算平均级比偏差
        disp(strcat('平均级比偏差为',num2str(average_eta)))
        if average_eta < 0.1
            disp('级比偏差检验的结果表明 : 该模型对原数据的拟合程度非常不错')
        elseif average_eta < 0.2
            disp('级比偏差检验的结果表明 : 该模型对原数据的拟合程度达到一般要求')
        else
            disp('级比偏差检验的结果表明 : 该模型对原数据的拟合程度不太好,建议使用其他模型预测')
        end
        disp('------------------------------------------------------------')

        %*****************进行最终数据可视化************
        %绘图中的符号m : 洋红色 b : 蓝色
        figure('Name','最终数据可视化');
        plot(time_point,x0,'-o',time_point,x0_fitting,'-*m',  time_point(end) + 1 : time_point(end) + predict_num , result,'-*b' ); grid on;
        hold on;
        plot([time_point(end) , time_point(end)+1] , [x0(end) , result(1)] , '-*b')
        legend('原始数据','拟合数据','预测数据') 
        set(gca,'xtick',[time_point(1):1:time_point(end)+predict_num])% 设置x轴横坐标的间隔为1
        xlabel('时间节点');  ylabel('数据');  


end
