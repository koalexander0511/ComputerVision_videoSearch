function showSimFrames(original, simframes, M)
    addpath('./provided_code/');
    framesdir = './frames/';
    siftdir = './sift/';

    % Get a list of all the .mat files in that directory.
    % There is one .mat file per image.
    fnames = dir([siftdir '/*.mat']);
    
    fname = [siftdir '/' fnames(original).name];
    load(fname, 'imname');
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    imshow(im);
    title(['Original Frame: ' imname]);
    pause;
    
    for i = 1:M
        clear imname fname;
        fprintf('reading frame %d\n', simframes(i));

        fname = [siftdir '/' fnames(simframes(i)).name];
        load(fname, 'imname');

        % read in the associated image
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        if(M == 5)
            subplot(2,3,i);
        else
            subplot(3,4,i);
        end
        
        imshow(im)
        title(imname);
        sgtitle('Similar Frames');
    end
    pause;
    close;
end
