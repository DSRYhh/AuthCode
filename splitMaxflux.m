function img = splitMaxflux(I)

%         i = randi(999);
%         fileindex = i;
%         filename = strcat('dataset\' ,num2str(fileindex),'.jpg');
%         I = imread(filename);
%         I = imbinarize(I);
        I = ~I;
        pixel = sum(I);

        split = zeros(1,3);
        [~,split(1)] = min(pixel(10:20));
        [~,split(2)] = min(pixel(20:30));
        for rangeindex = 2 : 11
            width = (split(2) + 19) - (split(1) + 9);
            if width < 8 || width > 16
                split(2) = nthmin(pixel(20:30), rangeindex + 1);
            else
                break;
            end
        end
        [~,split(3)] = min(pixel(30:40));
        for rangeindex = 2 : 11
            width = split(3) + 29 - (split(2) + 19);
            if width < 8 || width > 16
                split(3) = nthmin(pixel(30:40), rangeindex + 1);
            else
                break;
            end
        end
        split(1) = split(1) + 10 - 1;
        split(2) = split(2) + 20 - 1;
        split(3) = split(3) + 30 - 1;
        split = int16(split);

        I = ~I;
        image = ones(20,80);
        image(:,1:split(1)) = I(:,1:split(1));
        image(:,21:21 + split(2) - split(1)) = I(:,split(1):split(2));
        image(:,41:41 + split(3) - split(2)) = I(:,split(2):split(3));
        image(:,61:61 + 60 - split(3)) = I(:,split(3):60);
        
        img = [reshape(image(:,1:20),1,400);...
            reshape(image(:,21:40),1,400);...
            reshape(image(:,41:60),1,400);...
            reshape(image(:,61:80),1,400);];
%         subplot(1,5,1)
%         imshow(I)
%         subplot(1,5,2)
%         imshow(image(:,1:20))
%         subplot(1,5,3)
%         imshow(image(:,21:40))
%         subplot(1,5,4)
%         imshow(image(:,41:60))
%         subplot(1,5,5)
%         imshow(image(:,61:80))
   
end