%% Load the data

[raw_m,hraw_m] = xlsread('data/influenza.xls','Raw Data (EAM)');
[raw_f,hraw_f] = xlsread('data/influenza.xls','Raw Data (EAF)');

[pop_m,hpop_m] = xlsread('data/influenza.xls','Population (EAM)');
[pop_f,hpop_f] = xlsread('data/influenza.xls','Population (EAF)');

[survival_m,hsurvival_m] = xlsread('data/influenza.xls','1 minus TOT (EAM)');
[survival_f,hsurvival_f] = xlsread('data/influenza.xls','1 minus TOT (EAF)');

%% Save the age categories and shorten them
age=hpop_m;
for i = 2:length(age)
    k = length(age{i});
    age{i}=age{i}(1:k-6);
end
age{2}='1-';

%% Interpolate for missing data in 1991

l1 = raw_m(91,2:27);
l2 = raw_m(93,2:27);
r1 = rand(1,26);
linter = round(l1 + r1.*(l2-l1));
raw_m(92,2:27)=linter;
raw_m(92,28)=sum(linter);

l1 = raw_f(91,2:27);
l2 = raw_f(93,2:27);
r1 = rand(1,26);
linter = round(l1 + r1.*(l2-l1));
raw_f(92,2:27)=linter;
raw_f(92,28)=sum(linter);


%% Check that 'total' entry is the sum of the other entries

S_m = sum(raw_m(:,2:27),2)-raw_m(:,28);
find(S_m~=0)

S_f = sum(raw_f(:,2:27),2)-raw_f(:,28);
find(S_f~=0)

S_m = (sum(pop_m(:,2:23),2)-pop_m(:,24));
find(S_m~=0)

S_f = (sum(pop_f(:,2:23),2)-pop_f(:,24));
find(S_f~=0)

% Note that you may have something different but wery close from 0 for pop_f and pop_m due to numerical approximations

%% Remove the 'total' and the'non-stated' entry

raw_m(:,28)=[];
raw_f(:,28)=[];

raw_m(:,27)=[];
raw_f(:,27)=[];

pop_m(:,24)=[];
pop_f(:,24)=[];
age(24)=[];

% survival_x does not have a 'total' entry

%% Clear useless variables

clear l1 l2 r1 linter S_m S_f;

%% Group the 1 year, 2 year, 3 year and 4 year old together

r_m = raw_m;
r_m(:,3)=sum(r_m(:,3:6),2);
r_m(:,4)=[];
r_m(:,4)=[];
r_m(:,4)=[];

r_f = raw_f;
r_f(:,3)=sum(r_f(:,3:6),2);
r_f(:,4)=[];
r_f(:,4)=[];
r_f(:,4)=[];

s_m = survival_m;
s_m(:,3)=prod(s_m(:,3:6),2);
s_m(:,4)=[];
s_m(:,4)=[];
s_m(:,4)=[];

s_f = survival_f;
s_f(:,3)=prod(s_f(:,3:6),2);
s_f(:,4)=[];
s_f(:,4)=[];
s_f(:,4)=[];

% Nothing to do for pop_x

p_m = pop_m;
p_f = pop_f;


%% Remove the date entry

% Save it to produce the legends later
date=pop_f(:,1);

p_f(:,1)=[];
p_m(:,1)=[];
age(1)=[];

s_f(:,1)=[];
s_m(:,1)=[];

r_f(:,1)=[];
r_m(:,1)=[];

%% Saving the corrected data
save('influenza','age','date','p_f','p_m','r_f','r_m','s_f','s_m');

%% Compute the 'corrected mortality rate' for each year and each age
m1=r_m./(p_m.*s_m);
f1=r_f./(p_f.*s_f);

% This gives us two first ways to plot our data : 'plot(m1(x,:))' (1) and
% 'plot(m1(:,x))' (2)

%% Compute the 'corrected mortality rate' for each birth year and each age

m2=zeros(107,101);
f2=zeros(107,101);

for i=1:107
    for j=1:101
        year = i+j-1;
        if (year>107)
            m2(i,j)=-1;
            f2(i,j)=-1;
            break;
        end;
        if (j==1)
            agecat=1;
        else
            agecat=floor((j-1)/5)+2;
        end;
        m2(i,j)=r_m(year,agecat)/(p_m(year,agecat)*s_m(year,agecat));
        f2(i,j)=r_f(year,agecat)/(p_f(year,agecat)*s_f(year,agecat));
    end
end

% This gives us a third way to plot our data : 'plot(m2(x,:))' (3)

% As we do no longer use the same age categories, we have to create a new
% age list

nage=cell(1,101);
for i=2:100;
    nage{i}=num2str(i-1);
end
nage{1}='1-';
nage{101}='100+';



%% (1)
x=3;
plot(m1(x,:));
legend(num2str(date(x)));
set(gca, 'xtick', 1:22, 'xticklabel', age);
xlabel('age');
ylabel('mortality');

%% (2)

plot(date,m1(:,x));
legend(age{x});
xlabel('date');
ylabel('mortality');

%% (3)

plot(m2(x,:));
legend(['people born in ' num2str(date(x))]);
%set(gca, 'xtick', 1:101, 'xticklabel', nage);
xlabel('age');
ylabel('mortality');

