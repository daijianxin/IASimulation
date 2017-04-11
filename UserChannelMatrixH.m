function [ H ] =  UserChannelMatrixH( k, N, M )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1 : k
    for j = 1 : k
        H( :, :, i, j) = channelMatrixH( N, M );  % 通过自己写的函数channelMatrixH（）生成信道矩阵（标准高斯）
    end
end

end

