function [BestAccuracy,ConfMat,Order]=Classifier(X,method,S,N)
% X is the matrix with first column as labels and rest of the columns as
% features
% method is classification method
        % 'svm'  svm classifier
        % 'tree' decision tree
% S is samples to use for training eg 0.7,0.8 etc
% N is the number of times to repeat cross validation eg 10
%%
%X=[[zeros(10,1);ones(30,1);2*ones(40,1)] rand(80,20)];
%%

classlabels=unique(X(:,1));
M=length(X(:,1));
Xr=cell(1,length(classlabels)); %rearranged X
for i=1:length(classlabels)
    class=find(X(:,1)==classlabels(i)); % All samples with class classlabels(i)
    if(length(class)< M)
        M=length(class); % minimum samples available for a class
    end    
    Xr(i)={X(class,:)};
end
%%
BestAccuracy=0;
for k=1:N
  index=randperm(M);
  trainindex=index(1:floor(M*S)); %random training indices partioned with S
  testindex=index(floor(M*S)+1:M); %random test indices
  traindata=[];
  testdata=[];
  for i=1:length(classlabels)
    traindata=[traindata;Xr{i}(trainindex,:)];
    testdata=[testdata;Xr{i}(testindex,:)];
  end
  if(isequal(method,'svm'))
      model=libsvmtrain(traindata(:,1),traindata(:,2:end),'-t 1 -d 5 -g 2 -h 0 -c 5');
      [pred_lab]=svmpredict(testdata(:,1),testdata(:,2:end),model);
  elseif(isequal(method,'tree'))
      model=TreeBagger(100,traindata(:,2:end),traindata(:,1),'OOBPred','On');
      pred_lab=str2num(cell2mat(predict(model,testdata(:,2:end))));
  end
  accuracy=100*sum(pred_lab==testdata(:,1))/length(testdata(:,1));
  if(accuracy>BestAccuracy)
      BestAccuracy=accuracy;
      [ConfMat,Order]=confusionmat(testdata(:,1),pred_lab);
  end
  
end
  
