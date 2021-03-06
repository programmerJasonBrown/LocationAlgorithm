% myChan3 定位误差的变化规律

% 基站数目
BSN = 4;
N = 10;         %计算连续N个时刻 

% 各个基站的位置
BS = [0,      1,       0,       0, ; 
      0,      0,       1,       0, ;
      0,      0,       0,       1, ]; 
BS = BS(:,1:BSN);
BS = BS .* 100;

% MS的实际位置
MS = [20, 20, 20];

% R0i是各个BS与MS的实际距离，无噪声
for i = 1: BSN
    R0(i) = sqrt((BS(1,i) - MS(1))^2 + (BS(2,i) - MS(2))^2 + (BS(3,i) - MS(3))^2); 
end

% 噪声方差
Noise = 0;

% R=R_{i,1},是加上了噪声后，BSi与BS1到MS的距离差，在实际使用中应该由 TDOA * c算得
for i = 1: BSN-1
    R(i) = R0(i+1) - R0(1) + Noise * randn(1); 
end
X = zeros(3,N); %存Chan计算的结果
RR = zeros(4,N); %用来存放距离观测值
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


n=3;            %状态维度
Q=0.1^2*eye(n); %过程方差
R=10;         %测量值的方差 
f=@(x)[x(1);x(2);x(3)];  %状态方程
h=@(x)[(x(1)-BS(1,1))^2+(x(2)-BS(2,1))^2+(x(3)-BS(3,1))^2 ...,
;(x(1)-BS(1,2))^2+(x(2)-BS(2,2))^2+(x(3)-BS(3,2))^2 ...,
;(x(1)-BS(1,3))^2+(x(2)-BS(2,3))^2+(x(3)-BS(3,3))^2 ...,
;(x(1)-BS(1,4))^2+(x(2)-BS(2,4))^2+(x(3)-BS(3,4))^2];                   %测量方程
s=X(:,1);                                %初始状态
%初始化状态
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
	  sV(:,k)= MS;                            %实际状态
end
for k=2:N
  z = RR(:,k);                     
  [x1,A]=jaccsd(f,x);                     %计算f的雅可比矩阵，其中x1对应黄金公式line2
  P=A*P*A'+ Q;                             %过程方差预测，对应line3
  [z1,H]=jaccsd(h,x1);                    %计算h的雅可比矩阵
  K=P*H'*pinv(H*P*H'+R);                   %卡尔曼增益，对应line4
  x=x1+K*(z-z1);                          %状态EKF估计值，对应line5
  P=P-K*H*P;                              %EKF方差，对应line6
  xV(:,k) = x;                            %save
  %s = f(s) + Q*randn(3,1);                %update process 
end
disp('观测值： ');
X
disp('EKF最优估计值： ');
xV

for k=1:3
  FontSize=14;
  LineWidth=1;
  figure();
  plot(sV(k,:),'r-'); %画出真实值
  hold on;
  plot(xV(k,:),'b-','LineWidth',LineWidth) %画出最优估计值
  hold on;
  
  plot(zV(k,:),'k+'); %画出状态测量值
  hold on;
  legend('真实状态', 'EKF最优估计估计值','状态测量值');
  xl=xlabel('测量次数');
  if k == 1
	t=['x轴 ',] ;
  end
  if k == 2
	t=['y轴 ',] ;
  end
  if k == 3
	t=['z轴 ',] ;
  end
  %t=['状态 ',num2str(k)] ;
  yl=ylabel(t);
  set(xl,'fontsize',FontSize);
  set(yl,'fontsize',FontSize);
  hold off;
  set(gca,'FontSize',FontSize);
end
