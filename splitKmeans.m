% function img = splitKmeans(I)
    i = randi(999);
    fileindex = i;
    filename = strcat('dataset\' ,num2str(fileindex),'.jpg');
    I = imread(filename);
    I = imbinarize(I);

    imshow(I);

    I = ~I;
    % I = reshape(I,[1 size(I,1)*size(I,2)]);%vectorize I
    centroid = [10,7;10,22;10,37;10,52];
    classofpoint = zeros(20,60);

    for i = 1 : 20 %classify
        for j = 1 : 60
            distance = zeros(4);
            for n = 1 : 4
                center = centroid(n,:);
                distance(n) = (abs(i-center(1)))^2 + (abs(j-center(2)))^2;
            end
            [~,classofpoint(i,j)] = max(distance);
        end
    end

    for n = 1 : 4
        
    end
% end