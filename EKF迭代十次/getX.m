function [a,b,c] = getX(d)
% ��վ��Ŀ
BSN = 4;
N = 3;         %��������N��ʱ�� 
n = 3;            %״̬ά��

% ������վ��λ��
BS = [0,      0,        3.56,           0, ; 
      0,      0,            0,       7.84, ;
      0,      2.34,     1.00,       0.74, ]; 
BS = BS(:,1:BSN);
BS = BS .* 100;
d = d./10;
X = zeros(n,N); %��Chan����Ľ��
RR = zeros(4,N);
for i = 1:N
	R0 = d((i-1)*4+1:i*4);  %������ž���۲�ֵ
	RR(:,i) = R0';
	for j = 1: BSN-1
		R(j) = R0(j+1) - R0(1); 
	end
	X(:,N) = myChan3(BSN, BS, R,R0);
end





RR = RR.^2; %������ž���۲�ֵ��ƽ��

Q=0.1^2*eye(n); %���̷���
RN=0.04;         %����ֵ�ķ��� 
f=@(x)[x(1);x(2);x(3)];  %״̬����
h=@(x)[(x(1)-BS(1,1))^2+(x(2)-BS(2,1))^2+(x(3)-BS(3,1))^2 ...,
;(x(1)-BS(1,2))^2+(x(2)-BS(2,2))^2+(x(3)-BS(3,2))^2 ...,
;(x(1)-BS(1,3))^2+(x(2)-BS(2,3))^2+(x(3)-BS(3,3))^2 ...,
;(x(1)-BS(1,4))^2+(x(2)-BS(2,4))^2+(x(3)-BS(3,4))^2];                   %��������
s=X(:,1);      
x=s;                        
P = eye(n);                               
xV = zeros(n,N);          
xV(:,1) = s;
for k=2:N
  z = RR(:,k);                            %�۲�ֵ
  [x1,A]=jaccsd(f,x);                     %����f���ſɱȾ�������x1��Ӧ�ƽ�ʽline2
  P=A*P*A'+Q;                             %���̷���Ԥ�⣬��Ӧline3
  [z1,H]=jaccsd(h,x1);                    %����h���ſɱȾ���
  K=P*H'*pinv(H*P*H'+RN);                   %���������棬��Ӧline4
  x=x1+K*(z-z1);                          %״̬EKF����ֵ����Ӧline5
  P=P-K*H*P;                              %EKF�����Ӧline6
  xV(:,k) = x;                            %save
end

a = xV(1,2);
b = xV(2,2);
c = xV(3,2);


for k=1:3
  FontSize=14;
  LineWidth=1;
  figure();
 
  plot(xV(k,:),'b-','LineWidth',LineWidth) %�������Ź���ֵ
  hold on;
  plot(RR(k,:),'k+'); %����״̬����ֵ
  hold on;
  legend( 'EKF���Ź��ƹ���ֵ','״̬����ֵ');
  xl=xlabel('��������');
  if k == 1
	t=['x�� ',] ;
  end
  if k == 2
	t=['y�� ',] ;
  end
  if k == 3
	t=['z�� ',] ;
  end
  %t=['״̬ ',num2str(k)] ;
  yl=ylabel(t);
  set(xl,'fontsize',FontSize);
  set(yl,'fontsize',FontSize);
  hold off;
  set(gca,'FontSize',FontSize);
end 
end