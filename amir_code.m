close;
clear;
clc;
fs = 500;           % sampling frequency: 500 Hz
wt = 0.1;          % window size in miliseconds: 50ms;
ws = round(fs*wt);  % window size in terms of no of samples: 50 samples

%emg_raw_data=csvread('C:\Users\Lab 2\Desktop\EMG Data\AbrarShimmerDataWalk.csv',4,22,[4,22,6003,22]);
emg_raw_data=csvread('C:\Users\Lab 2\Desktop\EMG Data\AbrarShimmerDataWalk.csv',4,21,[4,21,6003,21]);
rect_emg = abs(emg_raw_data);
% hold on
% plot(emg_raw_data);
% hold on
% mean_avg = MAV(rect_emg);
% % mov_avg = MAVS(mean_avg);
% plot(mean_avg);
% hold on
% plot(rect_emg);
%return
%y = highpass(emg_raw_data,20,fs);
diff1 = [0;abs(diff(emg_raw_data,1))];
mv_avg = zeros(size(rect_emg));
no_samples = length(rect_emg);              % total no of samples in data
for j= 1:no_samples
    kk = j-ws:j+ws;
    k = kk(kk>0 & kk<no_samples);
    mv_avg(j) = sum(diff1(k))/length(k);
end
fast_four = abs(fft(emg_raw_data)/2);
% y = rms(rect_emg,2)
plot(rect_emg);
hold on 
%plot(fast_four);
%hold on
%plot (y);
plot (emg_raw_data);
%plot(mv_avg);

return


burst_width = mv_avg>1200;
if (burst_width(1)>0)
    onoff = [1;diff(burst_width,1)];
else
    onoff = [0;diff(burst_width,1)];
end
figure, plot([diff1,burst_width*20000]);
figure, plot([emg_raw_data,burst_width*60000]);
return
indx = 1:no_samples;
on_indices = indx(onoff>0);
off_indices = indx(onoff<0);

lf2hf_ratio = zeros(1,length(off_indices));
fmn = zeros(1,length(off_indices));
fmd = zeros(1,length(off_indices));

for j = 1:length(off_indices)
    pw = off_indices(j)-on_indices(j);
    if pw>20
        NFFT = 2^nextpow2(pw);  % Next power of 2 from length of y
        temp = rect_emg(on_indices(j):off_indices(j));
        
        Fy = abs(fft(temp,NFFT)/pw);
        lf2hf_ratio(j) = min(Fy)/max(Fy);
        
        [Pxx, W] = pwelch(temp);
        fmn(j) = (sum(W.*Pxx))/(sum(Pxx));
        fmd(j) = (1/2)*sum(Pxx);
        plot(Fy(1:NFFT/2+1));drawnow;pause(1);
        plot(Pxx);drawnow;pause(1);
        disp('yes');
    else
        disp('no');
    end
end
%figure, plot(lf2hf_ratio);



return


%y = fft(aa);
% yy = bin_emg(y);
% fast_four = abs(fft(aa)/2);
% fr = FR(yy); plot(y);
% mav = MAV(yy);
% %plot(mav);
% fmn = FMN(yy);
% fmd = FMD (yy); %plot(fmd)
% mfmd = MFMD(yy);
aabb = emgonoff(aa, 500);
plot(aa);
hold on
plot(aabb(1),60000,'.');
plot(aabb(2),60000,'.');
hold off
return
%emgonof = emgonoff(yy);
% iemg = IEMG(yy);
%plot(iemg);
%[y,fs] = size(aa);
% bb=aa(:,2); plot(bb);
% [y,fs] = wavread2('C:\Users\Lab 2\Desktop\EMGAT2014\EMGAT2014\130708_231609_cut.wav');
%plot(fast_four);
% y=fft(bb);
% z=abs(y);
% L=floor(length(z)/2);
% 
% % plot(z1(1:100),z(1:100))
% % plot(z1(1:50),z(z1(1:50)))
% figure, plot(z(1:L));
% figure, plot(z);