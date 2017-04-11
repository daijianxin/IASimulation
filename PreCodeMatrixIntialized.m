function [ V ] = PreCodeMatrixIntialized(k, M,d )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%   Input :
%               M :  发射端天线数
%               d :  每个用户使用码流数
%    Output:    V :  符合 V'*V 为单位矩阵的预编码矩阵
I = eye(M);
V_code = I(:,1:d);
for i =1 : k
    V(:,:,i)  = V_code;  % 构造预编码矩阵
end
end

