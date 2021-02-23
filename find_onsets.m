function [on_sets,bursts,raw_burst] = find_onsets(mv_avg,no_samples,sz_fltr,thresh_mav)
bursts = mv_avg>thresh_mav;
raw_burst = bursts;

% morphological close (to remove black noise)
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

% morphological open  (to remove white noise)
bursts1 = bursts;
for j= 1:no_samples
    kk = j-sz_fltr:j+sz_fltr;
    k = kk(kk>0 & kk<no_samples);
    bursts1(j) = min(bursts(k));        %erode
end
for j= 1:no_samples
    kk = j-sz_fltr:j+sz_fltr;
    k = kk(kk>0 & kk<no_samples);
    bursts(j) = max(bursts1(k));        %dilate
end

% detrmine onset end points
if bursts(1)>0
    onoffs = [1;diff(bursts,1)];
else
    onoffs = [0;diff(bursts,1)];
end
if bursts(end)>0
    onoffs(end) = -1;
end

on_sets = zeros(100,2);
i=1;
ii = 0;
for j= 1:no_samples
    if onoffs(j)>0
        on_sets(i,1)=j;
        ii = ii + 1;
    end
    if onoffs(j)<0
        on_sets(i,2)=j;
        i = i+1;
    end
end

ii = 1:no_samples;
on_sets(ii(sum(on_sets,2)==0),:) = [];      % ONSET and OFFSET obtained
end