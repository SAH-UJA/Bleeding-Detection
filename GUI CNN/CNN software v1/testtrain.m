% This code does training, validation and testing on 3295 resized images of size 100x100
% The input parameters are :
% dataset_path : string that contains the absolute path of the images directory 
% labels_path : string that contains the absolute path of labels.txt file
% train_ratio : string that contains the percentage of training data
% valid_ratio : string that contains the percentage of validation data
% test_ratio : string that contains the procedure for selecting testing data

function testtrain(dataset_path,labels_path,train_ratio,valid_ratio,test_ratio)

% creating a local Database or Datastore to accommodate the the images
% fetched from the dataset_path
datasetPath = dataset_path;
imds = imageDatastore(datasetPath);

% reading labels from the labels.txt file and assigning them to
% corresponding images in dataStore
imds.Labels = categorical(load(labels_path));

% Reading an imagge from the datastore and storing the size of img in imgSize
img = readimage(imds,1);
imgSize = size(img);

% calculate number of labels of each class
labelCount = countEachLabel(imds)

% splitting the dataset into training,validation and testing data based on
% the formal params of the testtrain funtion
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,...
    train_ratio,valid_ratio,test_ratio);

% Finding out better parameters for CNN performance
layers = [
    imageInputLayer([imgSize], 'Normalization','none') % Balancing all the images to have the same size for training
    
    % creating a conv layer with filter size=3 and numOfFilters=8 and adding same padding. 
    convolution2dLayer(3,8,'Padding','same')
        
    batchNormalizationLayer % Adding Normalization layer for the previous batch
    reluLayer % relu acts as the activation layer and helps in providing non-linerarity
    maxPooling2dLayer(2,'Stride',2) % Adding a pooling layer with poolSize=2 and pooling method='stride'
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(2) % For binary classification we have 2 outputs bleeding or non-bleeding so outputsize=2
    softmaxLayer % The output unit activation function is the softmax function
    classificationLayer % computes the cross entropy loss for this binary classification problems with mutually exclusive classes
    ];

% Find out better options for CNN performance
% setting the solver_name as 'sgdm' as it gives a better performance while
% the other parameters can be altered as they just control the process of
% training of the CNN i.e. params like InitialLearnRate and
% ValidationFrequency which are displayed onto the dialogbox at the time of
% training as training-progress
options = trainingOptions('sgdm','InitialLearnRate',0.01,'MaxEpochs',2, ...
    'Shuffle','every-epoch','ValidationData',imdsValidation, ...
    'ValidationFrequency',3,'Verbose',false,'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options); % create a neural net with the above made configurations
save net % saving the network after configuring the CNN with set params

YPred = classify(net,imdsValidation); % Predicting the labels of validation data using the trained network
YValidation = imdsValidation.Labels; % Storing the results of prediction of labels in YValidation
Valaccuracy = sum(YPred == YValidation)/numel(YValidation); % Finding the number of cases are predicted correctly

YPred = classify(net,imdsTest); % Predicting the labels of testing data using the trained network
YTest = imdsTest.Labels; % Storing the results of prediction of labels in YTest
Testaccuracy = sum(YPred == YTest)/numel(YTest); % Finding the number of cases are predicted correctly

% displaying validation and testing accuracy onto the console
disp('Validation accuracy'); 
disp(Valaccuracy);
disp('Testing accuracy'); 
disp(Testaccuracy);
%%
% Performance Metrics
clc % clears the console window

ACTUAL = double(YTest); 
PREDICTED = double(YPred);

% calculation metrics parameters
idx = (ACTUAL()==1);
p = length(ACTUAL(idx)); % finding number of positives
n = length(ACTUAL(~idx));   % finding number of negatives
N = p+n; % finding total number of positives and negatives
tp = sum(ACTUAL(idx)==PREDICTED(idx)); % finding true positives   
tn = sum(ACTUAL(~idx)==PREDICTED(~idx)); % finding true negatives  
fp = n-tn; % finding false positives   
fn = p-tp; % finding false negatives
%%
% Analyzing Accuracy,Sensitivity,Specificity,Precision,Recall,F1 from the
% confusion metrics params calculated

Accuracy =  (tp+tn)/(tp+fp+fn+tn);
Sensitivity = tp/(tp+fn);
Specificity = tn/(tn+fp);
Precision = tp/(tp+fp);
Recall = tp/(tp+fn);
F1 = (2*Recall*Precision)/(Recall+Precision);

%%
% sending analysis to the third_gui to display onto the console
third_gui(Accuracy*100,Sensitivity*100,Specificity*100,...
    Precision*100,Recall*100,F1*100)
end
