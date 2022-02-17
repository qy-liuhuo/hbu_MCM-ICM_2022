%******************************层次分析法CODE*********************************
clc,clear
% Notes:
% 输入判断矩阵——>判断一致性满足要求情况下——>算术平均法求权重;几何平均法求权重;特征值法求权重
% 分别调用函数Ccfx_Sspjf();Ccfx_Jhpjf();Ccfx_Tzzf();
% 否则退出函数执行,重新对判断矩阵A进行修改
% 注意判断矩阵A为方阵

%注意这是标准的层次分析矩阵

%设置程序执行的标记位
True=1;False=0;
String=["算数平均法结果","几何平均法结果","特征值法结果"];

A=input('请输入判断矩阵A:');
%判断一致性是否满足要求
n=size(A,1);
%V是特征向量,D是由特征值构成的对角矩阵(除了对角线元素外,其余位置元素全为0)
[V,D]=eig(A);
%求出最大特征值
Max_eig_Value=max(D(:));
CI=(Max_eig_Value - n) / (n - 1);
%注意RI最多支持 n = 15
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59]; 
CR=CI/RI(n);
%判断矩阵一致性检验结果显示
disp("判断矩阵A的最大特征值为:");disp(Max_eig_Value);
disp("一致性指标CI=");disp(CI);
disp("一致性比例CR=");disp(CR);
%以0.1作为一致性接收区间判断
if CR<0.10
    disp('因为CR < 0.10,该判断矩阵A的一致性可以接受');
    Flag=True;
else
    disp('注意:CR >= 0.10,该判断矩阵A需要进行修改');
    Flag=False;
end
%数据处理的三种方法,进行函数调用
method_num=1;
if (Flag==True)
    while(True)
        switch method_num
        case 1
            Weight_result=Ccfx_Sspjf(A);
            disp(String(method_num));disp(Weight_result);
        case 2
            Weight_result=Ccfx_Jhpjf(A);
            disp(String(method_num));disp(Weight_result);
        case 3
            Weight_result=Ccfx_Tzzf(A);
            disp(String(method_num));disp(Weight_result);
        otherwise
            break;    
        end
        method_num=method_num+1;
    end
elseif (Flag==False)
    disp("处理函数无法调用,请修改判断矩阵A"); 
end
disp("程序执行完毕!");

    