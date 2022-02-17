%****************************数据拟合(线性最小二乘拟合)*************************%
clc,clear

%导入测试数据
data = xlsread("DataTest.xlsx");
%提取相关的数据
x = data(:,1);
y = data(:,2);
%对数据进行转置
x = x';y = y';

%************进行数据拟合之前画出散点图,观察数据分布趋势************
plot(x,y,'o')
%添加标注
xlabel('x的值');ylabel('y的值')
%获取样本的数值
n = size(x,1);
%使用最小二乘法进行线性拟合 y = kx + b
k = (n*sum(x.*y)-sum(x)*sum(y))/(n*sum(x.*x)-sum(x)*sum(x));
b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/(n*sum(x.*x)-sum(x)*sum(x));
hold on 
grid on 

% 画出y=kx+b的函数图像 plot(x,y)
% 传统的画法:模拟生成x和y的序列,比如要画出[0,5]上的图形
% x = 0: 0.1 :5  % 间隔设置的越小画出来的图形越准确
% y = k * x + b  % k和b都是已知值
% plot(x,y,'-')

f=@(x) k*x+b;
fplot(f,[min(x)-1,max(x)+1]);
legend('样本数据','拟合函数','location','SouthEast')

%*************匿名函数的基本用法***************
% handle = @(arglist) anonymous_function
% 其中handle为调用匿名函数时使用的名字
% arglist为匿名函数的输入参数,可以是一个,也可以是多个,用逗号分隔
% anonymous_function为匿名函数的表达式
% fplot函数可用于画出匿名函数的图形
% fplot(f,xinterval) 将在指定区间绘图;将区间指定为 [xmin xmax] 形式的二元素向量

%**************对拟合模型的评价*****************
y_hat = k*x+b;                  % y的拟合值
SSR = sum((y_hat-mean(y)).^2);  % 回归平方和
SSE = sum((y_hat-y).^2);        % 误差平方和
SST = sum((y-mean(y)).^2);      % 总体平方和
%SST = SSE + SSR;
%计算拟合优度;注意:只适用于线性拟合
R_2 = SSR / SST;        