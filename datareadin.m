clear;
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
        startIndex = (count - 1) * 4 + 1;
        data(startIndex:startIndex + 3,:) = tag;
    end
end

save('Y.mat','data');