function Estimation=Chan_TDOA_3D(BSNum,X,Xb,Real_ms,delta0)
%����BSNumΪ����һ���ο���վ�⣬������վ������Ŀ��X��һ��BSNum*3�ľ��󣬱�ʾ������վ����ά���ꣻ
%Xb��һ��1*3����������ʾ�ο��ĵ�һ����վ����ά���ꣻReal_msΪ��Ϊȷ�����ƶ��豸��ʵ���꣨�����ǰһ���֣�
%�Ǹ��������Ϊ�����Ĳ��������Զ�����TDOA����ʱ��
c=3e8;
Rb = sqrt((Real_ms(1) - Xb(1))^2+(Real_ms(2) - Xb(2))^2+(Real_ms(3)-Xb(3))^2);%�ƶ�̨����վ����ʵ����
%Q = eye(BSNum)*(delta0^2);
Q=(eye(BSNum)+ones(BSNum))/2;
%Q=chol(Q_a);
P= normrnd(0,delta0,1,BSNum);%����TDOA�������
Kb = sum(Xb.^2);
R = zeros(BSNum,1);
for i=1:BSNum                %����TDOA����ֵ
    R(i) = -Rb+sqrt((Real_ms(1)- X(i,1))^2+(Real_ms(2) - X(i,2))^2+(Real_ms(3)-X(i,3))^2)+P(i);
end
Pbs = [Xb;X];
N = size(Pbs,1);
K = zeros(1,N);
K = Pbs(:,1).^2 + Pbs(:,2).^2+Pbs(:,3).^2;
ha = 0.5*(R.^2-K(2:N)+K(1));
Ga = -[Pbs(2:N,1)-Xb(1) Pbs(2:N,2)-Xb(2) Pbs(2:N,3)-Xb(3) R];

        %�����һ��WLS���ƽ����Զ���㷨��
Za=pinv(Ga.'*pinv(Q)*Ga)*Ga.'*pinv(Q)*ha;
for i=1:BSNum
    Ba(i,i)=sqrt((Za(1)-X(i,1))^2+(Za(2)-X(i,2))^2+(Za(3)-X(i,3))^2);
end
Fa = c^2*Ba*Q*Ba;
Za1 = pinv(Ga.'*pinv(Fa)*Ga)*Ga.'*pinv(Fa)*ha; %��һ��WLS�Ĺ��ƽ��,��Ϊ�ο������ն�λ������о�
if Za1(4)<0
   Za1(4)=abs(Za1(4));
end
Zacov = pinv(Ga.'*pinv(Fa)*Ga);
        %��һ�Σף̣Ӽ��㣨�����㷨��
ha2=[(Za1(1)-Xb(1))^2;(Za1(2)-Xb(2))^2;(Za1(3)-Xb(3))^2;Za1(4)^2];
Ga2=[1 0 0;0 1 0;0 0 1;1 1 1];
Ba2=diag([Za1(1)-Xb(1),Za1(2)-Xb(2),Za1(3)-Xb(3),Za1(4)]);
Fa2=4*Ba2*Zacov*Ba2;

Za2=pinv(Ga2.'*pinv(Fa2)*Ga2)*Ga2.'*pinv(Fa2)*ha2;

%Za2=pinv(Ga2'*pinv(Ba2)*Ga2*pinv(Q)*Ga2'*pinv(Ba2)*Ga2)*Ga2'*pinv(Ba2)*Ga2*pinv(Q)*Ga2'*pinv(Ba2)*ha2;
%Zacov2 = pinv(Ga2.'*pinv(Fa2)*Ga2)/10;
Za2=abs(Za2);
out=diag(sign(Za1(1:3)-Pbs(1,:).'))*sqrt(Za2)+Pbs(1,:).';
Estimation=out.';
disp("Estimation:"+Estimation);


%-------------------------------------------------------����chan�㷨