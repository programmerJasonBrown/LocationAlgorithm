function [x,y,z] = getX(L,Q,R) 
x0 = [0,0,0];
options = optimset('Display','off');
a = fsolve(@(a)root2d(a,L,Q,R),x0,options);
x = a(1);
y = a(2);
z = a(3);
end