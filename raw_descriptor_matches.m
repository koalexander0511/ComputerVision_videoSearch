load('./provided_code/twoFrameData.mat');
addpath('./provided_code/');

%Taken from selectRegion.m
imshow(im1);

h = impoly(gca, []);
polypos = getPosition(h);
api = iptgetapi(h);
nextpos = api.getPosition();

ptsin = inpolygon(positions1(:,1), positions1(:,2), nextpos(:,1), nextpos(:,2));
oninds = find(ptsin==1); % these are the indices into the SIFT desc and positions that fall within the polygon region

clear h api nextpos ptsin
close;

%showing the selected polygon region with image 1
imshow(im1);
poly = drawpolygon('position',polypos);
poly.Color = 'yellow';
poly.InteractionsAllowed = 'none';
title('Selected Region');
fprintf('Press any key to continue\n');
pause;
close;
clear polypos poly

%calculating distances for each SIFT point in selected region
distmatrix = distSqr(descriptors1(oninds,:)', descriptors2');
[minval, minindex] = min(distmatrix, [], 2);
threshold = 0.3;
threshval = find(minval < threshold);
threshindex = minindex(threshval);
imshow(im2);
displaySIFTPatches(positions2(threshindex,:), scales2(threshindex), orients2(threshindex), im2);
title('Matched SIFT patches');
fprintf('Press any key to continue\n');
pause;
close;




