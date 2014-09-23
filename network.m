
%% Load the interaction data into a matrix. We do not care about time of interactions, for each persons a and b we only need to know wether a and b had at least one interaction during the day.
nnodes=789;
interactions=zeros(nnodes,nnodes);

for i=1:nnodes
  A=importdata(['data/salathe/nodes/node-' int2str(i)]);
  for j=1:size(A,1)
    interactions(i,A(j,1))=1;
    interactions(A(j,1),i)=1;
  end
end

%% Load the role data
A=importdata('data/salathe/roles');
roles=zeros(nnodes,1);
for i=1:nnodes
  roles(A.data(i,1))=A.data(i,2);
end

%% For each person, find the number of other persons he interacted with
interactions_number=zeros(nnodes,1);
for i=1:nnodes
  for j=1:nnodes
    if interactions(i,j)>0
      interactions_number(i)=interactions_number(i)+1;
    end
  end
end

%% Find the guy that interacted with the biggest number of other persons
[~,i]=max(interactions_number);
ri=roles(i);

%% Compare the total number of interactions for students and for teachers
student_average=mean(interactions_number(roles==1));
teacher_average=mean(interactions_number(roles==2));

kstest(interactions_number(roles==1));
kstest(interactions_number(roles==2));

%[h,p]=ttest2(interactions_number(roles==1),interactions_number(roles==2),'Vartype','unequal');
[p,h]=ranksum(interactions_number(roles==1),interactions_number(roles==2));


%% Contingency table for students and teachers
u=[];
v=[];
st=find((roles==1)|(roles==2))';
for i=st
  for j=st
    if interactions(i,j)==1
      %&& j>i
      u=[u roles(i)];
      v=[v roles(j)];
    end
  end
end
[table,chi2,p] = crosstab(u,v);
11133/(11133+200216);
1038/(1038+11133);

%% If we cared about the time of interactions, here is how we could have loaded the data
%nnodes=789;
%interactions=cell(nnodes,nnodes);
%
%for i=1:nnodes
%  A=importdata(['Bootcamp 2013/data/salathe/nodes/node-' int2str(i)]);
%  for j=1:size(A,1)
%    interactions{i,A(j,1)}=[interactions{i,A(j,1)} A(j,2)];
%    interactions{A(j,1),i}=[interactions{A(j,1),i} A(j,2)];
%  end
%end
%
%for i=1:nnodes
%  for j=1:nnodes
%    interactions{i,j}=unique(interactions{i,j});
%  end
%end