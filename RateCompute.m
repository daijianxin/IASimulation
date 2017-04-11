function [ rate ] = RateCompute( U, H, V, d, P, k)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
P_value = 10^(P/10)/d; % 每个码流的功率（d个码流，所以最后每个用户功率除以d）
K = U(:,:,1) * U(:,:,1)';
Q = U(:,:,1) * (H(:,:,1,1) * V(:,:,1));

M = Q * Q';

 InterferenceOther = P_value*( M(1,1) -norm(Q(1,1))^2) ;
 for  i = 2: k
      Q_1 =U(:,:,1) * H(:,:,1,i)*V(:,:,i);
      M_1 = Q_1 * Q_1';
      InterferenceOther =  InterferenceOther +P_value* M_1(1,1); 
 end
  
 InterferenceNoise = abs(K(1,1));
 SINR = P_value*norm(Q(1,1))^2/( InterferenceOther +  InterferenceNoise );
 rate = d * log2(1 + SINR);


end

