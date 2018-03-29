function X_1 = incline_turth_box(X)
c = minBoundingBox(X);
% figure(42);
% hold off,  plot(X(1,:),X(2,:),'*')
% hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r')
% axis equal
X_1 = [];
d = [];
for i=1:4
   for j=1:4
       d_j=norm(X(:,i)-c(:,j));
       d=[d;d_j];
   end
   [min_of_d,k]=min(d);
   X_1=[X_1;c(:,k)];
   d = [];
end