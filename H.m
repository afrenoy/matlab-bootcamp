%% H
load('data/practice.mat');

%% question 1
[~,b]=sort(E(1,:));
F=E(:,b);

%% question 2
%function r = q2(X)
[~,b]=sort(X);
r=sum(([b,0] - [0 b+1])==0)>0;