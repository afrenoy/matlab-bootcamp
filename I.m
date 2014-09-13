%% I1
nicetext([1,5,3;2,9,0;0,1,8])
%see file nicetext.m for source of this function

%% I2
f=fopen('data/samples.txt');
a=fscanf(f,'Sample: %c%d, Value: %f\n');
groups=a(1:3:length(a));
values=a(3:3:length(a));

for g = unique(groups)'
    fprintf('for group %c average is %f\n',g, mean(values(groups==g)));
end
