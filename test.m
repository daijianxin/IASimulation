clc
clear
close
k =3; N = 6; M =6 ; d = 3; P =30;


% V = PreCodeMatrixIntialized(k, M, d );  % ����Ԥ�������
% [ H ] =  UserChannelMatrixH( k, N, M );
% count = 1e3;
% for w = 1: count
% for i = 1 : k
%     Q(:,:,i) = zeros(N,N);
%    for j = 1 :k
%        Q(:,:,i) = Q(:,:,i) + H(:,:,i,j)*V(:,:,j)*(H(:,:,i,j)*V(:,:,j))';
%    end
%      Q(:,:,i) = Q(:,:,i) - H(:,:,i,i)*V(:,:,i)*(H(:,:,i,i)*V(:,:,i))';
% end
% 
%     for i =1 : k
%         [E(:,:,i), eigValue ] = eig(Q(:,:,i));
%         E(:,:,i)= eigSort(eigValue, E(:,:,i)); %  ����ֵ����
%          U(:,:,i) = E(:, d+1: end, i);
% 
%     end
% 
% for j = 1 : k
%     P(:,:,j) = zeros(M,M);
%    for i = 1 :k
%        P(:,:,j) = P(:,:,j) + H(:,:,i,j)'*(eye(N)-U(:,:,i)*U(:,:,i)')* H(:,:,i,j);
%    end
%      P(:,:,j) = P(:,:,j) -  H(:,:,j,j)'*(eye(N)-U(:,:,j)*U(:,:,j)')* H(:,:,j,j);
% end
% %   IY(w)=abs(P(1,1,1)) ;
%     obj(w)=0;
%  for i =1 :k
%     for j= 1: k
%        if (i~=j)
%            obj(w)= obj(w) + norm(H(:,:,i,j)*V(:,:,j)-U(:,:,i)*U(:,:,i)'*H(:,:,i,j)*V(:,:,j));
%        end
%     end
%  end
% 
% 
%     for i =1 : k
%         [E_1(:,:,i), eigValue ] = eig(P(:,:,i)); 
%         E_1(:,:,i)= eigSort(eigValue, E_1(:,:,i)); %  ����ֵ����
%          V(:,:,i) = E_1(:, 1: d, i);
%     end    
% 
%     
%     
% end  
% 
% plot(obj)
% 
% 
% 
% 
% %     abs( U(:,:,1)' * H(:,:,1,1)*V(:,:,1))
% %     plot(abs(I))
% %     abs(U(:,:,j)*U(:,:,j)')
% 
% %% ����������û�и�����ϸ�ķ����� �Ҹ��ݶ����µ���⹹˼�Ľⷨ������֤����Ч��
% 
%  X(:,:,1) = (null( (H(:,:,1,2)*V(:,:,2))' ))'; % Q���� ���㽫����ת�����������źŲ�ͬ�������ӿռ�
%  X(:,:,2) = (null( (H(:,:,2,1)*V(:,:,1))' ))';
%  X(:,:,3) = (null( (H(:,:,3,1)*V(:,:,1))' ))';
%  for i = 1 : k
%     
%  U_U(:,:,i)=pinv(X(:,:,i)*H(:,:,i,i)*V(:,:,i))*X(:,:,i);  % �û�k��������� 
%  
%  end
% U_U(:,:,1)*H(:,:,1,1)*V(:,:,1)
% U_U(:,:,1)*(H(:,:,1,2)*V(:,:,2) + H(:,:,1,3)*V(:,:,3))
% X(:,:,1)*H(:,:,1,3)*V(:,:,3)