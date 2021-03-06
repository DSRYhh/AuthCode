clear;
clc;
%% Load trained parameters
load('weights.mat');

%% Predict

imageindex = randi(100);
filename = strcat('dataset\' ,num2str(imageindex),'.jpg');
I = imread(filename);
I = imbinarize(I);
img = split(I);

[pred, conf] = predict(Theta1, Theta2, img);
fprintf('Image source: %s\n', filename);
fprintf('Predict result: %d %d %d %d\n', ...
    pred(1), pred(2), pred(3), pred(4));
fprintf('Predict confidence: %f %f %f %f\n', ...
    conf(1), conf(2), conf(3), conf(4));

subplot(1,5,1)
imshow(I)
subplot(1,5,2)
imshow(reshape(img(1,:),20,20))
subplot(1,5,3)
imshow(reshape(img(2,:),20,20))
subplot(1,5,4)
imshow(reshape(img(3,:),20,20))
subplot(1,5,5)
imshow(reshape(img(4,:),20,20))
