function [S,w,b] = train_csp(EEG,Fs,mrk,wnd,f,nof,n,TrainSet)
% Train a CSP+LDA classifier
% [S,w,b] = train_csp(RawSignal, SampleRate, Markers, EpochWnd, SpectralFlt, FltNumber, FltLength)
%
% In:
%   RawSignal : raw data array [#samples x #channels]
%
%   SampleRate : sampling rate of the data, in Hz
%
%   Markers : marker channel (0 = no marker, 1 = first class, 2 = second class)
%
%   EpochWnd : time range of the epochs to extract relative to the marker
%              in seconds ([begin, end]), e.g. [0.5 3.5]
%
%   SpectralFlt : spectral filter specfication; this is a function of Frequency in Hz
%                 (e.g., f = @(x)x>7&x<30)
%
%   FltNumber : number of spatial filters pairs to compute (e.g., 3)
%
%   FltLength : length of the temporal filter, in samples (e.g., 200)
%   
%   TrainSet : Indices of Training Set     
% Out:
%   S : spatial filter matrix [#channels x #filters]
%

%
%   w : linear classifier weights
%
%   b : linear classifier bias


% do frequency filtering using FFT
[t,c] = size(EEG); 
FLT=[];
for sam=1:floor(t/n)
  FLT = [FLT;real(ifft(fft(EEG(((sam-1)*n)+1:sam*n,:)).*repmat(f(Fs*(0:n-1/n)',1,c))))];
end

% extract data for all epochs of the first class concatenated (EPO{1}) and 
% all epochs of the second class concatenated (EPO{2})
% each array is [#samples x #channels]
wnd = round(Fs*wnd(1)) : round(Fs*wnd(2));

for k = 1:2
    EPO{k} = FLT(repmat(find(mrk==k),length(wnd),1) + repmat(wnd',1,nnz(mrk==k)),:);
end

% calculate the spatial filter matrix S using CSP (TODO: fill in)
[V,D] = eig(cov(EPO{1}),cov(EPO{1})+cov(EPO{2}));
S = V(:,[1:nof end-nof+1:end]);

% log-variance feature extraction
for k = 1:2
    X{k} = squeeze(log(var(reshape(EPO{k}*S, length(wnd),[],2*nof))));
end

% train LDA classifier (preferably with gradual outputs) (TODO: fill in)
mu1 = mean(X{1});
mu2 = mean(X{2});
w = ((mu2-mu1)/(cov(X{1})+cov(X{2})))';
w = w/(norm(mu2-mu1)^2);
b = (mu1+mu2)*w/2;
