x1 = 0; y1 = 0; z1 = 243.3;   %L
x2 = 363.9; y2 = 0; z2 = 103;   %R
x3 = 0; y3 = 804.8; z3 = 61.1;   %Q
while(1)
prompt = 'What is the x0 value? ';
x0 = input(prompt);
prompt = 'What is the y0 value? ';
y0 = input(prompt);
prompt = 'What is the z0 value? ';
z0 = input(prompt);

d1 = sqrt(x0^2 + y0^2 + z0^2) + randn(1)
d2 = sqrt((x0 - x1)^2+(y0 - y1)^2+(z0 - z1)^2) + randn(1)
d3 = sqrt((x0 - x2)^2+(y0 - y2)^2+(z0 - z2)^2) + randn(1)
d4 = sqrt((x0 - x3)^2+(y0 - y3)^2+(z0 - z3)^2) + randn(1)
d5 = sqrt(x0^2 + y0^2 + z0^2) + randn(1)
d6 = sqrt((x0 - x1)^2+(y0 - y1)^2+(z0 - z1)^2) + randn(1)
d7 = sqrt((x0 - x2)^2+(y0 - y2)^2+(z0 - z2)^2) + randn(1)
d8 = sqrt((x0 - x3)^2+(y0 - y3)^2+(z0 - z3)^2) + randn(1)

d=[d1,d2,d3,d4,d5,d6,d7,d8];
d = d.*10;
[x,y,z] = getX(d); 
 disp(['(',num2str(x),', ',num2str(y),', ',num2str(z),')']);
end

