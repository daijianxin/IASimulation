function [ H ] =  UserChannelMatrixH( k, N, M )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
for i = 1 : k
    for j = 1 : k
        H( :, :, i, j) = channelMatrixH( N, M );  % ͨ���Լ�д�ĺ���channelMatrixH���������ŵ����󣨱�׼��˹��
    end
end

end

