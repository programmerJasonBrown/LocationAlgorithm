function F = root2d(x,L,Q,R)


x1 = 0; y1 = 0; z1 = 234;
x2 = 356; y2 = 0; z2 = 100;
x3 = 0; y3 = 784; z3 = 74;

F(1) = ((x(1)-x1)^2+(x(2)-y1)^2+(x(3)-z1)^2)^(1/2)-(x(1)^2+x(2)^2+x(3)^2)^(1/2)-L;
F(2) = ((x(1)-x2)^2+(x(2)-y2)^2+(x(3)-z2)^2)^(1/2)-(x(1)^2+x(2)^2+x(3)^2)^(1/2)-R;
F(3) = ((x(1)-x3)^2+(x(2)-y3)^2+(x(3)-z3)^2)^(1/2) - (x(1)^2+x(2)^2+x(3)^2)^(1/2)-Q;
end