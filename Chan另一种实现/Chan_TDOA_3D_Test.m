BSNum = 3;
BS = [      0,        3.56,           0 ; 
            0,            0,       7.84 ;
            2.34,     1.00,       0.74 ]; 
BS = BS(:,1:BSNum);
BS = BS .* 100;
BS0 = [0, 0, 0];
MS = [100, 100, 0];
delta0 = 0;
Chan_TDOA_3D(BSNum,BS,BS0,MS,delta0)