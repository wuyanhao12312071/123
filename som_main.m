%% The basic usage of the SOM Toolbox proceeds like this: 
%      1. construct data set
%      2. normalize it (sometimes skip)
%      3. train the map
%      4. visualize map (maybe skip)
%      5. analyse results 
%% 将somtoolbox添加到路径
tic;
% addpath([pwd,'\somtoolbox']);
addpath(genpath('SOM-Toolbox-master'));
%% step 1: construct DATA
D=xlsread([pwd,'\2000.xlsx']);
save D.mat D
E=xlsread([pwd,'\input_250_1_56.xlsx']);  
save E.mat E
% F=xlsread('E:\mflab old\mflab old\SOMtest\validation data.xlsx');
% save F.mat F
sD = som_data_struct(D);% A numerical matrix D can be converted to a data strcut;
sE = som_data_struct(E);
% sF = som_data_struct(F);
%% step 2: DATA Normalization 
% sD = som_normalize(sD,'log');

%% step 3: MAP Training
% sTo = som_topol_struct('data',D); % select default topology based on the data
sM = som_make(sD,'munits',200); % 100 10000 is the desired number of map units
% sTr = som_train_struct(sM,sD); % default training parameters
% sM = som_lininit(sD,sM); % initialize the given map
sM = som_impbatch(sM,sD); % train SOM with default parameters
[qe,te]=som_quality(sM,sD);
sM = som_autolabel(sM,sD);

%% step 4: visualize map (skip)

%% step 5: analysis of results
bmus = som_bmus(sM,sE);
% hits = som_hits(sM,sD); %%hits是指训练数据在每个units上的命中次数，这里默认的units=195，hits就是195个数，这些数之和=训练数据量2000
% bmus = som_bmus(sM,sE);
% D = som_denormalize(D,sD); % denormalize data matrix D
toc;