function [z]=ZCR(x)
%Zero crossing rate for x
N=length(x);
z=sum((sign(x(2:end))-sign(x(1:end-1))).^2);
z=z/(N-1);