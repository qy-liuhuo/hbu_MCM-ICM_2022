function Treatment_results = Positive(x,types,i)
% Positive - Description
% �������򻯺���,�ֱ����Jxzzxh() Zjzzxh() Qjzzxh()����
% Long description
%*******��С��********
    if types == 1  
        disp(['��' num2str(i) '���Ǽ�С�ͣ���������'] )
        %��������
        Treatment_results=Jxzzxh(x);

        disp(['��' num2str(i) '�м�С�����򻯴������'] )
        disp('-------------------�ֽ���-------------------')
    
%********�м���********
    elseif types == 2  
        disp(['��' num2str(i) '�����м���'] )
        best = input('��������ѵ���һ��ֵ�� ');
        %��������
        Treatment_results=Zjzzxh(x,best);

        disp(['��' num2str(i) '���м������򻯴������'] )
        disp('-------------------�ֽ���-------------------')

%*********������*******
    elseif types == 3  
        disp(['��' num2str(i) '����������'] )
        a = input('������������½磺 ');
        b = input('������������Ͻ磺 ');
        %��������
        Treatment_results=Qjzzxh(x,a,b);

        disp(['��' num2str(i) '�����������򻯴������'] )
        disp('-------------------�ֽ���-------------------')

    end

end