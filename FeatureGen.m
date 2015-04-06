function [Features]=FeatureGen(X,Cind,wlen,wshft,Fs,varargin)
%Feature Extraction methods specified by varargin.
% X -> input time series
% Cind -> indices of EEG channels to be used eg. [1 2 3] .generated by
% channel2ind.m
% wlen -> window length for generating features
% wshft -> shift the window by this amount
% Fs -> sampling frequency of X
% varagin -> specifies name value pairs for feature extraction methods
% name value pairs can be any combination of following
%       Name                Value
%       'Fractal'           Higuchi Fractal Dimension 
%                           Value determines kmax for fractal dimesion
%                           Valid Values are numerical : 8,10,11 etc
%                           
%       'HOC'               Higher Order Crossing
%                           Value determines L(number of filters to be applied)
%                           Valid Values are numerical : 5,10 etc
%                           
%       'STAT'              Statistical Features mean,std,first difference,norm first difference, second difference, norm second difference
%                           Valid Values are char string : 'msdefg' -> selects all statistical features
%                           
%       'WavEnt'            Relative Wavelet Entopy
%                           Valid Values are cell array : {5,'db4',1} ->
%                           first value is number of levels , second is
%                           wavelet type and third is to select entropy or
%                           energy
                            
%                           
%       'PowSpec'           Power Spectrum Based Features. Power of specified frequency bins
%                           Valid Values are cell array of frequency bins :
%                           {1,4,7,9,'-',19,22} , '-' means skip the band
%                           9-19 Hz. frequencies should be less than Fs
%       'welch' 
%Features matrix has number of rows= number of epochs, columns as Feature
%vector and 3rd dimension as channels.

%%    
if mod(length(varargin),2)~=0
    error('Name Value pairs not correct.');
end

pnames={'Fractal' 'HOC' 'STAT' 'WavEnt' 'PowSpec'};
dflts= {[],[],[],[],[]};
[frctl,hoc,stat,wvlt,pow]=internal.stats.parseArgs(pnames,dflts,varargin{:});
% load s01.mat
% X=squeeze(data(1,:,:));
% Fs=128;
% wlen=256;
% wshft=64;
% method='F';
%t=2;%2 second epochs
N=size(X,2);%
%T=floor(N/Fs);%total seconds in the data
%if(wshft==0)% no shift, use entire waveform
    
%%
Features=[];
i=0;
count=1;
Y=X(Cind,:);
while i+wlen <= N
    start=i+1;
    finish=i+wlen;
    for j=1:length(Cind)
        Ywin=Y(j,start:finish).*hann(wlen)';
        y=[];
        if ~isempty(frctl)
          y=HFD(Ywin,frctl);
        end
        if ~isempty(hoc)
          y=[y HOC(Ywin,hoc)];
        end
        if ~isempty(stat)
          y=[y STAT(Ywin,stat)];
        end
        if ~isempty(pow)
            [P,Pr]=BinPower(Ywin,Fs,pow);
          y=[y Pr];
        end
        if ~isempty(wvlt)
          y=[y RWE(Ywin,wvlt)];
        end
        
        Features(count,:,j)=y;
       
    end
    i=i+wshft;
    count=count+1;
end

%%



