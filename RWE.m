function Features=RWE(X,options)

%RWE can generate relative energy or relative entropy by 1D wavelet
%decomposition of X using arguments specified in options
%options is a cell array with following elements
%     options{1} -> specifies levels of wavelet decomposition eg 5
%     options{2} -> specifies mother wavelet type eg 'db4'
%     options{3} -> selects relative entropy if 1 else relative energy
%     example options={5,'db4',1}
    
levels=options{1};
if ~isnumeric(levels) || isempty(levels)
    error('Levels not specified correctly');
end
wavlt=options{2};
if ~ischar(wavlt) || isempty(wavlt)
    error('Wavelet type should be char string');
end
entrp=options{3};
if ~isnumeric(entrp) || isempty(entrp)
    entrp=0;
end
Lmax=wmaxlev(length(X),wavlt);
if(levels> Lmax)
    error('Max levels should be less than %d',Lmax);
end
    
[c,l]=wavedec(X,levels,wavlt);

N=length(l);
Etotal=0;

for i=1:N-1
    E(i)=sum(c(l(i):l(i+1)).^2);
    Etotal=Etotal+E(i);
end
E=E./Etotal;
if(entrp==1)
   Features=-E.*log(E);
elseif (entrp==0)
   Features=E;
else
   error('Not a valid value for selecting entropy or energy');
end
    
