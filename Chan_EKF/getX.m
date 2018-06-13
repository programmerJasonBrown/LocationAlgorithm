function [a,b,c] = getX(d)
% 基站数目
BSN = 4;
N = 2;         %计算连续N个时刻 
n = 3;            %状态维度

% 各个基站的位置
BS = [0,      0,        3.56,           0, ; 
      0,      0,            0,       7.84, ;
      0,      2.34,     1.00,       0.74, ]; 
BS = BS(:,1:BSN);
BS = BS .* 100;
d = d./10;
R0 = d(1:4); %用来存放距离观测值
R1 = d(5:8);

for i = 1: BSN-1
    R(i) = R0(i+1) - R0(1); 
	R_(i) = R1(i+1) - R1(1); 
end
X = zeros(n,N); %存Chan计算的结果
X(:,1) = myChan3(BSN, BS, R,R0);
X(:,2) = myChan3(BSN, BS, R_,R1);



RR = [R0',R1'];
RR = RR.^2; %用来存放距离观测值的平方

Q=0.1^2*eye(n); %过程方差
RN=0.04;         %测量值的方差 
f=@(x)[x(1);x(2);x(3)];  %状态方程
h=@(x)[(x(1)-BS(1,1))^2+(x(2)-BS(2,1))^2+(x(3)-BS(3,1))^2 ...,
;(x(1)-BS(1,2))^2+(x(2)-BS(2,2))^2+(x(3)-BS(3,2))^2 ...,
;(x(1)-BS(1,3))^2+(x(2)-BS(2,3))^2+(x(3)-BS(3,3))^2 ...,
;(x(1)-BS(1,4))^2+(x(2)-BS(2,4))^2+(x(3)-BS(3,4))^2];                   %测量方程
s=X(:,1);      
x=s;                        
P = eye(n);                               
xV = zeros(n,N);          
xV(:,1) = s;
for k=2:N
  z = RR(:,k);                            %观测值
  [x1,A]=jaccsd(f,x);                     %计算f的雅可比矩阵，其中x1对应黄金公式line2
  P=A*P*A'+Q;                             %过程方差预测，对应line3
  [z1,H]=jaccsd(h,x1);                    %计算h的雅可比矩阵
  K=P*H'*pinv(H*P*H'+RN);                   %卡尔曼增益，对应line4
  x=x1+K*(z-z1);                          %状态EKF估计值，对应line5
  P=P-K*H*P;                              %EKF方差，对应line6
  xV(:,k) = x;                            %save
end

a = xV(1,2);
b = xV(2,2);
c = xV(3,2);
end