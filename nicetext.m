function [] = nicetext(M)

for i=1:size(M,2)
    fprintf('The highest element of column %d is %d\n',i,max(M(:,i)));
end

end