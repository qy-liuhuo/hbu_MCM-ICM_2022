function Treatment_results = Positive(x,types,i)
% Positive - Description
% 数据正向化函数,分别调用Jxzzxh() Zjzzxh() Qjzzxh()函数
% Long description
%*******极小型********
    if types == 1  
        disp(['第' num2str(i) '列是极小型，正在正向化'] )
        %函数调用
        Treatment_results=Jxzzxh(x);

        disp(['第' num2str(i) '列极小型正向化处理完成'] )
        disp('-------------------分界线-------------------')
    
%********中间型********
    elseif types == 2  
        disp(['第' num2str(i) '列是中间型'] )
        best = input('请输入最佳的那一个值： ');
        %函数调用
        Treatment_results=Zjzzxh(x,best);

        disp(['第' num2str(i) '列中间型正向化处理完成'] )
        disp('-------------------分界线-------------------')

%*********区间型*******
    elseif types == 3  
        disp(['第' num2str(i) '列是区间型'] )
        a = input('请输入区间的下界： ');
        b = input('请输入区间的上界： ');
        %函数调用
        Treatment_results=Qjzzxh(x,a,b);

        disp(['第' num2str(i) '列区间型正向化处理完成'] )
        disp('-------------------分界线-------------------')

    end

end