function getSimilarFrames(im_i, numdata, M)
    load('BoW.mat');
    %using the BoW matrix, find frames that are similar to the input

    imbow = BoW(im_i,:);

    imsim = zeros(numdata,1);

    for i = 1:numdata
        imsim(i,:) = getSimilarity(BoW(i,:), imbow);
    end

    %finding M frames that are most similar
    %the most similar frame is the input frame itself, so look for M+1 frames
    [~, simframes] = maxk(imsim,M+1);

    showSimFrames(simframes(1,:), simframes(2:M+1,:),M);
end