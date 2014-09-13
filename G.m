%% G
load('data/practice.mat');

%% question 1
V2=unique(V1);
q1=0;
for i=V2
    if sum(V1==i)>1
        q1=q1+1;
    end
end


%% question 2
q2=0;
for x=unique(B)'
    if sum(B==x,1)==ones(1,20)
        q2=q2+x;
    end
end


 %% question 3
q3=Inf;
for a=unique(C)'
    if numel(find(sum(C==a,2)>0))<=1
        if a<q3
            q3=a;
        end
    end
end


%% question 4
a=sum(D,1);
b=sum(D,2);
q4=[];
for i=1:size(D,1)
    for j=1:size(D,2)
        if b(i)==a(j)
            fprintf('line %d col %d: val %d \n',i,j,D(i,j));
            q4=[q4 D(i,j)];
        end
    end
end

%% question 5
q5=1;
for i=1:size(E,2)
    m=sum(E(:,i)==i);
    q5=q5*i^m;
end

%% question 5 bis
q5=1;
for i=1:size(E,1)
    for j=1:size(E,2)
        if E(i,j)==j
            q5=q5*j;
        end
    end
end

%% question 6
[~,q6]=max(sum(mod(E,2)==0,1));

%% question 7
q7=sum(sum(E>26));

%% question 8
q8=sum(E(E>26));

%% question 9
q9=max(E(mod(E,3)==0&mod(E,5)>0));
