function [Power,PowerRatio]=BinPower(X,Fs,Band)
% X-> Time series
% Band -> Frequency Bands for power calculation
%         boundary frequencies (in Hz) of bins. They can be unequal bins, e.g. 
%		  {0.5,4,7,12,30} which are delta, theta, alpha and beta respectively. 
%         If there is a break in the bands than put a '-'
%         {1,2,3,'-',9,12,'-',1,5} ->> This will find power in ranges 1-2 2-3 9-12 1-5
%         Each element of Band is a physical frequency and shall not exceed the 
%		  Nyquist frequency, i.e., half of sampling frequency. 
% Fs   -> Sampling frequency
Lv=2^nextpow2(length(X));
C=abs(fft(X,Lv));
if(length(Band)==2)
      Band{end+1}='-';
end
%Power = zeros(length(Band),1);
%PowerRatio=Power;
P_Index=1;
for Freq_Index=1:length(Band)-1
    if Band{Freq_Index} == '-'
          continue;
    elseif Band{Freq_Index+1} == '-'
          continue
    end
	Freq = Band{Freq_Index};										
	Next_Freq = Band{Freq_Index+1};
	Power(P_Index) = sum(C(floor(Freq/Fs*Lv):floor(Next_Freq/Fs*Lv)));
    P_Index=P_Index+1;
end	
PowerRatio = Power/sum(Power);
		
