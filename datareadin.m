clear;

%% Read y
data = xmlread('Tagger\Tagger\Tagger\bin\Debug\data.xml');
xRoot = data.getDocumentElement;
if xRoot.hasChildNodes
    childNodes = xRoot.getElementsByTagName('authcode');
    numChildNodes = childNodes.getLength;
    
    data = int16(zeros(numChildNodes * 4, 1));
    for count = 1:numChildNodes
        thisItem = childNodes.item(count-1);
        attr = thisItem.getAttributes;
        attrnum = attr.getLength;
        
        for i = 1 : attrnum
            thisAttr = attr.item(i - 1);
            name = (thisAttr.getName);
            value = char(thisAttr.getValue);
            if name == 'tag'
                tag = value;                
            elseif name == 'filename'
                filename = value;
            end            
        end
        tag = transpose(tag - '0');
        for j = 1 : length(tag)
            if tag(j) == 0
                tag(j) = 10;
            end
        end
        startIndex = (count - 1) * 4 + 1;
        data(startIndex:startIndex + 3,:) = tag;
    end
end


%% Read x
X = zeros(4*1000,400);
for index = 0 : 999
    filename = strcat('dataset\' ,num2str(index),'.jpg');
    I = imread(filename);
    imgs = split(I);
    startIndex = index * 4 + 1;
    X(startIndex : startIndex + 3,:) = imgs;
end

%% Save to file
save('data.mat','data','X');
