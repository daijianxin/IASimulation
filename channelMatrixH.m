function [ H ] = channelMatrixH( N,M )
%UNTITLED 产生复高斯信道矩阵
%   此处显示详细说明

% H_real = randn(N, M);
% H_imag = randn(N, M);

H_real =normrnd(0,(1/2)^(1/2),N,M);
H_imag =normrnd(0,(1/2)^(1/2),N,M);
H = H_real + 1i * H_imag;


end

