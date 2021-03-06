function [FV]=HOC(Z,L)
%Higher Order Crossing for time series Z as given in paper 
%http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=5291724
% L is the number of features to be produces or number of filters to be
% used
%FV includes ZCR for k=1 to L


for k=1:L 
    Zk=[]; % New time series by filtering Z
    Coef=[];
    for j=1:k
       Coef(j)=nchoosek(k-1,j-1)*(-1^(j-1));
    end
    Zk=filter(Coef,1,Z);
    FV(k)=ZCR(Zk);
end

