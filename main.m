clc
clear
close
k =3; N = 8; M =8 ; d = 4; %P =30;
for P = 0 : 40
count = 1e3;
for i = 1 : count 
[ H ] =  UserChannelMatrixH( k, N, M );
[ V, U] =  DistributedIterativeFun(P, k, N, M, d, H); % 根据算法得出预编码和解码矩阵
[ V_1, U_1] = CentralizedFun(   N, M, d, H );
 [ V_2, U_2] = HeathIteration(P, k, N, M, d, H);
% U(:,:,1) * H(:,:,1,2) *  V(:,:,2)
% U_1(:,:,1) * H(:,:,1,2) *  V_1(:,:,2)
% U(:,:,2) * H(:,:,2,2) *V(:,:,2)
% U(:,:,3) * H(:,:,3,3) *V(:,:,3)
[ rate(i) ] = RateCompute( U(:,:,1), H, V, d, P, k);
[ rate_1(i) ] = RateCompute( U_1(:,:,1), H, V_1, d, P, k);
[ rate_2(i) ] = RateCompute( U_2(:,:,1), H, V_2, d, P, k);
end
rate_d(P + 1) = sum(rate)/count ; % 分布式速度
rate_c(P + 1)= sum(rate_1)/count ;% 集中式速度
rate_h(P + 1)= sum(rate_2)/count ;% Heath集中式速度
P
end

X = 0 : 40;
plot(X, rate_d, X, rate_c,'r',X,rate_h,'b+');
xlabel('user power in dB');
ylabel('average user rate in bit');
legend('Iterative Scheme', 'Centralized Scheme','HeathIteration');