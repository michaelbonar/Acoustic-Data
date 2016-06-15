%Program for Acoustic Analysis
clear all;
%close all;
clc;

d = date;
filename=sprintf('Experimental Data/%s/slightly more loosened foam1 with fork in back in mount', d); %must change to file that you want to load from
filename_excel=sprintf('Experimental Data/%s/slightly more loosened foam1 with fork in back mics in blue mount.xlsx', d); %must change to file that you want to save to
sheet = 3;
mic_status = 1;

[s,m1, m2] = mkdir(sprintf('Experimental Data/%s', d));
if mic_status == 1
     excelClear(filename_excel, sheet);
end

datain = load(filename);
datain = datain.dataout;

channels=[1,3];%what channels to take from
s=size(channels,2);%number of channels being called
correction=[0.0613, 0.0627];%correction factors for mics 1,2

dataout = zeros(length(datain), 12); 

fcount = size(datain);
for x = 1:fcount(1)

    pos = x;
    freq = datain{x,1};
    time = datain{x,2};
    volts = datain{x,3};

    fs=1/(time(2,1)-time(1,1));
    for i=1:s
        p(:,i)=volts(:,i)./correction(i);%turn voltage into pressure
    end
    %
    fourier = fft(p);
    %plot(abs(fourier))
    
    %% Analysis and Decomposition of Reflection
    [dataout(x,:), HI(x, 1), HR(x, 1)] = decomp(fourier, mic_status, filename, sheet, freq, pos); 
    %[f S11 S12 S21 S22 PiPiC PrPrC PtPtC R T H12r H12i] 
end

%% Save data for use in transmission run
if mic_status == 1
    H12 = dataout(:,11)+dataout(:,12)*i;
    save('Transmission Data', 'H12', 'HI', 'HR')
end

%% Write to Excel
excelwritedecomp(filename_excel, sheet, dataout, mic_status)