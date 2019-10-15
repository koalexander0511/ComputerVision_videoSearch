recomputeVocab = 0; %change this to 1 to update kMeans

addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

NUMFRAMES = 300;
k = 400;

if(recomputeVocab == 1)
    increment = round(length(fnames)/NUMFRAMES);
    SIFTdata = [];
    all_orients = [];
    all_positions = [];
    all_scales = [];
    imnum = [];


    for i = 1:increment:length(fnames)
        fprintf('reading frame %d of %d\n', i, length(fnames));

        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        numfeats = size(descriptors,1);

        SIFTdata = [SIFTdata; descriptors];
        all_orients = [all_orients; orients];
        all_positions = [all_positions; positions];
        all_scales = [all_scales; scales];
        imnum = [imnum; i*ones(numfeats,1)];
    end

    [membership,means,rms] = kmeansML(k,SIFTdata');
    kMeans = means';
    save('kMeans.mat','kMeans');
    save('kMeans2.mat','SIFTdata','all_orients','all_positions', 'all_scales', 'imnum');
else
    load('kMeans.mat');
    load('kMeans2.mat');
end

word1 = 150;
word2 = 250;

displayWord(word1);
pause;
displayWord(word2);
pause;
close;