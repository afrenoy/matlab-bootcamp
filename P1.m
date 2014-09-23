a=importdata('data/plants.txt');

%%
l1=find(a(:,3)==1);
l2=find(a(:,3)==2);
l3=find(a(:,3)==3);
hold on;
plot(a(l1,1),a(l1,2),'LineStyle','none','Marker','+','color','b');
plot(a(l2,1),a(l2,2),'LineStyle','none','Marker','o','color','r');
plot(a(l3,1),a(l3,2),'LineStyle','none','Marker','x','color','g');

%%
a(a==100)=99.99;
lx=0:2:100;
ly=0:2:100;
n=length(lx)-1;

dens1=zeros(n,n);
dens2=zeros(n,n);
dens3=zeros(n,n);

for i=1:n
    for j=1:n
        % Find the number of points between (x,y) and (x+1,y+1)
        dens1(i,j)=sum(a(:,1)>=lx(i)&a(:,1)<lx(i+1)&a(:,2)>=ly(j)&a(:,2)<ly(j+1)&a(:,3)==1);
        dens2(i,j)=sum(a(:,1)>=lx(i)&a(:,1)<lx(i+1)&a(:,2)>=ly(j)&a(:,2)<ly(j+1)&a(:,3)==2);
        dens3(i,j)=sum(a(:,1)>=lx(i)&a(:,1)<lx(i+1)&a(:,2)>=ly(j)&a(:,2)<ly(j+1)&a(:,3)==3);
    end
end

%%
figure();
pcolor(dens1);
figure();
pcolor(dens2);
figure();
pcolor(dens3);

%%
d=reshape([dens1,dens2,dens3],[50 50 3]);
image(d/max(max(max(d))));

%% Distribution of distances for plant A
n=30000;
distA=zeros(n,1);
for x=1:n
    r=randperm(length(l1),2);
    i=r(1);
    j=r(2);
    x1=a(l1(i),1);
    y1=a(l1(i),2);
    x2=a(l1(j),1);
    y2=a(l1(j),2);
    assert(a(l1(i),3)==1);
    assert(a(l1(j),3)==1);
    distA(x)=sqrt((x2-x1)^2+(y2-y1)^2);
end

%% For plants B and C
distB=zeros(n,1);
for x=1:n
    r=randperm(length(l2),2);
    i=r(1);
    j=r(2);
    x1=a(l2(i),1);
    y1=a(l2(i),2);
    x2=a(l2(j),1);
    y2=a(l2(j),2);
    assert(a(l2(i),3)==2);
    assert(a(l2(j),3)==2);
    distB(x)=sqrt((x2-x1)^2+(y2-y1)^2);
end

distC=zeros(n,1);
for x=1:n
    r=randperm(length(l3),2);
    i=r(1);
    j=r(2);
    x1=a(l3(i),1);
    y1=a(l3(i),2);
    x2=a(l3(j),1);
    y2=a(l3(j),2);
    assert(a(l3(i),3)==3);
    assert(a(l3(j),3)==3);
    distC(x)=sqrt((x2-x1)^2+(y2-y1)^2);
end

%%
subplot(3,1,1);
hist(distA,0:10:130);
subplot(3,1,2);
hist(distB,0:10:130);
subplot(3,1,3);
hist(distC,0:10:130);
%% Generate a random distribution
xr=rand(10000,1)*100;
yr=rand(10000,1)*100;

distR=zeros(n,1);
for x=1:n
    r=randperm(10000,2);
    i=r(1);
    j=r(2);
    x1=xr(i);
    y1=yr(i);
    x2=xr(j);
    y2=yr(j);
    distR(x)=sqrt((x2-x1)^2+(y2-y1)^2);
end
hist(distR,0:10:120);

