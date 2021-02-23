close all;
clear;
clc;
% Specify the input files path.
myFolder = 'C:\Users\Amir Mehmood\Desktop\Fall detection\Fall detection System\walk\';
if ~exist(myFolder,'dir')
    disp('Error: The following folder does not exist');
    return;
end
myResult = 'D:\Results\Sit\mahal\1\';
if ~exist(myResult,'dir')
    mkdir(myResult);
end
%--------------------------------------------------------------------------
ShimmerData = struct();         % create structure

ShimmerData(1).filename = {'Shimmer data 116.xlsx'};
ShimmerData(1).sheet = {'Sheet1'};
ShimmerData(1).xlrange = {'A5:D633'};

ShimmerData(2).filename = {'Shimmer data 118.xlsx'};
ShimmerData(2).sheet = {'Sheet1'};
ShimmerData(2).xlrange = {'A5:D336'};

ShimmerData(3).filename = {'Shimmer data 139.xlsx'};
ShimmerData(3).sheet = {'Sheet1'};
ShimmerData(3).xlrange = {'A5:D294'};

ShimmerData(4).filename = {'Shimmer data 216.xlsx'};
ShimmerData(4).sheet = {'Sheet1'};
ShimmerData(4).xlrange = {'A5:D348'};

ShimmerData(5).filename = {'Shimmer data 262.xlsx'};
ShimmerData(5).sheet = {'Sheet1'};
ShimmerData(5).xlrange = {'A5:D345'};

ShimmerData(6).filename = {'Shimmer data 314.xlsx'};
ShimmerData(6).sheet = {'Sheet1'};
ShimmerData(6).xlrange = {'A5:D342'};

ShimmerData(7).filename = {'Shimmer data 412.xlsx'};
ShimmerData(7).sheet = {'Sheet1'};
ShimmerData(7).xlrange = {'A5:D266'};

ShimmerData(8).filename = {'Shimmer data 415.xlsx'};
ShimmerData(8).sheet = {'Sheet1'};
ShimmerData(8).xlrange = {'A5:D410'};

ShimmerData(9).filename = {'Shimmer data 418.xlsx'};
ShimmerData(9).sheet = {'Sheet1'};
ShimmerData(9).xlrange = {'A5:D490'};

ShimmerData(10).filename = {'Shimmer data 427.xlsx'};
ShimmerData(10).sheet = {'Sheet1'};
ShimmerData(10).xlrange = {'A5:D344'};

ShimmerData(11).filename = {'Shimmer data 430.xlsx'};
ShimmerData(11).sheet = {'Sheet1'};
ShimmerData(11).xlrange = {'A5:D379'};

ShimmerData(12).filename = {'Shimmer data 443.xlsx'};
ShimmerData(12).sheet = {'Sheet1'};
ShimmerData(12).xlrange = {'A5:D521'};

ShimmerData(13).filename = {'Shimmer data 446.xlsx'};
ShimmerData(13).sheet = {'Sheet1'};
ShimmerData(13).xlrange = {'A5:D375'};

% ShimmerData(14).filename = {'Shimmer data 604.xlsx'};
% ShimmerData(14).sheet = {'Sheet1'};
% ShimmerData(14).xlrange = {'A5:D457'};

ShimmerData(14).filename = {'Shimmer data 632.xlsx'};
ShimmerData(14).sheet = {'Sheet1'};
ShimmerData(14).xlrange = {'A5:D365'};

ShimmerData(15).filename = {'Shimmer data 638.xlsx'};
ShimmerData(15).sheet = {'Sheet1'};
ShimmerData(15).xlrange = {'A5:D284'};

ShimmerData(16).filename = {'Shimmer data 641.xlsx'};
ShimmerData(16).sheet = {'Sheet1'};
ShimmerData(16).xlrange = {'A5:D274'};

ShimmerData(17).filename = {'Shimmer data 644.xlsx'};
ShimmerData(17).sheet = {'Sheet1'};
ShimmerData(17).xlrange = {'A5:D276'};

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
ShimmerData(18).filename = {'Shimmer data fall 209_rng128.xlsx'};
ShimmerData(18).sheet = {'Sheet1'};
ShimmerData(18).xlrange = {'A5:D132'};

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
dcol = 2:4;
samplesize = zeros(1,size(ShimmerData,2));
for j=1:size(ShimmerData,2)
    data = xlsread([myFolder,ShimmerData(j).filename{1}],ShimmerData(j).sheet{1},ShimmerData(j).xlrange{1});
    sz = str2double(ShimmerData(j).xlrange{1}(end-2:end));
    ShimmerData(j).data = data(:,dcol);
%     dh = plot(data(:,dcol));
%     xlabel ('No. of Samples');  
%     ylabel ('axis data');
%     title(ShimmerData(j).filename{1}(1:end-5));
%     legend(dh,'X axis','Y axis','Z axis');
%     set (dh(1),'LineStyle','-.','Color','r');
%     set (dh(2),'LineStyle','--','Color','b');
%     set (dh(3),'LineStyle','-','Color','g');
    %----------------------------------------------------------------------
    difx = diff(ShimmerData(j).data(:,1));
    dify = diff(ShimmerData(j).data(:,2));
    difz = diff(ShimmerData(j).data(:,3));
    eudist = sqrt(difx.^2+dify.^2+difz.^2);
    meud = sum(im2col([0,0,eudist',0,0],[1,5],'sliding'))/5;
    h = plot([eudist,meud']);
    xlabel ('Time');  
    ylabel ('Amplitude');
    title(ShimmerData(j).filename{1}(1:end-5));
%     legend(h,'X axis','Y axis','Z axis');
%     set (h(1),'LineStyle','-.','Color','r');
%     set (h(2),'LineStyle','--','Color','b');
%     set (h(3),'LineStyle','-','Color','g');
    %saveas(gcf,[myResult,ShimmerData(j).filename{1}(1:end-5),'.pdf'])

    
    input('next file');
end