close all;
clear;
clc;
% Specify the input files path.
myFolder = 'C:\Users\Amir Mehmood\Desktop\Fall detection\Fall detection System\Sit\';
if ~exist(myFolder,'dir')
    disp('Error: The following folder does not exist');
    return;
end
myResult = 'D:\Results\Sit\mahal\1\Final\';
if ~exist(myResult,'dir')
    mkdir(myResult);
end
%--------------------------------------------------------------------------
ShimmerData = struct();         % create structure

ShimmerData(1).filename = {'Shimmer data 113.xlsx'};
ShimmerData(1).sheet = {'Sheet1'};
ShimmerData(1).xlrange = {'A5:D396'};

ShimmerData(2).filename = {'Shimmer data 137.xlsx'};
ShimmerData(2).sheet = {'Sheet1'};
ShimmerData(2).xlrange = {'A5:D535'};

ShimmerData(3).filename = {'Shimmer data 214.xlsx'};
ShimmerData(3).sheet = {'Sheet1'};
ShimmerData(3).xlrange = {'A5:D581'};

ShimmerData(4).filename = {'Shimmer data 260.xlsx'};
ShimmerData(4).sheet = {'Sheet1'};
ShimmerData(4).xlrange = {'A5:D630'};

ShimmerData(5).filename = {'Shimmer data 312.xlsx'};
ShimmerData(5).sheet = {'Sheet1'};
ShimmerData(5).xlrange = {'A5:D530'};

ShimmerData(6).filename = {'Shimmer data 401.xlsx'};
ShimmerData(6).sheet = {'Sheet1'};
ShimmerData(6).xlrange = {'A5:D552'};

ShimmerData(7).filename = {'Shimmer data 404.xlsx'};
ShimmerData(7).sheet = {'Sheet1'};
ShimmerData(7).xlrange = {'A5:D822'};

ShimmerData(8).filename = {'Shimmer data 410.xlsx'};
ShimmerData(8).sheet = {'Sheet1'};
ShimmerData(8).xlrange = {'A5:D638'};

ShimmerData(9).filename = {'Shimmer data 413.xlsx'};
ShimmerData(9).sheet = {'Sheet1'};
ShimmerData(9).xlrange = {'A5:D548'};

ShimmerData(10).filename = {'Shimmer data 416.xlsx'};
ShimmerData(10).sheet = {'Sheet1'};
ShimmerData(10).xlrange = {'A5:D1094'};

ShimmerData(11).filename = {'Shimmer data 425.xlsx'};
ShimmerData(11).sheet = {'Sheet1'};
ShimmerData(11).xlrange = {'A5:D578'};

ShimmerData(12).filename = {'Shimmer data 428.xlsx'};
ShimmerData(12).sheet = {'Sheet1'};
ShimmerData(12).xlrange = {'A5:D1207'};

ShimmerData(13).filename = {'Shimmer data 435.xlsx'};
ShimmerData(13).sheet = {'Sheet1'};
ShimmerData(13).xlrange = {'A5:D548'};

% ShimmerData(14).filename = {'Shimmer data 604.xlsx'};
% ShimmerData(14).sheet = {'Sheet1'};
% ShimmerData(14).xlrange = {'A5:D457'};

ShimmerData(14).filename = {'Shimmer data 630.xlsx'};
ShimmerData(14).sheet = {'Sheet1'};
ShimmerData(14).xlrange = {'A5:D410'};

ShimmerData(15).filename = {'Shimmer data 636.xlsx'};
ShimmerData(15).sheet = {'Sheet1'};
ShimmerData(15).xlrange = {'A5:D473'};

ShimmerData(16).filename = {'Shimmer data 639.xlsx'};
ShimmerData(16).sheet = {'Sheet1'};
ShimmerData(16).xlrange = {'A5:D387'};

ShimmerData(17).filename = {'Shimmer data 642.xlsx'};
ShimmerData(17).sheet = {'Sheet1'};
ShimmerData(17).xlrange = {'A5:D634'};

% ShimmerData(19).filename = {'Shimmer data 679.xlsx'};
% ShimmerData(19).sheet = {'Sheet1'};
% ShimmerData(19).xlrange = {'A5:D430'};

% ShimmerData(6).filename = {'Shimmer data 632.xlsx'};
% ShimmerData(6).sheet = {'Sheet1'};
% ShimmerData(6).xlrange = {'A5:D365'};

