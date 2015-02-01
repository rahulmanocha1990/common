function [Features]=FeatureGen(X,channelist,method,Fs,wlen,wshft)
%Feature Extraction using method specified.
%specify channel,window length,overlap,feature extraction method,
%method can be any combination of following
     % 'F' Higuchi Fractal Dimension
     % 'H' Higher Order Crossing
     % 'P' Power spectrum Based Features

%%
%Read channel list and get indices for channels
cd '../data_matlab';
%clc
%clear all
%channellist={'Fp1';'Fp2';'T7';'T8'};
%channellist={'all'};
fid=fopen('channels.txt');
C=textscan(fid,'%d %s');
fclose(fid);
Cind=[];%channel indices
%%
if(isequal(channelist{1},'all'))
    Cind=1:32;
else
for i=1:size(C{1},1)
    for j=1:length(channelist)
        if(isequal(char(C{2}(i)),char(channelist{j})))
            Cind(end+1)=C{1}(i);
        end
    end
end
end
%%    
%generate feature from each 2second data epoch
% load s01.mat
% X=squeeze(data(1,:,:));
% Fs=128;
% wlen=256;
% wshft=64;
% method='F';
%t=2;%2 second epochs
N=size(X,2);%
%T=floor(N/Fs);%total seconds in the data

%%
cd '../common'
Features=[];
i=0;
count=1;
Y=X(Cind,:);
while i+wlen < N
    start=i+1;
    finish=i+wlen;
    for j=1:length(Cind)
        Ywin=Y(j,start:finish).*hann(wlen)';
        if any (method=='F')
          %y=HFD(Ywin,floor(Fs/32));
          y=HFD(Ywin,8);
        end
        if any (method=='H')
          y=[y HFD(Ywin,floor(Fs/2))];
        end
        
        
        Features(count,:,j)=y;
        y=[];
    end
    i=i+wshft;
    count=count+1;
end

%%



