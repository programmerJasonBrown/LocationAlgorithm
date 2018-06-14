function [x,y,z] = getX(d) 
x0 = [0,0,0];
BS = [0,      0,        3.56,           0 ; 
      0,      0,            0,       7.84 ;
      0,      2.34,     1.00,       0.74 ]; 
%d = d ./10;
BS = BS.*100;
options = optimset('Display','off');
a = fsolve(@(a)LSfunction(a,d,BS),x0,options);
x = a(1);
y = a(2);
z = a(3);
end