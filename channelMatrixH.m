function [ H ] = channelMatrixH( N,M )
%UNTITLED ��������˹�ŵ�����
%   �˴���ʾ��ϸ˵��

% H_real = randn(N, M);
% H_imag = randn(N, M);

H_real =normrnd(0,(1/2)^(1/2),N,M);
H_imag =normrnd(0,(1/2)^(1/2),N,M);
H = H_real + 1i * H_imag;


end

