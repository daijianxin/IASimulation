function [ V, UU] =  DistributedIterativeFun(P, k, N, M, d, H)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   Input :     P �� �û��ܷ��书��
%               k :  �û���
%               N :  ���ն�������
%               M :  �����������
%               d :  ÿ���û�ʹ��������
%               H :  �ŵ�����
%    Output:    V :  Ԥ�������
%               UU �� �������


%% Configuration Parameters
V = PreCodeMatrixIntialized(k, M, d );  % ����Ԥ�������
IterativeCount =50; % ��������
P_value = 10^(P/10)/d; % ÿ�������Ĺ��ʣ�d���������������ÿ���û����ʳ���d��
for i = 1 : k
    for j = 1 : k
        H_1( :, :, i, j) = H( :, :, j, i)';  % �ŵ�������
    end
end
%% start iterative compute via distributed alogrithm
for count = 1:IterativeCount
    %     FAST = 1;  % ѡ�����Q����ķ�ʽ�� 1�����ۼ��㣬 0�� ѵ��������
    
    %�������е������õ�Q����, ���η����е�Qʵ���������۽��ơ����Ǽ���֪�������ŵ���Ϣ,
    %Ȼ�����Q����
    for i =1 :k
        Q(:,:,i) = zeros(N, N);
        for j = 1: k
            Q(:,:,i) =  Q(:,:,i) + (H(:,:,i,j) * V(:,:,j)) * (H(:,:,i,j) * V(:,:,j))';
        end
        Q(:,:,i) =  Q(:,:,i) - (H(:,:,i,i) * V(:,:,i)) * (H(:,:,i,i) * V(:,:,i))';
        Q(:,:,i) =   P_value * Q(:,:,i);
    end
    
    
    for i =1 : k
        [E(:,:,i), eigValue ] = eig(Q(:,:,i));
        E(:,:,i)= eigSort(eigValue, E(:,:,i)); %  ����ֵ����
        U(:,:,i) = E(:, 1: d, i);
    end
%     I = abs(trace(U(:,:,1)' * Q(:,:,1) * U(:,:,1)))
    V_1 = U;
    for i =1 :k
        Q_1(:,:,i) = zeros(M, M);
        for j = 1: k
            Q_1(:,:,i) =  Q_1(:,:,i) + (H_1(:,:,i,j) * V_1(:,:,j)) * (H_1(:,:,i,j) * V_1(:,:,j))';
        end
        Q_1(:,:,i) =  Q_1(:,:,i) - (H_1(:,:,i,i) * V_1(:,:,i)) * (H_1(:,:,i,i) * V_1(:,:,i))';
        Q_1(:,:,i) =   P_value * Q_1(:,:,i);
    end
    for i =1 : k
        [E_1(:,:,i), eigValue_1 ] = eig(Q_1(:,:,i));
        E_1(:,:,i)= eigSort(eigValue_1, E_1(:,:,i)); %  ����ֵ����
        U_1(:,:,i) = E_1(:, 1: d, i);
    end
    V = U_1;
    U = V_1;
end

for i = 1 :k
    UU(:, :,i) = pinv(U(:, :,i)' * H(:, :,i, i) * V(:, :,i)) * U(:, :,i)'; % ���յĽ������
end


% UU(:, :,1) = pinv(U(:, :,1)' * H(:, :,1, 1) * V(:, :,1)) * U(:, :,1)'; % ���յĽ������
% U_Z = UU(:, :,1) * UU(:, :,1)';   % ��������Э������󣬷�������������ʡ�
% M = UU(:, :,1) *H(:, :,1, 1)*V(:, :,1);
% %ÿ�����������ʣ���Ϊ���е��������ǵ�Ч�ģ�����ֻ����һ�Σ�
% R_codestream = log(1 + P_value*norm(M(1,1))^2/( P_value*norm(M(1,2))^2 + P_value*norm(M(1,3))^2 + U_Z(1,1) ));
% R_user = R_codestream * d ; % �û�������

% Y_1 =  H_11 * V_1 + H_12 * V_2 + H_13 * V_3;
% TEST_1 = UU_1 * Y_1;        ���Խ��վ���Ч��
% TEST_2 = norm(UU_1(1,:))^2;
% UU(:,:,1) * H(:,:,1,2) * V(:,:,2)
% U(:,:,1)' * U(:,:,1)
% V(:,:,1)' * V(:,:,1)





end























