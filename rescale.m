function Y = rescale(X,new_max,new_min,method)

if(method='minmax')
old_max=max(X);
old_min=min(X);
Y=((new_max-new_min)/(old_max-old_min))*(X-old_min) + new_min;
elseif(method=='mean')

