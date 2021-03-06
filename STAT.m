function [Features]=STAT(Z,K)
%Statistical features as defined in
%http://ieeexplore.ieee.org/lpdocs/epic03/wrapper.htm?arnumber=6858031
%Z is the time series
%K is the used to choose the features valid values can be any of the
%combination of following
  %  'm' -> mean
  %  's' -> standard deviation
  %  'd' -> first difference
  %  'e' -> normalised first difference
  %  'f' -> second difference
  %  'g' -> normalised second difference
  Features=[];
  if any(K=='m')
  Features(end+1)=mean(Z); %mean
  end
  if any(K=='s')
  Features(end+1)=std(Z); %std
  end
  if any(K=='d')
  Features(end+1)=sum(abs(Z(2:end)-Z(1:end-1)))/(length(Z)-1); %first difference
  end
  if any(K=='e')
  Features(end+1)=Features(3)/Features(2);%normalised first difference
  end
  if any(K=='f')
  Features(end+1)=sum(abs(Z(3:end)-Z(1:end-2)))/(length(Z)-2);%second difference
  end
  if any(K=='g')
  Features(end+1)=Features(5)/Features(2);%normalised second difference
  end