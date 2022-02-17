%**********************************��ɫԤ��ģ��**************************************
clc,clear

%�ο�����P23�����ܱ�д
%ʹ������ģ�ͽ��бȽ�:��ͳGM(1,1)ģ�� ����ϢGM(1,1)ģ�� �³´�лGM(1,1)ģ�� 
%�ֱ���ú���---GM_11() GM_NewInfro() GM_Metabolism() �Լ� LGFour()
%������ĺ����ע���޸�

%���ݵ���
%ע�����ݱ����ʽ
data=xlsread("��������.xlsx");
%��ȡʱ��ڵ��ԭʼ����
time_point=data(:,1);
data_raw=data(:,2);
%*****************ԭʼ���ݿ��ӻ�****************
%����ͼ����
figure('Name','ԭʼ���ݿ��ӻ�');
plot(time_point,data_raw,'o-');grid on;
set(gca,'xtick',time_point(1:1:end))
xlabel('ʱ��ڵ�');ylabel('ԭʼ����');

%*****************���������־λ****************
ERROR = 0;
%GM(1,1)ģ�����������������϶̵ķǸ�ʱ������

%�ж��Ƿ��и���
if (sum(data_raw < 0) > 0)
    disp("��ɫ��ʱ�������д��ڸ���")
    ERROR = 1;
end
%�ж��������Ƿ�̫��
num = length(data_raw);%num Ϊԭʼ��������

disp(strcat('ԭʼ���ݵĳ���Ϊ',num2str(num)))
if (num<=3)
    disp("������̫��")
    ERROR = 1;
end
%������̫��ʱ,����ʹ������ģ��
if num > 10
    disp('ԭʼ��������Щ��,����ʹ������ģ��')
end
%�ж������Ƿ�Ϊ������,ת��Ϊ������
if (size(data_raw,1) == 1)
    data_raw = data_raw';
end
if (size(time_point,1) == 1)
    time_point=time_point';
end


%******************׼ָ�����ɼ���*******************
%���֮ǰ�����ݼ���������� ERROR = 0
x0 = data_raw;
if (ERROR == 0)
    disp('------------------------------------------------------------')
    disp('׼ָ�����ɼ���')
    %ʹ��cumsum()�ۼӺ������� x1����
    %ע�� : 1.0e+03 *0.1740����˼�ǿ�ѧ������,��10^3*0.1740 = 174
    x1 = cumsum(x0);
    rho = x0(2:end) ./ x1(1:end-1);% ����⻬��rho(k) = x0(k)/x1(k-1)

    %********���ݿ��ӻ�********
    % �����⻬�ȵ�ͼ��,������0.5��ֱ��,��ʾ�ٽ�ֵ
    figure('Name','׼ָ�����ɼ���');
    plot(time_point(2:end),rho,'o-',[time_point(2),time_point(end)],[0.5,0.5],'-'); grid on;
    text(time_point(end-1)+0.2,0.55,'�ٽ���')% ������(time_point(end-1)+0.2,0.55)������ı�
    set(gca,'xtick',time_point(2:1:end))%����x�������ļ��Ϊ1
    xlabel('ʱ��ڵ�');ylabel('ԭʼ���ݵĹ⻬��');%����������ϱ�ǩ
    
    disp(strcat('ָ��1:�⻬��С��0.5������ռ��Ϊ',num2str(100*sum(rho<0.5)/(num-1)),'%'))
    disp(strcat('ָ��2:��ȥǰ����ʱ����,�⻬��С��0.5������ռ��Ϊ',num2str(100*sum(rho(3:end)<0.5)/(num-3)),'%'))
    disp('�ο���׼:ָ��1һ��Ҫ����60%, ָ��2Ҫ����90%,����ͨ��׼ָ�����ɵļ�����(����ͨ��������1,����������0)') 
    Judge = input('������:');
    if Judge == 0
        disp('��ɫģ�Ͳ�̫����,��ѡ������ģ��')
        ERROR = 1;
    end
    disp('------------------------------------------------------------')
end

