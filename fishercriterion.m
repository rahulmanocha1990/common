function [J]=fishercriterion(X,labels)

%X is M X N matrix, M samples and N features
% labels is M X 1 vector of class labels
% J is 1 X N vector of fisher criterion for each feature
M=size(X,1);
N=size(X,2);
M1=size(labels,1);
if(~isequal(M,M1))
    error('Number of samples and number of labels should be same');
end
classes=unique(labels);
for f=1:N % for each feature
   for i=1:length(classes) 
     u(i)=mean(X(labels==classes(i),f)); % mean of feature f for different classes
     sigma(i)=std(X(labels==classes(i),f));% std of feature f for different classes
   end
   J(f)=abs(u(2)-u(1))/((sigma(2)^2)+(sigma(1)^2));
end