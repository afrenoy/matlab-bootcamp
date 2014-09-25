% The function epidemiology.m is making one simulation with given
% parameters.
% In the script we first call this function 1000 times to produce the
% matrices nbinfected and nbimmunized (1000 lines corresponding to
% independent simulations and 100 columns corresponding to time points in
% weeks).
% Then we parse these matrices to produce plots than answer the questions.

%% q1

rng('shuffle');

lsim=100;
nsim=1000;
nbinfected=zeros(nsim,lsim);
nbimmunized=zeros(nsim,lsim);
nbstudents=50;
nini=1;

for i=1:nsim
    [nbinfected(i,:),nbimmunized(i,:)]=epidemiology( nbstudents, 0.5, 0.1, nini);
end

m=mean(nbinfected,1);
s=std(nbinfected,1);

%% q2

hold on;
plot(m+s,'Color',[0 0 1],'LineWidth',2.0,'LineStyle','--');
plot(m-s,'Color',[0 0 1],'LineWidth',2.0,'LineStyle','--');

fill([1:lsim lsim:-1:1],[m+s m(lsim:-1:1)-s(lsim:-1:1)],[0.5 0.5 1],'EdgeColor',[0 0 1],'EdgeAlpha',0,'FaceAlpha',0.3);
plot(m,'Color',[0 0 1],'LineWidth',2.0);

set(gca,'FontSize',16);
xlabel('Time','FontSize',16);
ylabel('Number of infected students','FontSize',16);

%% q3
figure();
hist(nbinfected(:,6),0.5:15.5);
xlabel('Nb infected at t = 6 weeks','FontSize',16);
% We can also try for hist(nbinfected(:,20))

%% q5
df=zeros(nsim,1);
for i=1:nsim
    a=nbinfected(i,:);
    b=[-1 a];
    b(lsim)=[];
    l=find(a==0&b>0);
    if length(l)>=1
        df(i)=l(1);
    end
end

df(df==0)=[]; % We remove simulations in which the class does not become disease free before the end of the simulation

figure();
hist(df);
xlabel('Time at which the class is disease free','FontSize',16);

%% q6
thalf=zeros(nsim,1);
for i=1:nsim
    a=nbimmunized(i,:);
    b=[-1 a];
    b(lsim)=[];
    l=find(a>nbstudents/2&b<nbstudents/2);
    if length(l)>=1
        thalf(i)=l(1);
    end
end

thalf(thalf==0)=[]; % We remove simulations in which the class does not become disease free before the end of the simulation

figure();
hist(thalf);
xlabel('Time at which half of the class is immunized','FontSize',16);

%% q7
rng('shuffle');

lsim=100;
nsim=10;
nbstudents=500;
nini=10;
pinf=0.1:0.1:1;
pcur=0.1:0.1:1;
totinf=zeros(length(pinf),length(pcur));

for i=1:length(pinf)
    for j=1:length(pcur)
        nbinfected=zeros(nsim,lsim);
        nbimmunized=zeros(nsim,lsim);
        for k=1:nsim
            [nbinfected(k,:),nbimmunized(k,:)]=epidemiology( nbstudents, pinf(i), pcur(j), nini);
        end
        totinf(i,j)=mean(nbinfected(:,lsim)+nbimmunized(:,lsim));
    end
end

pcolor(pinf,pcur,totinf);
colorbar();
ylabel('Pinf','FontSize',16);
xlabel('Pcur','FontSize',16);