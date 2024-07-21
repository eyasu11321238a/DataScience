close all;
clear;

% Folder containing the raw input images
rawFolderPath = 'C:\Users\dolla\OneDrive\Desktop\raw'; % Change this to the directory path of your raw images

% Folder containing the annotated images using GIMP Software
annotatedFolderPath = 'C:\Users\dolla\OneDrive\Desktop\annotated_group'; % Change this to the directory path of your annotated images

% Listing all image files in the raw input images folder
rawImageFiles = dir(fullfile(rawFolderPath, '*.jpg'));

% Folder to store the resulting images, histograms, and thinned images
resultFolderPath = 'C:\Users\dolla\OneDrive\Desktop\results'; % Change this to the directory path where you want to save the results
%mkdir(resultFolderPath);

features = [];
labels = [];
annotationValueArray = [];


for imgIdx = 1:length(rawImageFiles)
   
    rawImageName = fullfile(rawFolderPath, rawImageFiles(imgIdx).name);
    Image1 = imread(rawImageName);

    % Filename for the corresponding annotated image
    [~, baseFilename, ext] = fileparts(rawImageFiles(imgIdx).name);
    annotatedImageName = fullfile(annotatedFolderPath, [baseFilename, '_annotated', ext]);
    annotatedImage = imread(annotatedImageName);

    % image to grayscale
    grayImage = rgb2gray(Image1);

    % adaptive thresholding
    binaryImage = imbinarize(grayImage, 'adaptive', 'ForegroundPolarity', 'dark', 'Sensitivity', 0.49);

    % Filling small holes in the binary image
    binaryImage = imfill(binaryImage, 'holes');

    % Cleaning up the binary image by removing small connected components
    binaryImage = bwareaopen(binaryImage, 100);

    % Inverting the binary mask to make cracks white and no-crack black
    segmentedCracks = ~binaryImage;

    % morphological closing to connect nearby cracks
    se = strel('disk', 3);  % Adjust the disk size as needed
    segmentedCracks = imclose(segmentedCracks, se);

    % morphological opening to remove small isolated points
    se = strel('disk', 2);  % Adjust the disk size as needed
    segmentedCracks = imopen(segmentedCracks, se);

    % morphological thinning to reduce the segmented cracks to lines
    thinnedCracks = bwmorph(segmentedCracks, 'thin', 10);

    % Displaying input raw image
    figure;
    imshow(Image1)
    title(['Original image ', num2str(imgIdx)]);

     % histogram
    histogramFigure = figure;
    imhist(grayImage);
    title(['Original image histogram ', num2str(imgIdx)]);
    
    % Saving the histogram plot to the results folder
    histogramFileName = fullfile(resultFolderPath, ['Histogram_Plot_', num2str(imgIdx), '.png']);
    saveas(histogramFigure, histogramFileName);
    close(histogramFigure);


    % visualising the thinned cracks
    figure;
    imshow(thinnedCracks);
    title(['Thinned Cracks - Image ', num2str(imgIdx)]);


    % Saving the grayscale image to the results folder
    grayImageFileName = fullfile(resultFolderPath, ['Gray_Image_', num2str(imgIdx), '.png']);
    imwrite(grayImage, grayImageFileName);

     % Saving the thinned image to the results folder
    morhologicalImageFileName = fullfile(resultFolderPath, ['Morphological_Image_', num2str(imgIdx), '.png']);
    imwrite(segmentedCracks, morhologicalImageFileName);


    % Saving the thinned image to the results folder
    thinnedImageFileName = fullfile(resultFolderPath, ['Thinned_Image_', num2str(imgIdx), '.png']);
    imwrite(thinnedCracks, thinnedImageFileName);


    % binary mask of the segmented cracks
    binaryMask = segmentedCracks;

    % connected component labeling using bwlabel
    [labelMatrix, numRegions] = bwlabel(binaryMask);

    %Extracting unique labels as regions
    uniqueLabels = unique(labelMatrix);

    

    % Extracting features and assigning labels based on annotated image
    for regionIdx = 1:numRegions
        regionMask = (labelMatrix == uniqueLabels(regionIdx));

        % Calculating region properties using regionprops on regionMask
        % source: https://de.mathworks.com/help/images/ref/regionprops.html
        stats = regionprops(regionMask, 'Area', 'Perimeter', 'Eccentricity'); % Area = number of pixels
        
        % Calculating the label based on the annotated image
        annotationValue = mean(annotatedImage(regionMask));

        if annotationValue > 100
            label = 1; % Crack region
        else
            label = 0; % No-crack region
        end

        % Extracting features from stats and assigning labels
        area = stats.Area;
        perimeter = stats.Perimeter;
        eccentricity = stats.Eccentricity;

        % feature vector for this region
        featureVector = [area, perimeter, eccentricity]; % Add more features here

        % Storing the feature vector and label respectively
        features = [features; featureVector];
        labels = [labels; label];
    end
end

% Calculating crack and non crack region
crackCount = 0;
nonCrackCount = 0;
for i = 1: size(labels)
    if labels(i)== 1
        crackCount= crackCount + 1;
    else 
        nonCrackCount = nonCrackCount + 1;

    end
end

disp(['Number of Crack region: ', num2str(crackCount)]);
disp(['Number of Non Crack region: ', num2str(nonCrackCount)]);

% Spliting the data into training and testing sets
rng(1); % Setting a random seed for reproducibility
numSamples = size(features, 1);
splitRatio = 0.8; % 80% of the data for training, 20% for testing
idx = randperm(numSamples);
splitIdx = round(splitRatio * numSamples);

% Splitting the data
trainFeatures = features(idx(1:splitIdx), :); % Randomizing the training features
testFeatures = features(idx(splitIdx+1:end), :); % Randomizing the test features 

trainLabels = labels(idx(1:splitIdx));
testLabels = labels(idx(splitIdx+1:end));


% Training an SVM and decisionTree classifier
% Source: https://www.mathworks.com/help/stats/fitcsvm.html
svmClassifier = fitcsvm(trainFeatures, trainLabels);
% Source: https://www.mathworks.com/help/stats/fitctree.html
decisionTreeClassifier = fitctree(trainFeatures, trainLabels);


%Predicting labels for test data
predictedLabelsSVM = predict(svmClassifier, testFeatures);
predictedLabelsDTree = predict(decisionTreeClassifier, testFeatures);

% Calculating the crack length
for count=1:size(predictedLabelsSVM)
        if predictedLabelsSVM(count) ==1
           crackLength=testFeatures(count);
           disp(['Crack length of the region is : ', num2str(crackLength), ' pixels']);   
        end
end



% Calculating the classifier's performance
accuracy = sum(predictedLabelsSVM == testLabels) / numel(testLabels);
disp(['Accuracy of SVM Classifier: ', num2str(accuracy * 100), '%']);

accuracy = sum(predictedLabelsDTree == testLabels) / numel(testLabels);
disp(['Accuracy of Decision Tree Classifier: ', num2str(accuracy*100),'%']);




