%*******************************主成分分析********************************
clc,clear
%编程步骤参考资料P11
%导入数据
data = xlsread("测试数据.xlsx");
% n 代表数据的样本 p 代表数据的指标
[n,p] = size(data);
% first step : 对数据进行标准化
X = zscore(data);
disp(X)
% second step : 计算样本的协方差矩阵 , 计算相关系数矩阵
R = cov(X);
%******************在此处进行数据可视化*******************
figure('Name','指标之间相关性强度可视化');
bar3(R);
xlabel('指标数');ylabel('指标数');zlabel('相关性强度');

% 补充说明 : 以上的两步骤可以合并为一步 使用 corrcoef() 函数 
% R = corrcoef(data);
disp('样本的相关系数矩阵 : ')
disp(R)

% third step : 计算矩阵 R 的特征值和特征向量
% 说明 : R为半正定矩阵,所以特征值不为负数
% 由于 R 是对称矩阵,Matlab计算对对称矩阵时,会将特征值按照从小到大排列
% 使用 eig() 函数计算特征向量矩阵 和 特征值构成的对角矩阵
[V,D] = eig(R);
%****************算主成分贡献率和累计贡献率****************
lambda = diag(D);
%lambda向量是从小大到排序,对其进行反转
lambda = lambda(end:-1:1);
%计算贡献率
contribution = lambda / sum(lambda);
%计算累计贡献率
cum_contribution = cumsum(lambda) / sum(lambda);

disp('注意 : 排列顺序没有调整 ')
disp('特征值为: ');disp(lambda')  % 转置为行向量进行展示
disp('贡献率为: ');disp(contribution')
disp('累计贡献率为: ');disp(cum_contribution')
disp('与特征值对应的特征向量矩阵为：')

% 注意 : 这里的特征向量要和特征值一一对应,之前特征值相当于颠倒过来了,因此特征向量的各列需要颠倒过来
% rot90函数可以使一个矩阵逆时针旋转90度,然后再转置,就可以实现将矩阵的列颠倒
V=rot90(V)';disp(V)
%*****************计算我们所需要的主成分的值*****************
m = input('请输入需要保存的主成分的个数:  ');
disp(strcat('前',num2str(m),'个主成分的特征值系数'));disp(V(:,1:m))
%初始化保存主成分的矩阵(每一列是一个主成分)
F = zeros(n,m);  
for i = 1:m
    ai = V(:,i)';               %将第i个特征向量取出,并转置为行向量
    Ai = repmat(ai,n,1);        %将这个行向量重复n次,构成一个n*p的矩阵
    F(:, i) = sum(Ai .* X, 2);  %注意 : 对标准化的数据求了权重后要计算每一行的和
end