recomputeBoW = 0; %set this to 1 to recompute BoW

load('kMeans.mat');

addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

if(recomputeBoW == 1)
    BoW = zeros(length(fnames),k);

    % Make bag-of-words for every image

    for i=1:length(fnames)

        fprintf('reading frame %d of %d\n', i, length(fnames));

        % load that file
        fname = [siftdir '/' fnames(i).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        numfeats = size(descriptors,1);

        data_mem_dist = distSqr(descriptors',kMeans');
        [~, category] = min(data_mem_dist,[],2);
        BoW(i,:) = histc(category,1:400);
    end
    save('BoW.mat','BoW');
else
    load('BoW.mat');
end

%using the BoW matrix, find frames that are similar to the input
im1_i = 400;
im2_i = 700;
im3_i = 1700;

M = 5;

getSimilarFrames(im1_i, length(fnames), M);
getSimilarFrames(im2_i, length(fnames), M);
getSimilarFrames(im3_i, length(fnames), M);