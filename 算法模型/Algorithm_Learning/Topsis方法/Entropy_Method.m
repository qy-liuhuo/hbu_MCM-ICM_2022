function [W] = Entropy_Method( Z )
% Entropy_Method - Description
% 熵权法进行权值分配 

% 计算有n个样本,m个指标的样本所对应的熵权
% ----输入----
% Z 为n*m的矩阵 (要经过正向化和标准化处理,且元素中不存在负数)
% ----输出----
% W : 商权 m * 1的行向量

% Long description

%************计算熵权*************
[n,m] = size(Z);
D = zeros(1 , m);% 初始化保存信息值的行向量
    for i =1:m
        x = Z(:,i);
        p = x / sum(x);
        %注意 : p有可能为0,此时计算ln(p)*p时,Matlab会返回NaN
        %所以定义函数 selflog()
        e = -sum(p .* selflog(p)) / log(n);
        D(i) = 1 - e;
    end
%将信息值归一化,得到权重
W = D ./ sum(D);

end