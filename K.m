
%% K1
a=0:0.01:10;
b=3*a.*a - 6*a +1;
plot(a,b);


%% K2
x=0:0.01:5;
plot(x,sin(x),x,cos(x).*cos(x));
legend('sin','cos2');