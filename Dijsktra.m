clc;clear;
map = [0,6,3,Inf,Inf,Inf;6,0,2,5,Inf,Inf;3,2,0,3,4,Inf;Inf,5,3,0,2,3;Inf,Inf,4,2,0,5;Inf,Inf,Inf,3,5,0];
visit = zeros(1,6);
src = input('Please input source:');
path = zeros(6,6);
path(:,1) = src;
visit(1,src)=1;
while sum(visit)~=6
    tmp = map(src,:).*~visit;
    tmp(tmp==0)=Inf;
    [~,cc]=find(tmp==min(tmp));
    j = find(path(cc(1,1),:)==0);
    path(cc(1,1),j(1,1)) = cc(1,1);
    visit(1,cc(1,1))=1;
    for i = 1:6
        if map(src,i)>map(src,cc(1,1))+map(cc(1,1),i)
            map(src,i) = map(i,cc(1,1))+map(cc(1,1),src);
            map(i,src) = map(i,cc(1,1))+map(cc(1,1),src);
            path(i,:) = path(cc(1,1),:);
        end
    end
end
