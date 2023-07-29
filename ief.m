function [IEF] = ief(originalImg,noisyImg,filteredImg)
originalImg =im2double(originalImg); 
noisyImg   =im2double(noisyImg);
filteredImg   =im2double(filteredImg);
IEF = mean(sum(sum((noisyImg-originalImg).^2))./(sum(sum((filteredImg-originalImg).^2))));

end
