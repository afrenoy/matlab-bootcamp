%% O
% A few examples of basic statistical tests

%% O1
load('data/humansizes.mat');

[hm,pm]=kstest((men-mean(men))/std(men));
[hw,pw]=kstest((women-mean(women))/std(women));

[h1,p1]=ttest2(men,women,0.05,'right','unequal');

% Answer: yes, men are taller

%% O2
load('data/birdsizes.mat');
[hm,pm]=kstest((males-mean(males))/std(males));
[hf,pf]=kstest((females-mean(females))/std(females));
[h2,p2]=ttest2(males,females,0.05,'both','unequal');

% Answer: no, nothing significant
