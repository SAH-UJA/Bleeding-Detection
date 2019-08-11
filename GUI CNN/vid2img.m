% Convert video to images at the rate of 24 images per second
clc
workingDir = 'C:\Users\fiosin\Downloads\GUIcode\vid2img\';%path of the file;
mkdir(workingDir)
mkdir(workingDir,'images')
%%
myVideo = VideoReader('video.mpeg');

i = 1;
while hasFrame(myVideo)
   img = readFrame(myVideo);
   filename = [sprintf('%03d',i) '.jpg'];
   fullname = fullfile(workingDir,'images',filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   i = i+1;
end
%%
% snapshots of images
digitDatasetPath = fullfile('C:\Users\fiosin\Desktop\Data\WCE\copy - GUI code\vid2img\images');
imds = imageDatastore(digitDatasetPath);

figure; jump=7;
%N=30;R=6;
%perm = randperm(233,N);
perm = 1:jump:230
for i = 1:230/jump
    subplot(R,N/R,i);
    imshow(imds.Files{perm(i)});
end

%%
% Reduce color palette to 24
rgb = imread('realstamps.png');
%[x,map] = rgb2ind(RGB, 0.1);
[X_no_dither,map] = rgb2ind(rgb,24,'nodither');
imshow(X_no_dither,map)

