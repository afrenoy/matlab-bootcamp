
%% N1
x=0:0.01:1;
y=0:0.01:1;
z=zeros(101,101);
for i=1:101
  for j=1:101
    z(i,j)=sin(6*x(i))+y(j);
  end
end

surf(x,y,z);

%% N2
close all;
pcolor(x,y,z);
colorbar;

%% N3
close all;
subplot(1,2,1);
surf(x,y,z);
subplot(1,2,2);
pcolor(x,y,z);
colorbar;

%% N4
print('-dpdf','f1.pdf');
