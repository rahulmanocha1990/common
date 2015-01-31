%Higuchi Fractal Dimension
function [F]=HFD(X,Kmax)  
%X is input signal(Time series)
%K is a parameter for creating new time series
L=[];
x=[];
N=length(X);

% for k=1:Kmax-1
%     Lk=[];
%     for m=0:k-1
%         Lmk = 0;
%         for i=1:floor((N-m)/k)-1
%             Lmk=Lmk+abs(X(m+i*k+1) - X(m+i*k-k+1));
%         end
%         Lmk=Lmk*(N-1)/floor((N-m)/k)/k;
%         Lk(end+1)=Lmk;
%     end
%     L(end+1)=log(mean(Lk));
%     x(end+1,:)=[log(1/k) 1];
%     
% end
for k=1:Kmax
    Lk=[];
    for m=1:k
        Lmk = 0;
        for i=1:floor((N-m)/k)
            Lmk=Lmk+abs(X(m+i*k) - X(m+i*k-k));
        end
        Lmk=Lmk*(N-1)/(floor((N-m)/k)*k);
        Lk(end+1)=Lmk/k;
    end
    L(end+1)=log(mean(Lk));
    x(end+1,:)=[log(1/k) 1];
    
end




f=((x'*x)^-1)*x'*L';%least square fit of x and L
%to find slope of the curve.
F=f(1);
