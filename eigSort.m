function [ NewEigVector ] = eigSort( eigValue, eigVector )
%UNTITLED9 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
 N = length(eigValue);
 eigDiag = diag(eigValue)';
 [~, index] = sort(eigDiag);
 for i = 1: N
     NewEigVector(:,i) = eigVector(:,index(i));
 end
end

