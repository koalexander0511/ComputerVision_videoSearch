function displayWord(wordnum)
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    fnames = dir([siftdir '/*.mat']);

    load('kMeans.mat');
    load('kMeans2.mat');

    member_index = find(membership == wordnum);

    this_orients = all_orients(member_index,:);
    this_positions = all_positions(member_index,:);
    this_scales = all_scales(member_index,:);
    this_imnum = imnum(member_index,:);

    for i = 1:25
        fname = [siftdir '/' fnames(this_imnum(i)).name];
        load(fname, 'imname');
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        [patch] = getPatchFromSIFTParameters(this_positions(i,:), this_scales(i), this_orients(i), rgb2gray(im));
        subplot(5,5,i);
        imshow(patch);
    end
    sgtitle(['Word #', num2str(wordnum)]);
end