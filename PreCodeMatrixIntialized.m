function [ V ] = PreCodeMatrixIntialized(k, M,d )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   Input :
%               M :  �����������
%               d :  ÿ���û�ʹ��������
%    Output:    V :  ���� V'*V Ϊ��λ�����Ԥ�������
I = eye(M);
V_code = I(:,1:d);
for i =1 : k
    V(:,:,i)  = V_code;  % ����Ԥ�������
end
end

