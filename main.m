i = randi(999);
% for i = 1 : 8
    fileindex = i;
    filename = strcat(num2str(fileindex),'.jpg');
    I = imread(filename);
    I = imbinarize(I);
    I = ~I;
    pixel = sum(I);
%     subplot(4,2,i)
%     plot(pixel) 
%     hold on
%     plot(4 * ones(60)) 
%     hold off
%     title(filename)
    
    split = zeros(1,4);
    [~,split(1)] = min(pixel(10:20));
    [~,split(2)] = min(pixel(20:30));
    [~,split(3)] = min(pixel(30:40));
    split(4) = fileindex;
    split(1) = split(1) + 10 - 1;
    split(2) = split(2) + 20 - 1;
    split(3) = split(3) + 30 - 1;
    split = int16(split);
    
    I = ~I;
    subplot(1,5,1)
    imshow(I)
    subplot(1,5,2)
    imshow(I(:,1:split(1)))
    subplot(1,5,3)
    imshow(I(:,split(1):split(2)))
    subplot(1,5,4)
    imshow(I(:,split(2):split(3)))
    subplot(1,5,5)
    imshow(I(:,split(3):60))
    
% end