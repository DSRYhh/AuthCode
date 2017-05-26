I = imread('0.jpg');
I = imbinarize(I);
I = ~I;
pixel = sum(I);
plot(pixel)

