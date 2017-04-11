function [ V, UU] = HeathIteration(P, k, N, M, d, H)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

V = PreCodeMatrixIntialized(k, M, d );  % 构造预编码矩阵
count = 100;
for w = 1: count
    for i = 1 : k
        Q(:,:,i) = zeros(N,N);
        for j = 1 :k
            Q(:,:,i) = Q(:,:,i) + H(:,:,i,j)*V(:,:,j)*(H(:,:,i,j)*V(:,:,j))';
        end
        Q(:,:,i) = Q(:,:,i) - H(:,:,i,i)*V(:,:,i)*(H(:,:,i,i)*V(:,:,i))';
    end
    
    for i =1 : k
        [E(:,:,i), eigValue ] = eig(Q(:,:,i));
        E(:,:,i)= eigSort(eigValue, E(:,:,i)); %  特征值排序
        U(:,:,i) = E(:, d+1: end, i);
    end
    
    for j = 1 : k
        PM(:,:,j) = zeros(M,M);
        for i = 1 :k
            PM(:,:,j) = PM(:,:,j) + H(:,:,i,j)'*(eye(N)-U(:,:,i)*U(:,:,i)')* H(:,:,i,j);
        end
        PM(:,:,j) = PM(:,:,j) -  H(:,:,j,j)'*(eye(N)-U(:,:,j)*U(:,:,j)')* H(:,:,j,j);
    end
    %     obj(w)=0;
    %     for i =1 :k
    %         for j= 1: k
    %             if (i~=j)
    %                 obj(w)= obj(w) + norm(H(:,:,i,j)*V(:,:,j)-U(:,:,i)*U(:,:,i)'*H(:,:,i,j)*V(:,:,j));
    %             end
    %         end
    %     end
    for i =1 : k
        [E_1(:,:,i), eigValue ] = eig(PM(:,:,i));
        E_1(:,:,i)= eigSort(eigValue, E_1(:,:,i)); %  特征值排序
        V(:,:,i) = E_1(:, 1: d, i);
    end
    
    
    
end

%% 下面论文中没有给出详细的方法， 我根据对文章的理解构思的解法，经验证是有效的

X(:,:,1) = (null( (H(:,:,1,2)*V(:,:,2))' ))'; % X矩阵 满足将干扰转换到与用用信号不同的正交子空间
for i = 2:k
    X(:,:,i) = (null( (H(:,:,i,1)*V(:,:,1))' ))';
end
for i = 1 : k
    UU(:,:,i)=pinv(X(:,:,i)*H(:,:,i,i)*V(:,:,i))*X(:,:,i);  % 用户k的破零矩阵
end
% UU(:,:,1)*H(:,:,1,1)*V(:,:,1)
% UU(:,:,1)*(H(:,:,1,2)*V(:,:,2) + H(:,:,1,3)*V(:,:,3))
% X(:,:,1)*H(:,:,1,3)*V(:,:,3)

end

