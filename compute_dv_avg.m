function [diff1,mv_avg] = compute_dv_avg(emg_raw_data,no_samples,ws)
diff1 = [0;abs(diff(emg_raw_data,1))];          % compute derivative of raw data
mv_avg = zeros(size(emg_raw_data));             % derivative moving average
for j= 1:no_samples
    kk = j-ws:j+ws;
    k = kk(kk>0 & kk<no_samples);
    mv_avg(j) = sum(diff1(k))/length(k);        % compute moving avaerage on derivative
end
end