%-----------------------fall data----------------------------------
% ShimmerData(6).filename = {'Shimmer data fall 167.xlsx'};
% ShimmerData(6).sheet = {'Sheet1'};
% ShimmerData(6).xlrange = {'A5:D157'};
% 
% ShimmerData(7).filename = {'Shimmer data fall 204.xlsx'};
% ShimmerData(7).sheet = {'Sheet1'};
% ShimmerData(7).xlrange = {'A5:D222'};
% 
ShimmerData(18).filename = {'Shimmer data fall 209Rng128.xlsx'};
ShimmerData(18).sheet = {'Sheet1'};
ShimmerData(18).xlrange = {'A5:D132'};

ShimmerData(19).filename = {'Shimmer data 116.xlsx'};
ShimmerData(19).sheet = {'Sheet1'};
ShimmerData(19).xlrange = {'A5:D633'};
% ShimmerData(7).filename = {'Shimmer data fall 209.xlsx'};
% ShimmerData(7).sheet = {'Sheet1'};
% ShimmerData(7).xlrange = {'A12:D51'};
         
% ShimmerData(9).filename = {'Shimmer data fall 210.xlsx'};
% ShimmerData(9).sheet = {'Sheet1'};
% ShimmerData(9).xlrange = {'A5:D188'};

% ShimmerData(9).filename = {'Shimmer data fall 210.xlsx'};
% ShimmerData(9).sheet = {'Sheet1'};
% ShimmerData(9).xlrange = {'A85:D156'};
%-----------------------Walk Combined X------------------------------------
% ShimmerData(1).filename = {'Walk Combined.xlsx'};
% ShimmerData(1).sheet = {'Sheet4'};
% ShimmerData(1).xlrange = {'A5:J138'};
%----------------------------Reference Data--------------------------------

k = 18;
dcol = 2:4;
refdata = xlsread([myFolder,ShimmerData(k).filename{1}],ShimmerData(k).sheet{1},ShimmerData(k).xlrange{1});
fh = plot(refdata(:,dcol));
[xa,ya] = ginput(2);        % use only xa
xa = round(xa);
if mod(length(xa(1):xa(2)),2)==0
    xa(2)=xa(2)+1;
end
rsamplesize = length(xa(1):xa(2));
refdata = refdata(xa(1):xa(2),dcol);
%--------------------------------------------------------------------------
samplesize = zeros(1,size(ShimmerData,2));
for j=1:size(ShimmerData,2)
    data = xlsread([myFolder,ShimmerData(j).filename{1}],ShimmerData(j).sheet{1},ShimmerData(j).xlrange{1});
    sz = str2double(ShimmerData(j).xlrange{1}(end-2:end));
    ShimmerData(j).data = data(:,dcol);
    dh = plot(data(:,dcol));
    xlabel ('No. of Samples');  
    ylabel ('axis data');
    title(ShimmerData(j).filename{1}(1:end-5));
    legend(dh,'X axis','Y axis','Z axis');
    set (dh(1),'LineStyle','-.','Color','r');
    set (dh(2),'LineStyle','--','Color','b');
    set (dh(3),'LineStyle','-','Color','g');
    %----------------------------------------------------------------------
    [xa1,ya1] = ginput(2);        % use only xa
    xa1 = round(xa1);
    samplesize(j) = length(xa1(1):xa1(2));
    tg_pos = floor(samplesize(j)/2);
    matchv = zeros(1,size(data,1));
    s_ind = 1:samplesize(j);
    niter = size(data,1)-numel(s_ind);
    for k=1:niter+1
        sdata = data(s_ind+k-1,dcol);
        md = computemahal(refdata,sdata);
        matchv(k+tg_pos) = exp(-md);
    end
    h = plot(data(tg_pos+1:size(data,1)-tg_pos,dcol));
    xlabel ('No. of Data Samples');  
    ylabel ('Acceleration');
    title(ShimmerData(j).filename{1}(1:end-5));
    legend(h,'X axis','Y axis','Z axis');
    set (h(1),'LineStyle','-.','Color','r');
    set (h(2),'LineStyle','--','Color','b');
    set (h(3),'LineStyle','-','Color','g');
    saveas(gcf,[myResult,ShimmerData(j).filename{1}(1:end-5),'.pdf'])

    plot(matchv(tg_pos+1:size(data,1)-tg_pos));
    axis([1,length(tg_pos:size(data,1)-tg_pos)-1,0,1]);
    xlabel ('No. of Data Samples');  
    ylabel ('Fall Probability');
    title(ShimmerData(j).filename{1}(1:end-5));
    saveas(gcf,[myResult,ShimmerData(j).filename{1}(1:end-5),'-FallProb.pdf'])
    input('next file');
end