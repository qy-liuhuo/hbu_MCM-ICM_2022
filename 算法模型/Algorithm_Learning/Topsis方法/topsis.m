%******************************TOPSIS�㷨CODE*********************************
%*********Technique for Order Preference by Similarity to deal Solution*******
%Ŀ��:�ֲ���η������Ĳ���
%�������ԭʼ����
%��ʾ���򻯾���ͱ�׼������
%����Ȩ��
clc,clear

%*************����ִ��˵��**************
%����ѡ��1������,0�����
%��������ʱ,�Ծ������ʽ����

%���ݵĵ���,�޸�EXCEL�ļ�����.xlsx
data = xlsread("ˮ�������������.xlsx");
%********n ������� m ��������ָ��*******
[n,m] = size(data);
disp(['���ݱ��й���' num2str(n) '�����۶���,' num2str(m) '������ָ��']);


%*******�Ƿ�Ե�ǰ��ָ��������򻯴���******
Judge0=input('�Ե�ǰ��ָ���Ƿ�������򻯴���(1/0)');
%˵��:Position����Ϊ��Ҫ�����ָ�����ݶ�Ӧ����
%     Types����Ϊָ���������򻯵ķ�ʽ
%*************����ָ�����򻯺���*************
if (Judge0 == 1)
    Position=input('��������Ҫ���򻯴����ָ�����ڵ���(�������ʽ)');
    Types=input('��������Щ�е�ָ�������(1:��С��  2:�м���  3:������ ע��:������ʽ)');
    location0=size(Position,2);
    for i = 1 : 1 : location0
        %�������򻯺���,������Ӧ�е�ָ������,��ָ������,ָ����
        data(:,Position(i))=Positive(data(:,Position(i)),Types(i),Position(i));
        %���о����滻
    end
    disp('���򻯺�ľ���Ϊ:');
    disp(data);
end

%****************���򻯾����׼��************
Standardization = data ./ repmat(sum(data .* data) .^ 0.5, [n , 1]);
disp('��׼����ľ���Ϊ:')
disp(Standardization)


%******�Ƿ�Ҫ����Ȩ��ֵ,Ĭ�������1*******
%Ȩ��ֵ�ķ���������ݲ�η��������������ھ���з���
Judge1=input('�Ƿ�Ҫ��ָ�����Ȩ��ֵ����(1/0)');

if (Judge1 == 1)
    Judge2 = input('�Ƿ�ʹ����Ȩ��ȷ��Ȩ��(1/0)');
    if (Judge2 == 1)
        if (sum(sum(Standardization < 0)) > 0)
            disp('ԭ����׼����ľ����д��ڸ���,����Ҫ�������½��б�׼��')
            for i = 1:n
                for j = 1:m
                    Standardization(i,j)=[data(i,j) - min(data(:,j))] / [max(data(:,j)) - min(data(:,j))];
                end
            end
            disp('���±�׼����ľ���Ϊ : ');disp(Standardization)
        end
        weight_value = Entropy_Method(Standardization);
        disp('��Ȩ��ȷ����Ȩ�� : ');disp(weight_value) 
    else
        while (Judge1)
            weight_value=input('�������ָ���Ӧ��Ȩ��ֵ(ע��Ȩֵ�Ӻ�Ϊ1)');
            len=length(weight_value);
            if(len~=m)
                weight_value=input('Ȩ��ֵ���䲻��Ӧ,��������');
            elseif (sum(weight_value(:))~=1)
                weight_value=input('Ȩ��ֵ����Ͳ�Ϊ1,��������');
            else
                break;
            end    
        end
    end    
end
%default : weight_valueȫΪ1
if (Judge1 == 0)
    weight_value = ones(1,m);
end

%*************�������������С����**********
% Distance+ �����ֵ�ľ�������
Distance_P = sum([(Standardization - repmat(max(Standardization),n,1)) .^ 2 ] .* repmat(weight_value,n,1) ,2) .^ 0.5;  
% Distance- ����Сֵ�ľ�������
Distance_N = sum([(Standardization - repmat(min(Standardization),n,1)) .^ 2 ] .* repmat(weight_value,n,1) ,2) .^ 0.5;  
%****************�ٽ��й�һ������*************
Objective_Matrix0 = Distance_N ./ (Distance_P + Distance_N);
Objective_Matrix1 = Objective_Matrix0 / sum(Objective_Matrix0);
disp('����ָ��δ�������Ϊ:');
disp(Objective_Matrix1);
%���ս������м���
[Sorted_Standard,index] = sort(Objective_Matrix1 ,'descend');
disp('ָ��������ֵ��������Ϊ(���۶�����š���ָ������ֵ)');
disp([index,Sorted_Standard]);






