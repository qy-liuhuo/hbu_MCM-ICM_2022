%******************************TOPSIS算法CODE*********************************
%*********Technique for Order Preference by Similarity to deal Solution*******
%目的:弥补层次分析法的不足
%充分利用原始数据
%显示正向化矩阵和标准化矩阵
%引入权重
clc,clear

%*************程序执行说明**************
%功能选项1代表是,0代表否
%输入数据时,以矩阵的形式输入

%数据的导入,修改EXCEL文件名称.xlsx
data = xlsread("水质情况测试数据.xlsx");
%********n 代表对象 m 代表评价指标*******
[n,m] = size(data);
disp(['数据表中共有' num2str(n) '个评价对象,' num2str(m) '个评价指标']);


%*******是否对当前的指标进行正向化处理******
Judge0=input('对当前的指标是否进行正向化处理(1/0)');
%说明:Position矩阵为需要处理的指标数据对应的列
%     Types矩阵为指标数据正向化的方式
%*************调用指标正向化函数*************
if (Judge0 == 1)
    Position=input('请输入需要正向化处理的指标所在的列(矩阵的形式)');
    Types=input('请输入这些列的指标的类型(1:极小型  2:中间型  3:区间型 注意:矩阵形式)');
    location0=size(Position,2);
    for i = 1 : 1 : location0
        %调用正向化函数,传递相应列的指标数据,和指标类型,指标列
        data(:,Position(i))=Positive(data(:,Position(i)),Types(i),Position(i));
        %进行矩阵替换
    end
    disp('正向化后的矩阵为:');
    disp(data);
end

%****************正向化矩阵标准化************
Standardization = data ./ repmat(sum(data .* data) .^ 0.5, [n , 1]);
disp('标准化后的矩阵为:')
disp(Standardization)


%******是否要引入权重值,默认情况是1*******
%权重值的分配可以依据层次分析法或者数据挖掘进行分配
Judge1=input('是否要对指标进行权重值分配(1/0)');

if (Judge1 == 1)
    Judge2 = input('是否使用熵权法确定权重(1/0)');
    if (Judge2 == 1)
        if (sum(sum(Standardization < 0)) > 0)
            disp('原来标准化后的矩阵中存在负数,所以要对其重新进行标准化')
            for i = 1:n
                for j = 1:m
                    Standardization(i,j)=[data(i,j) - min(data(:,j))] / [max(data(:,j)) - min(data(:,j))];
                end
            end
            disp('重新标准化后的矩阵为 : ');disp(Standardization)
        end
        weight_value = Entropy_Method(Standardization);
        disp('熵权法确定的权重 : ');disp(weight_value) 
    else
        while (Judge1)
            weight_value=input('输入各个指标对应的权重值(注意权值加和为1)');
            len=length(weight_value);
            if(len~=m)
                weight_value=input('权重值分配不对应,重新输入');
            elseif (sum(weight_value(:))~=1)
                weight_value=input('权重值分配和不为1,重新输入');
            else
                break;
            end    
        end
    end    
end
%default : weight_value全为1
if (Judge1 == 0)
    weight_value = ones(1,m);
end

%*************计算最大距离和最小距离**********
% Distance+ 与最大值的距离向量
Distance_P = sum([(Standardization - repmat(max(Standardization),n,1)) .^ 2 ] .* repmat(weight_value,n,1) ,2) .^ 0.5;  
% Distance- 与最小值的距离向量
Distance_N = sum([(Standardization - repmat(min(Standardization),n,1)) .^ 2 ] .* repmat(weight_value,n,1) ,2) .^ 0.5;  
%****************再进行归一化处理*************
Objective_Matrix0 = Distance_N ./ (Distance_P + Distance_N);
Objective_Matrix1 = Objective_Matrix0 / sum(Objective_Matrix0);
disp('评价指数未排序矩阵为:');
disp(Objective_Matrix1);
%按照降序排列计算
[Sorted_Standard,index] = sort(Objective_Matrix1 ,'descend');
disp('指标评价数值降序排列为(评价对象序号——指标评价值)');
disp([index,Sorted_Standard]);






