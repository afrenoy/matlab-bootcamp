%%
f=fopen('data/trees.txt');
a=fscanf(f,'Height: %f, water: %f, sun: %f, wind: %f\n');
fclose(f);
%%
h=a(1:4:length(a));
water=a(2:4:length(a));
sun=a(3:4:length(a));
wind=a(4:4:length(a));
n=length(water);
%% 
[i,j]=sort(water);
idminwater=j(1:floor(n/5));
idmaxwater=j(n-floor(n/5)+1:n);

%%
scatter(water,h);
xlabel('water','FontSize',16);
ylabel('height','FontSize',16);
set(gca,'FontSize',16);

%%
figure();
scatter(sun,h);
xlabel('sun','FontSize',16);
ylabel('height','FontSize',16);
set(gca,'FontSize',16);

%%
figure();
scatter(sun,water);
xlabel('sun','FontSize',16);
ylabel('water','FontSize',16);
set(gca,'FontSize',16);
% We can also compute mutual information, look on wikipedia

%%
figure()
scatter(wind,sun);
xlabel('wind','FontSize',16);
ylabel('sun','FontSize',16);
set(gca,'FontSize',16);

%%
figure()
scatter(wind,water);
xlabel('wind','FontSize',16);
ylabel('water','FontSize',16);
set(gca,'FontSize',16);

%%
[coeff,score,latent,tsquared,explained,mu]=pca([water sun wind]);
figure();
scatter(sun-water,wind);
xlabel('sun - water','FontSize',16);
ylabel('wind','FontSize',16);
set(gca,'FontSize',16);
% No they are not independent: two of the variables can entirely predict
% the third one

%%
figure()
scatter(wind,h);
xlabel('wind','FontSize',16);
ylabel('height','FontSize',16);
set(gca,'FontSize',16);
% wind seems to have very small effect

%% 
w1=min(water);
w2=max(water);
s1=min(sun);
s2=max(sun);

wrange=linspace(w1,w2,30);
srange=linspace(s1,s2,30);
res=zeros(numel(wrange),numel(srange));

for i=1:numel(wrange)-1
    wcond=water>wrange(i)&water<wrange(i+1);
    tsun=sun(wcond);
    th=h(wcond);
    for j=1:numel(srange)-1
        res(i,j)=mean(th(tsun>srange(j)&tsun<srange(j+1)));
    end
end

pcolor(res);
ylabel('water');
xlabel('sun');