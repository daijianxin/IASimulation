function [ V, UU] =  DistributedIterativeFun(P, k, N, M, d, H)
%UNTITLED2 此处显示有关此函数的摘要
%   Input :     P ： 用户总发射功率
%               k :  用户数
%               N :  接收端天线数
%               M :  发射端天线数
%               d :  每个用户使用码流数
%               H :  信道矩阵
%    Output:    V :  预编码矩阵
%               UU ： 解码矩阵


%% Configuration Parameters
V = PreCodeMatrixIntialized(k, M, d );  % 构造预编码矩阵
IterativeCount =50; % 迭代次数
P_value = 10^(P/10)/d; % 每个码流的功率（d个码流，所以最后每个用户功率除以d）
for i = 1 : k
    for j = 1 : k
        H_1( :, :, i, j) = H( :, :, j, i)';  % 信道互易性
    end
end
%% start iterative compute via distributed alogrithm
for count = 1:IterativeCount
    %     FAST = 1;  % 选择计算Q矩阵的方式， 1：理论计算， 0： 训练评估。
    
    %根据已有的条件得到Q矩阵, 本次仿真中的Q实际上是理论近似。我们假设知道所有信道信息,
    %然后求得Q矩阵。
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
        E(:,:,i)= eigSort(eigValue, E(:,:,i)); %  特征值排序
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
        E_1(:,:,i)= eigSort(eigValue_1, E_1(:,:,i)); %  特征值排序
        U_1(:,:,i) = E_1(:, 1: d, i);
    end
    V = U_1;
    U = V_1;
end

for i = 1 :k
    UU(:, :,i) = pinv(U(:, :,i)' * H(:, :,i, i) * V(:, :,i)) * U(:, :,i)'; % 最终的解码矩阵
end


% UU(:, :,1) = pinv(U(:, :,1)' * H(:, :,1, 1) * V(:, :,1)) * U(:, :,1)'; % 最终的解码矩阵
% U_Z = UU(:, :,1) * UU(:, :,1)';   % 解码矩阵的协方差矩阵，方便计算噪声功率。
% M = UU(:, :,1) *H(:, :,1, 1)*V(:, :,1);
% %每个码流的速率（因为所有的码流都是等效的，所以只计算一次）
% R_codestream = log(1 + P_value*norm(M(1,1))^2/( P_value*norm(M(1,2))^2 + P_value*norm(M(1,3))^2 + U_Z(1,1) ));
% R_user = R_codestream * d ; % 用户的速率

% Y_1 =  H_11 * V_1 + H_12 * V_2 + H_13 * V_3;
% TEST_1 = UU_1 * Y_1;        测试接收矩阵效果
% TEST_2 = norm(UU_1(1,:))^2;
% UU(:,:,1) * H(:,:,1,2) * V(:,:,2)
% U(:,:,1)' * U(:,:,1)
% V(:,:,1)' * V(:,:,1)





end























