function [channels]=ind2chann(filepath,Cind)
%Convert indices to channels

if ~exist(filepath,'file')
    error('Please enter Valid filepath');
end

fid=fopen(filepath);
C=textscan(fid,'%d %s');
fclose(fid);
channels=cell(length(Cind),1);
for i=1:length(Cind)
  channels{i}=C{2}(Cind(i));
end