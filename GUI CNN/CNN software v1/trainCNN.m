function testCNN(dataset_path,labels_path,train_ratio,valid_ratio,test_ratio)

datasetPath = dataset_path;
imds = imageDatastore(datasetPath);
imds.Labels = categorical(load(labels_path));
img = readimage(imds,1);
imgSize = size(img);
labelCount = countEachLabel(imds)

[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,...
    train_ratio,valid_ratio,test_ratio);

fprintf('Training Instances = %d\n',train_ratio*sum(labelCount.Count));
fprintf('Validation Instances = %d\n',valid_ratio*sum(labelCount.Count));
fprintf('Testing Instances = %d\n',test_ratio*sum(labelCount.Count));

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

options = trainingOptions('sgdm','InitialLearnRate',0.01,'MaxEpochs',10, ...
    'Shuffle','every-epoch','ValidationData',imdsValidation, ...
    'ValidationFrequency',3,'Verbose',false,'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options); 
answer = questdlg('Training Completed. Save the model?','Yes','No');
switch answer
    case 'Yes'
        save net;  waitfor(msgbox({'Model Saved as net.mat'}));
    case 'No'
end

PREDICTED = double(classify(net,imdsValidation)); 
ACTUAL = double(imdsValidation.Labels); 
[Accuracy, Sensitivity, Specificity, Precision, Recall, F1] = calculateMetrics(net, ACTUAL, PREDICTED);
% sending analysis to the third_gui to display onto the console
third_gui(Accuracy*100,Sensitivity*100,Specificity*100,Precision*100,Recall*100,F1*100,'Validation')
waitfor(msgbox({'Press OK for testing results?'}));

PREDICTED = double(classify(net,imdsTest)); 
YTest = double(imdsTest.Labels); 
[Accuracy, Sensitivity, Specificity, Precision, Recall, F1] = calculateMetrics(net, ACTUAL, PREDICTED);
% sending analysis to the third_gui to display onto the console
third_gui(Accuracy*100,Sensitivity*100,Specificity*100,Precision*100,Recall*100,F1*100,'Testing')

waitfor(msgbox({'Press OK to close all windows'})); close all;

end

 
