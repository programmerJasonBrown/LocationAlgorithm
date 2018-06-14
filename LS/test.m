BS = [0,      0,        3.56,           0 ; 
      0,      0,            0,       7.84 ;
      0,      2.34,     1.00,       0.74 ]; 
  
BS = BS.*100;
  
x1 = BS(1,2); y1 = BS(2,2); z1 = BS(3,2);   
x2 = BS(1,3); y2 = BS(2,3); z2 = BS(3,3);   
x3 = BS(1,4); y3 = BS(2,4); z3 = BS(3,4);   

 
while(1)
prompt = 'What is the x0 value? ';
x0 = input(prompt);
prompt = 'What is the y0 value? ';
y0 = input(prompt);
prompt = 'What is the z0 value? ';
z0 = input(prompt);

d1 = sqrt(x0^2 + y0^2 + z0^2) ;
d2 = sqrt((x0 - x1)^2+(y0 - y1)^2+(z0 - z1)^2) ;
d3 = sqrt((x0 - x2)^2+(y0 - y2)^2+(z0 - z2)^2) ;
d4 = sqrt((x0 - x3)^2+(y0 - y3)^2+(z0 - z3)^2) ;



d=[d1,d2,d3,d4]
%d = d.*10;
[x,y,z] = getX(d); 
 disp(['(',num2str(x),', ',num2str(y),', ',num2str(z),')']);
end

