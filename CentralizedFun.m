 function [ V, U] = CentralizedFun(   N, M, d, H )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

k =3;

%% 根据集中式闭式解计算所需的与编码矩阵
E = pinv(H(:,:,3,1)) * H(:,:,3,2) * pinv(H(:,:,1,2)) * H(:,:,1,3) * pinv(H(:,:,2,3)) * H(:,:,2,1);
F = pinv(H(:,:,3,2)) * H(:,:,3,1);
G = pinv(H(:,:,2,3)) * H(:,:,2,1);
[e,~] = eig(E);
V(:,:,1) = e(:,1:d);
V(:,:,2) = F * V(:,:,1);
V(:,:,3) = G * V(:,:,1);
%% 下面论文中没有给出详细的方法， 我根据对文章的理解构思的解法，经验证是有效的

 Q(:,:,1) = (null( (H(:,:,1,2)*V(:,:,2))' ))'; % Q矩阵 满足将干扰转换到与用用信号不同的正交子空间
 Q(:,:,2) = (null( (H(:,:,2,1)*V(:,:,1))' ))';
 Q(:,:,3) = (null( (H(:,:,3,1)*V(:,:,1))' ))';
 for i = 1 : k
    
 U(:,:,i)=pinv(Q(:,:,i)*H(:,:,i,i)*V(:,:,i))*Q(:,:,i);  % 用户k的破零矩阵 
 
 end


 end