%**********************ģ������************************
%������������4ʱ,����������������ѡ��ʹ�ô�ͳ��GM(1,1)ģ�͡�����ϢGM(1,1)ģ�ͻ����³´�лGM(1,1)ģ�� 
%�������������4,��ô����ֱ�Ӷ����ַ�����һ��ƽ��������Ԥ��
if (ERROR == 0)
    %********************����������4�����******************
    if (num > 4)
        disp('��Ϊԭʼ������������4,�������ǿ��Խ��������Ϊѵ�����������')
        % ע��,���������ĸ���ֻ��1��,��ô����ģ�͵Ľ����ȫ��ͬ,�������Ҫȡ2��������
        if num > 7
            test_num = 3;
        else
            test_num = 2;
        end
        train_x0 = x0(1:end-test_num);%ѵ������
        %mat2str���Խ������������ת��Ϊ�ַ�����ʾ
        disp('ѵ��������: ');disp(mat2str(train_x0')) 
        test_x0 =  x0(end-test_num+1:end);%��������
        disp('����������: ');disp(mat2str(test_x0')) 
        disp('------------------------------------------------------------')
        %ʹ������ģ�Ͷ�ѵ�����ݽ���ѵ��,���ص�result��������Ԥ��test_num�ڵ�����
        disp('---�����Ǵ�ͳ��GM(1,1)ģ��Ԥ�����ϸ����---')
        result1 = GM_11(train_x0 , test_num);            %ʹ�ô�ͳ��GM(1,1)ģ�Ͷ�ѵ������,��Ԥ���test_num�ڵĽ��
        disp('---�����ǽ�������Ϣ��GM(1,1)ģ��Ԥ�����ϸ����---')
        result2 = GM_NewInfro(train_x0 , test_num);        %ʹ������ϢGM(1,1)ģ�Ͷ�ѵ������,��Ԥ���test_num�ڵĽ��
        disp('---�����ǽ����³´�л��GM(1,1)ģ��Ԥ�����ϸ����---')
        result3 = GM_Metabolism(train_x0 , test_num); %ʹ���³´�лGM(1,1)ģ�Ͷ�ѵ������,��Ԥ���test_num�ڵĽ��
        
        %******************�Ƚ�����ģ�ͶԲ������ݵ�Ԥ��****************
        disp('------------------------------------------------------------')
        %���ƶ��������ݽ���Ԥ���ͼ��(���ڲ������ݣ���������ֱ��Ԥ��Ľ���ǳ��ӽ�)
        test_time_point = time_point(end-test_num+1:end); %�������Ӧ�����
        %************���ݿ��ӻ�*************
        figure('Name','����������Ԥ��Ч��');
        plot(test_time_point,test_x0,'o-',test_time_point,result1,'*-',test_time_point,result2,'+-',test_time_point,result3,'x-'); grid on;
        set(gca,'xtick',time_point(end-test_num+1): 1 :time_point(end))% ����x�������ļ��Ϊ1
        %ע�� : ���lengend��ͼ���е�ֱ��,��ôlengend��λ�ÿ����ֶ��϶�
        legend('���������ʵ����','��ͳGM(1,1)Ԥ����','����ϢGM(1,1)Ԥ����','�³´�лGM(1,1)Ԥ����')  
        xlabel('ʱ��ڵ�');ylabel('ԭʼ����');    
        
        %***********�������ƽ����SSE ��ģ�ͽ�������**********
        SSE1 = sum((test_x0-result1).^2);
        SSE2 = sum((test_x0-result2).^2);
        SSE3 = sum((test_x0-result3).^2);
        %**************���ݿ��ӻ�***************
        figure('Name','����������Ԥ������ƽ����');
        bar([SSE1,SSE2,SSE3],'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.0);grid on;
        disp(strcat('��ͳGM(1,1)����������Ԥ������ƽ����Ϊ',num2str(SSE1)))
        disp(strcat('����ϢGM(1,1)����������Ԥ������ƽ����Ϊ',num2str(SSE2)))
        disp(strcat('�³´�лGM(1,1)����������Ԥ������ƽ����Ϊ',num2str(SSE3)))
        disp(' ')
        %ѡ��SSE��С��ģ��
        test_list_infro = [SSE1,SSE2,SSE3];
        [x_choose,y_choose] = find(test_list_infro == max(max(test_list_infro)));
        Model = ["��ͳGM(1,1)ģ��","����ϢGM(1,1)ģ��","�³´�лGM(1,1)ģ��"];
        disp(strcat(Model(y_choose),'�����ƽ������С,ѡ�������Ԥ��'))
        disp('------------------------------------------------------------')
        %ѡ���ʵ���ģ�ͱ��
        choose = y_choose;

        %*****************��ʽ��ʼѡ��ģ�ͽ���Ԥ��*************
        predict_num = input('��������Ҫ������Ԥ�������: ');
        % ����ʹ�ô�ͳGMģ�͵Ľ��,�����õ�����ķ��ر���:
        % x0_fitting ��ԭʼ���ݵ����ֵ, ��Բв�relative_residuals�ͼ���ƫ��eta
        % ������GM_11�����õ���ԭ������ϵ���ϸ���
        [result, x0_fitting, relative_residuals, eta] = GM_11(x0, predict_num);  
        switch (choose)
            case 2
                result = GM_NewInfro(x0, predict_num);
            case 3
                result = GM_Metabolism(x0, predict_num);
        end
        %***************���ʹ����ѵ�ģ��Ԥ������Ľ��*********
        disp('------------------------------------------------------------')
        disp('��ԭʼ���ݵ���Ͻ��:')
        for i = 1 : num
            disp(strcat(num2str(time_point(i)), ' : ',num2str(x0_fitting(i))))
        end
        disp(strcat('����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ��:'))
        for i = 1 : predict_num
            disp(strcat(num2str(time_point(end)+i), ' : ',num2str(result(i))))
        end
          
    else%******************������С�ڵ���4�����*****************
        %���ú���
        [result , result1 , result2 , result3 , x0_fitting , relative_residuals , eta , predict_num] = LGFour(x0 , num , time_point)
    end

        %*************���ݿ��ӻ�*************
        figure('Name','Ԥ��ģ����Բв�--����ƫ��');
        subplot(1,2,1);
        %ԭ�����еĸ�ʱ�ں���Բв�
        plot(time_point(2 : end) , relative_residuals,'*-'); grid on;   
        legend('��Բв�'); xlabel('ʱ��ڵ�');
        set(gca,'xtick',time_point(2 : 1 : end))  %����x�������ļ��Ϊ1
        
        subplot(1,2,2);
        plot(time_point(2 : end), eta,'o-'); grid on;   %ԭ�����еĸ�ʱ�ںͼ���ƫ��
        legend('����ƫ��'); xlabel('ʱ��ڵ�');
        set(gca,'xtick',time_point(2 : 1 : end))  %����x�������ļ��Ϊ1
        
        disp('----���潫�����ԭ������ϵ����۽��----')
        %******************�в����********************
        average_relative_residuals = mean(relative_residuals);  %����ƽ����Բв� mean ����������ֵ
        disp(strcat('ƽ����Բв�Ϊ',num2str(average_relative_residuals)))

        if average_relative_residuals < 0.1
            disp('�в����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶ȷǳ�����')
        elseif average_relative_residuals < 0.2
            disp('�в����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶ȴﵽһ��Ҫ��')
        else
            disp('�в����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶Ȳ�̫�ã�����ʹ������ģ��Ԥ��')
        end
        
        %******************����ƫ�����*****************
        average_eta = mean(eta);   % ����ƽ������ƫ��
        disp(strcat('ƽ������ƫ��Ϊ',num2str(average_eta)))
        if average_eta < 0.1
            disp('����ƫ�����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶ȷǳ�����')
        elseif average_eta < 0.2
            disp('����ƫ�����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶ȴﵽһ��Ҫ��')
        else
            disp('����ƫ�����Ľ������ : ��ģ�Ͷ�ԭ���ݵ���ϳ̶Ȳ�̫��,����ʹ������ģ��Ԥ��')
        end
        disp('------------------------------------------------------------')

        %*****************�����������ݿ��ӻ�************
        %��ͼ�еķ���m : ���ɫ b : ��ɫ
        figure('Name','�������ݿ��ӻ�');
        plot(time_point,x0,'-o',time_point,x0_fitting,'-*m',  time_point(end) + 1 : time_point(end) + predict_num , result,'-*b' ); grid on;
        hold on;
        plot([time_point(end) , time_point(end)+1] , [x0(end) , result(1)] , '-*b')
        legend('ԭʼ����','�������','Ԥ������') 
        set(gca,'xtick',[time_point(1):1:time_point(end)+predict_num])% ����x�������ļ��Ϊ1
        xlabel('ʱ��ڵ�');  ylabel('����');  


end
