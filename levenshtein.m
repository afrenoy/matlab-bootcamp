function [d] = levenshtein(a,b)

la=length(a);
lb=length(b);

d=max(la,lb);
if min(la,lb)==0
    return
end

dmat=zeros(la+1,lb+1);

dmat(:,1)=0:la;
dmat(1,:)=0:lb;

for i=2:la+1
    for j=2:lb+1
        dmat(i,j)=min([dmat(i-1,j)+1, dmat(i,j-1)+1, dmat(i-1,j-1)+(a(i-1)~=b(j-1))]);
    end
end
d=dmat(la+1,lb+1);
end
