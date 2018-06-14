function X = myChan3(BSN, BS, R, R0)
%   ��myChan2.m�Ļ����ϣ������Ϊ3ά
%   ʵ�����߶�λ�е�CHAN�㷨
%   �ο���ChanAlgorithm.m NetworkTop.m ����ף����Ͻ�ͨ��ѧ��10 December, 2004, ��һ��
%         ���л�, ��ع��, ����. ����Chan��TDOA��ά��λ�㷨[J]. �ִ����ſƼ�, 2014(11):36-40.
%       - BSN Ϊ��վ������3 < BSN <= 7��
%       - BS Ϊ (3, BSN) ����Ϊ���� BS ������ x �� y �� z
%       - R Ϊ (BSN-1) ������Ϊ�����е� r_{i,1}������ 2,3,...BSN ����վ���һ����վ
%           �� MS �ľ���֮�����TDOA���Թ���ֱ�����
%       - X Ϊ��õ� MS ��λ�� x �� y �� z
 
    % �������ʣ�
    Q = eye(BSN-1); % (BSN-1,BSN-1)
    % ��һ��LS��
    K1 = 0;
    for i = 1: BSN-1
        K(i) = BS(1,i+1)^2 + BS(2,i+1)^2 + BS(3,i+1)^2; % x^2+y^2+z^2, K(1,BSN-1)
    end

    % Ga (BSN-1,4)
    for i = 1: BSN-1
        Ga(i,1) = -BS(1, i+1);
        Ga(i,2) = -BS(2, i+1);
        Ga(i,3) = -BS(3, i+1); % ����
        Ga(i,4) = -R(i);
    end

    % h (1,BSN-1) ������ת�þͺ�
    for i = 1: BSN-1
        h(i) = 0.5*(R(i)^2 - K(i) + K1);   %[-4.656259665668557e+10,-2.132178677556575e+10,-1.889605993105816e+10]
    end

    % �ɣ�14b������B�Ĺ���ֵ��(4,1)
    Za0 = pinv(Ga'*pinv(Q)*Ga)*Ga'*pinv(Q)*h';

    % ����������Թ���ֵ����B��(BSN-1,BSN-1)
    B = eye(BSN-1);
    for i = 1: BSN-1
        B(i,i) = sqrt((BS(1,i+1) - Za0(1))^2 + (BS(2,i+1) - Za0(2))^2 + (BS(3,i+1) - Za0(3))^2); % ������
    end

    % FI: (BSN-1,BSN-1)
    FI = B*Q*B;

    % ��һ��LS�����(BSN-1,1)
    Za1 = pinv(Ga'*pinv(FI)*Ga)*Ga'*pinv(FI)*h';

    if Za1(4) < 0  % Za1(3)��ΪZa1(4)
        Za1(4) = abs(Za1(4));
    %     Za1(4) = 0;
    end
    %***************************************************************

    % �ڶ���LS��
    % ��һ��LS�����Э���(4,4)
    CovZa = pinv(Ga'*pinv(FI)*Ga);

    % sB��
    sB = eye(4); % (4,4)
    for i = 1: 4
        sB(i,i) = Za1(i);
    end

    % sFI��
    sFI = 4*sB*CovZa*sB; % (4,4)

    % sGa��
    sGa = [1, 0, 0; 0, 1, 0; 0, 0, 1; 1, 1, 1]; % �ĵ� (4,3)

    % sh
    sh  = [Za1(1)^2; Za1(2)^2; Za1(3)^2; Za1(4)^2]; % ���˵����� (4,1)

    % �ڶ���LS�����
    Za2 = pinv(sGa'*pinv(sFI)*sGa)*sGa'*pinv(sFI)*sh; % (3,1)

    % Za = sqrt(abs(Za2));

    Za = sqrt(Za2);

    % ���:
    % if Za1(1) < 0,
    %     out1 = -Za(1);
    % else
    %     out1 = Za(1);
    % end
    % if Za2(1) < 0,
    %     out2 = -Za(2);
    % else
    %     out2 = Za(2);
    % end
    % 
    % out = [out1;out2];
    out = abs(Za);
    
    % ��Ҫ�Ѹ߶�ȡ������ʱ����
    out(3) = -out(3); 
	
	out(3) = (BS(1,4)^2+BS(2,4)^2+BS(3,4)^2-R0(4)^2+R0(1)^2-2*BS(1,4)*out(1)-2*BS(2,4)*out(2))/(2*BS(3,4));
	

    if nargout == 1
        X = out';
    elseif nargout == 0
        disp(out);
    end
