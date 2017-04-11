function [ NewEigVector ] = eigSort( eigValue, eigVector )
%UNTITLED9 此处显示有关此函数的摘要
%   此处显示详细说明
 N = length(eigValue);
 eigDiag = diag(eigValue)';
 [~, index] = sort(eigDiag);
 for i = 1: N
     NewEigVector(:,i) = eigVector(:,index(i));
 end
end

