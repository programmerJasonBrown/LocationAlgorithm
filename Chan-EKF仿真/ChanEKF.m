% myChan3 ��λ���ı仯����

% ��վ��Ŀ
BSN = 4;
N = 10;         %��������N��ʱ�� 

% ������վ��λ��
BS = [0,      1,       0,       0, ; 
      0,      0,       1,       0, ;
      0,      0,       0,       1, ]; 
BS = BS(:,1:BSN);
BS = BS .* 100;

% MS��ʵ��λ��
MS = [20, 20, 20];

% R0i�Ǹ���BS��MS��ʵ�ʾ��룬������
for i = 1: BSN
    R0(i) = sqrt((BS(1,i) - MS(1))^2 + (BS(2,i) - MS(2))^2 + (BS(3,i) - MS(3))^2); 
end

% ��������
Noise = 0;

% R=R_{i,1},�Ǽ�����������BSi��BS1��MS�ľ�����ʵ��ʹ����Ӧ���� TDOA * c���
for i = 1: BSN-1
    R(i) = R0(i+1) - R0(1) + Noise * randn(1); 
end
X = zeros(3,N); %��Chan����Ľ��
RR = zeros(4,N); %������ž���۲�ֵ
for k = 1:N
	for i = 1: BSN-1
		R(i) = R0(i+1) - R0(1) + Noise * randn(1); 
	end
	for i = 1: BSN
		RR(i,k) = R0(i)^2 + Noise * randn(1);
	end

	X(:,k) = myChan3(BSN, BS, R,R0);
end
%%============================================================%%


n=3;            %״̬ά��
Q=0.1^2*eye(n); %���̷���
R=10;         %����ֵ�ķ��� 
f=@(x)[x(1);x(2);x(3)];  %״̬����
h=@(x)[(x(1)-BS(1,1))^2+(x(2)-BS(2,1))^2+(x(3)-BS(3,1))^2 ...,
;(x(1)-BS(1,2))^2+(x(2)-BS(2,2))^2+(x(3)-BS(3,2))^2 ...,
;(x(1)-BS(1,3))^2+(x(2)-BS(2,3))^2+(x(3)-BS(3,3))^2 ...,
;(x(1)-BS(1,4))^2+(x(2)-BS(2,4))^2+(x(3)-BS(3,4))^2];                   %��������
s=X(:,1);                                %��ʼ״̬
%��ʼ��״̬
%x=s+q*randn(3,1); 
x=s;                        
P = eye(n);                               
xV = zeros(n,N);          
sV = zeros(n,N);         
zV = X;
R0 = R0';
MS = MS';
sv(:,1) = MS;
xV(:,1) = s;
for k = 1:N
	  sV(:,k)= MS;                            %ʵ��״̬
end
for k=2:N
  z = RR(:,k);                     
  [x1,A]=jaccsd(f,x);                     %����f���ſɱȾ�������x1��Ӧ�ƽ�ʽline2
  P=A*P*A'+ Q;                             %���̷���Ԥ�⣬��Ӧline3
  [z1,H]=jaccsd(h,x1);                    %����h���ſɱȾ���
  K=P*H'*pinv(H*P*H'+R);                   %���������棬��Ӧline4
  x=x1+K*(z-z1);                          %״̬EKF����ֵ����Ӧline5
  P=P-K*H*P;                              %EKF�����Ӧline6
  xV(:,k) = x;                            %save
  %s = f(s) + Q*randn(3,1);                %update process 
end
disp('�۲�ֵ�� ');
X
disp('EKF���Ź���ֵ�� ');
xV

for k=1:3
  FontSize=14;
  LineWidth=1;
  figure();
  plot(sV(k,:),'r-'); %������ʵֵ
  hold on;
  plot(xV(k,:),'b-','LineWidth',LineWidth) %�������Ź���ֵ
  hold on;
  
  plot(zV(k,:),'k+'); %����״̬����ֵ
  hold on;
  legend('��ʵ״̬', 'EKF���Ź��ƹ���ֵ','״̬����ֵ');
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
