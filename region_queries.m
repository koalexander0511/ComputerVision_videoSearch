%disp_region_queries(900);
%disp_region_queries(1200);
%disp_region_queries(2200);
disp_region_queries(3000);

function disp_region_queries(img_i)
    load('BoW');
    load('kMeans.mat');
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';
    fnames = dir([siftdir '/*.mat']);

    fname = [siftdir '/' fnames(img_i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);


    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);

    oninds = selectRegion(im, positions);
    title('Original Image');
    figure;
    
    data_mem_dist = distSqr(descriptors(oninds,:)',kMeans');
    [~, category] = min(data_mem_dist,[],2);
    regionbow = histc(category,1:400);

    regionsim = zeros(length(fnames),1);


    for i = 1:length(fnames)
        regionsim(i,:) = getSimilarity(BoW(i,:), regionbow);
    end

    M = 5;

    %finding M frames that are most similar
    %the most similar frame is the input frame itself, so look for M+1 frames
    [~, simframes] = maxk(regionsim,M+1)

    simind = find(simframes ~= img_i)
    simframes = simframes(simind)
    
    showSimFrames(img_i,simframes(1:M),M);
end

