% function img = splitKmeans(I)
    i = randi(999);
    fileindex = i;
    filename = strcat('dataset\' ,num2str(fileindex),'.jpg');
    I = imread(filename);
    I = imbinarize(I);

%     imshow(I);

    I = ~I;
    
    itertime = 0;
    bestJ = 10^10;
    for itertime = 1 : 500
        fprintf('iter: %d\n',itertime);
    %     centroid = [10,7;10,22;10,37;10,52];    
%         centroid = [randi(20),randi(60);randi(20),randi(60);randi(20),randi(60);randi(20),randi(60)];
        centroid = [10,randi(60);10,randi(60);10,randi(60);10,randi(60)];
        classofpoint = zeros(20,60);

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

            centroidnew = centroid;
            for n = 1 : 4
                center = centroid(n,:);
                newcenter = [0 0];

                summ = 0;%sum of mass
                for i = 1 : 20
                    for j = 1:60
                        if classofpoint(i,j) == n

%                             newcenter(1) = newcenter(1) + i * I(i,j); 
                            newcenter(2) = newcenter(2) + j * I(i,j);
                            summ = summ + I(i,j);
                        end
                    end
                end
%                 newcenter(1) = newcenter(1) / summ;
                newcenter(2) = newcenter(2) / summ;
                centroidnew(n,:) = newcenter;
            end
            centerChanged = centroidnew - centroid;
            centroid = centroidnew;             

        end

        J = 0;
        for i = 1 : 20
            for j = 1 : 60
                classofthispoint = classofpoint(i,j);
                center = centroid(n,:);
                distance = (abs(i-center(1)))^2 + (abs(j-center(2)))^2;
                J = J + distance;
            end
        end
        if J < bestJ
            bestJ = J;
            finalclass = classofpoint;
            fprintf('J = %f\n',J);
        end
    end
    
    image(I.*finalclass.*10)
    
% end