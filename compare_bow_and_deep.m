img1_i = 4444;
img2_i = 335;
fnames = dir([siftdir '/*.mat']);

getSimilarFrames(img1_i,length(fnames),10);
showDeepSim(img1_i);
getSimilarFrames(img2_i,length(fnames),10);
showDeepSim(img2_i);

function showDeepSim(img_i)
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    
    fnames = dir([siftdir '/*.mat']);
    
    fname = [siftdir '/' fnames(img_i).name];

    load(fname, 'imname', 'deepFC7');
    origdeep = deepFC7;
    numfeats = length(fnames);

    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    imshow(im)
    pause;
    imsim = zeros(numfeats,1);

    for i = 1:numfeats
        load([siftdir '/' fnames(i).name], 'deepFC7');
        imsim(i,:) = getSimilarity(deepFC7, origdeep);
    end

    M = 10;

    [~, simframes] = maxk(imsim,M+1);

    showSimFrames(img_i, simframes(2:M+1,:),M);
end
