close all;
clear;
clc;

fs = 500;           % sampling frequency: 500 Hz
wt = 0.1;          % window size in miliseconds: 50ms;
ws = round(fs*wt);  % window size in terms of no of samples: 50 samples

emg_raw_data=csvread('C:\Users\Lab 2\Desktop\EMG Data\ammi abbu data\ShimmerDatasaadqa-swalk.csv',4,10,[4,10,7800,10]);
emg_raw_data2=csvread('C:\Users\Lab 2\Desktop\EMG Data\ammi abbu data\ShimmerDatasaadqa-swalk.csv',4,12,[4,12,7800,12]);
%emg_raw_data=csvread('C:\Users\Lab 2\Desktop\EMG Data\AbrarShimmerDataWalk.csv',4,24,[4,24,6003,24]);
%emg_raw_data2=csvread('C:\Users\Lab 2\Desktop\EMG Data\AbrarShimmerDataWalk.csv',4,22,[4,22,6003,22]);
%emg_raw_data=csvread('C:\Users\Amir\OneDrive\EMG Data\AbrarShimmerDataWalk.csv',4,24,[4,24,6003,24]);
%emg_raw_data2=csvread('C:\Users\Amir\OneDrive\EMG Data\AbrarShimmerDataWalk.csv',4,22,[4,22,6003,22]);
% figure 
% subplot(2,1,1);
% plot(emg_raw_data)
% title('EMG Data of Gastrocnemius Muscle ')
%     xlabel('Nos. of Samples')
%     ylabel('Amplitude (mv)')
% subplot(2,1,2);
% plot(emg_raw_data2)
% title('EMG Data of Tibialis Muscle ')
%     xlabel('Nos. of Samples')
%     ylabel('Amplitude (mv)')

%  psd=(1/2)*sum(pwelch(emg_raw_data2));
%  plot(psd);
return;
%plot (emg_raw_data); return
no_samples = length(emg_raw_data);              % total no of samples in data
diff1 = [0;abs(diff(emg_raw_data,1))];
mv_avg = zeros(size(emg_raw_data));

for j= 1:no_samples
    kk = j-ws:j+ws;
    k = kk(kk>0 & kk<no_samples);
    mv_avg(j) = sum(diff1(k))/length(k);
    psd (j,1)=(1/2)*sum(pwelch(emg_raw_data2));
 end
 figure, plot(psd);return

sz_fltr = 15;
thresh_mav = 0.05;      % 0.02,1000
bursts = mv_avg>thresh_mav;
bursts1 = bursts;
for j= 1:no_samples
    kk = j-sz_fltr:j+sz_fltr;
    k = kk(kk>0 & kk<no_samples);
    bursts1(j) = max(bursts(k));        %dilate
end
for j= 1:no_samples
    kk = j-sz_fltr:j+sz_fltr;
    k = kk(kk>0 & kk<no_samples);
    bursts(j) = min(bursts1(k));        %erode
end

if bursts(1)>0
    onoffs = [1;diff(bursts,1)];
else
    onoffs = [0;diff(bursts,1)];
end
if bursts(end)>0
    onoffs(end) = -1;
end

on_off_time = zeros(100,2);
i=1;
ii = 0;
for j= 1:no_samples
    if onoffs(j)>0
        on_off_time(i,1)=j;
        ii = ii + 1;
    end
    if onoffs(j)<0
        on_off_time(i,2)=j;
        i = i+1;
    end
end

ii = 1:no_samples;
on_off_time(ii(sum(on_off_time,2)==0),:) = [];

%  max_thr = max(diff1)/2; %////////////
%  figure, plot([diff1,mv_avg,bursts*max_thr,ones(no_samples,1)*thresh_mav]);%return  %////////////
%  figure,plot([emg_raw_data,emg_raw_data.*bursts]); return %////////////////////

med_freq = zeros(size(on_off_time,1),2);
for j=1:size(on_off_time,1)
    temp = emg_raw_data(on_off_time(j,1):on_off_time(j,2));
    %plot(temp);pause(1);
    med_freq(j,1) = (1/2)*sum(pwelch(temp));
    [Pxx, W] = pwelch(temp);
    med_freq(j,2) = (sum(W.*Pxx))/(sum(Pxx));
    
    Y = abs(fft(temp));
    L = length(temp);
    Y1 = Y(1:L/2+1);
    f = fs*(0:L/2)/L;
    plot(f,Y1); 
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|Y1(f)|')
    pause(2);   
end
figure,plot(med_freq);