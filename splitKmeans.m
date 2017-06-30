function img = splitKmeans(I)
    % i = randi(999);
    % fileindex = i;
    % filename = strcat('dataset\' ,num2str(fileindex),'.jpg');
    % I = imread(filename);
    % I = imbinarize(I);

    I = ~I;
        
    itertime = 0;
    bestJ = 10^10;
    for itertime = 1 : 500
        centroid = [10,randi(60);10,randi(60);10,randi(60);10,randi(60)];
        classofpoint = zeros(20,60);
%% Classify
        centerChanged = true;
        while(centerChanged ~= zeros(4,2))
            for i = 1 : 20 %classify
                for j = 1 : 60
                    distance = zeros(4,1);
                    for n = 1 : 4
                        center = centroid(n,:);
                        distance(n) = (abs(i-center(1)))^2 + (abs(j-center(2)))^2;
                    end
                    [~,classofpoint(i,j)] = min(distance);
                end
            end
%% Update centroid
            centroidnew = centroid;
            for n = 1 : 4
                center = centroid(n,:);
                newcenter = [0 0];

                summ = 0;%sum of mass
                for i = 1 : 20
                    for j = 1:60
                        if classofpoint(i,j) == n
                            newcenter(2) = newcenter(2) + j * I(i,j);
                            summ = summ + I(i,j);
                        end
                    end
                end
                newcenter(2) = newcenter(2) / summ;
                centroidnew(n,:) = newcenter;
            end
            centerChanged = centroidnew - centroid;
            centroid = centroidnew;             

        end
%% Campare with the best cost function
        J = 0;
        numofclass = zeros(4,1);
        for i = 1 : 20 %add distance
            for j = 1 : 60
                classofthispoint = classofpoint(i,j);
                center = centroid(n,:);
                distance = (abs(i-center(1)))^2 + (abs(j-center(2)))^2;
                J = J + distance;
                
                numofclass(classofthispoint) = numofclass(classofthispoint) + I(i,j);
            end
        end
        
        numofclass(4) = numofclass(4) - 0;%balance the edge
        J = J + 500 * var(numofclass);
        if J < bestJ
            bestJ = J;
            finalclass = classofpoint;
            % fprintf('J = %f, variance = %f\n',J,var(numofclass));
            % disp(numofclass);
        end
    end
%% Split the image to 4 parts by class    
%     image(I.*finalclass.*10)
    
    image = zeros(20,80);
    offsets = zeros(1,4);
    for n = 1 : 4
        points = zeros(sum(sum(finalclass.*I == n)),2);
        pointindex = 1;
        for i = 1 : 20
            for j = 1 : 60
                if I(i,j) == 1 && finalclass(i,j) == n
                    points(pointindex,:) = [i j];
                    pointindex = pointindex + 1;
                end
            end
        end
        offset = min(points);
        offset = offset(2);
        offsets(n) = offset;
        points(:,2) = points(:,2) - offset;

        offset = (n - 1) * 20 + 1;
        points(:,2) = points(:,2) + offset;
        for p = 1 : size(points,1)
            image(points(p,1),points(p,2)) = 1;
        end
    end
%% Sort the image
    % sort the order of each digit
    for n = 1 : 4
        [~,index] = max(offsets);
        offsets(index) = 0;
        offset = ((5 - n) - 1) * 20 ;
        orioffset = (index - 1) * 20 ;
        for i = 1 : 20
            for j = 1 : 20
                tempimage(i,j+offset) = image(i,j+orioffset);
            end
        end
    end
    image = tempimage;
%% Reshape the image matrix to a vector
    image = ~image;
    img = [reshape(image(:,1:20),1,400);...
            reshape(image(:,21:40),1,400);...
            reshape(image(:,41:60),1,400);...
            reshape(image(:,61:80),1,400);];
%% Show the image
    % image = ~image;
    % subplot(1,5,1)
    % imshow(I)
    % subplot(1,5,2)
    % imshow(image(:,1:20))
    % subplot(1,5,3)
    % imshow(image(:,21:40))
    % subplot(1,5,4)
    % imshow(image(:,41:60))
    % subplot(1,5,5)
    % imshow(image(:,61:80))
end