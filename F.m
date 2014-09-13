%% F
load('data/a.mat');

q3=A(:,3).*A(:,5);

q4=sum(A,2);

q5=sum(sum(A(:,2:2:12)));

q6=numel(find(A>2));
q6bis=sum(sum(A>2));

q7=sum(A(A>2&A< 50));
