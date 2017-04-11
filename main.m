clc
clear
close
k =3; N = 8; M =8 ; d = 4; %P =30;
for P = 0 : 40
count = 5e2;
for i = 1 : count 
[ H ] =  UserChannelMatrixH( k, N, M );
[ V, U] =  DistributedIterativeFun(P, k, N, M, d, H); % �����㷨�ó�Ԥ����ͽ������
[ V_1, U_1] = CentralizedFun(   N, M, d, H );
% U(:,:,1) * H(:,:,1,2) *  V(:,:,2)
% U_1(:,:,1) * H(:,:,1,2) *  V_1(:,:,2)
% U(:,:,2) * H(:,:,2,2) *V(:,:,2)
% U(:,:,3) * H(:,:,3,3) *V(:,:,3)
[ rate(i) ] = RateCompute( U(:,:,1), H, V, d, P, k);
[ rate_1(i) ] = RateCompute( U_1(:,:,1), H, V_1, d, P, k);
end
rate_d(P + 1) = sum(rate)/count ; % �ֲ�ʽ�ٶ�
rate_c(P + 1)= sum(rate_1)/count ;% ����ʽ�ٶ�
P
end

X = 0 : 40;
plot(X, rate_d, X, rate_c,'r');
xlabel('user power in dB');
ylabel('average user rate in bit');
legend('Iterative Scheme', 'Centralized Scheme');