function [Cind]= channel2ind(filepath,channelist)
% Convert channel name to channel indices from file channels.txt
% filepath -> path of file '../data_matlab/channels.txt'
% channelist -> list of channels to be used eg. channellist={'Fp1';'Fp2';'T7';'T8'};
%%
%Read channel list and get indices for channels
if ~exist(filepath,'file')
    error('Please enter Valid filepath');
end
%cd '../data_matlab';
%clc
%clear all
%channellist={'Fp1';'Fp2';'T7';'T8'};
%channellist={'all'};
fid=fopen(filepath);
C=textscan(fid,'%d %s');
fclose(fid);
Cind=[];%channel indices
%%
%Collect Channel indices
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