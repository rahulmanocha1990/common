function [epoch]=meanEpoch(X,samples)
%calculate the mean of epochs in X with size samples 
%output epoch is a mean value calculated as follows



wlen=samples;
wshft=samples;
N=length(X);
start=wshft+1;
finish=start+wlen-1;
sum=X(1:wlen);
count=1;
while finish < N
    sum=sum+X(start:finish);
    count=count+1;
    start=start+wshft;
    finish=start+wlen-1;
end
epoch=sum/count;