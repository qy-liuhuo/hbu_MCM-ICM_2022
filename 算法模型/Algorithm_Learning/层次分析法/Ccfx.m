%******************************��η�����CODE*********************************
clc,clear
% Notes:
% �����жϾ��󡪡�>�ж�һ��������Ҫ������¡���>����ƽ������Ȩ��;����ƽ������Ȩ��;����ֵ����Ȩ��
% �ֱ���ú���Ccfx_Sspjf();Ccfx_Jhpjf();Ccfx_Tzzf();
% �����˳�����ִ��,���¶��жϾ���A�����޸�
% ע���жϾ���AΪ����

%ע�����Ǳ�׼�Ĳ�η�������

%���ó���ִ�еı��λ
True=1;False=0;
String=["����ƽ�������","����ƽ�������","����ֵ�����"];

A=input('�������жϾ���A:');
%�ж�һ�����Ƿ�����Ҫ��
n=size(A,1);
%V����������,D��������ֵ���ɵĶԽǾ���(���˶Խ���Ԫ����,����λ��Ԫ��ȫΪ0)
[V,D]=eig(A);
%����������ֵ
Max_eig_Value=max(D(:));
CI=(Max_eig_Value - n) / (n - 1);
%ע��RI���֧�� n = 15
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59]; 
CR=CI/RI(n);
%�жϾ���һ���Լ�������ʾ
disp("�жϾ���A���������ֵΪ:");disp(Max_eig_Value);
disp("һ����ָ��CI=");disp(CI);
disp("һ���Ա���CR=");disp(CR);
%��0.1��Ϊһ���Խ��������ж�
if CR<0.10
    disp('��ΪCR < 0.10,���жϾ���A��һ���Կ��Խ���');
    Flag=True;
else
    disp('ע��:CR >= 0.10,���жϾ���A��Ҫ�����޸�');
    Flag=False;
end
%���ݴ�������ַ���,���к�������
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
    disp("�������޷�����,���޸��жϾ���A"); 
end
disp("����ִ�����!");

    