%This is the first script. Running this script will load the training data,
%call a function that will extract 3D GLOH from the training data,
%accumulate the output features from the called function
%(extract_feature.m), prepare labels for the train dataset and train
%classifier model using the labelled dataset.


% load the training data
load training_data

img=5; % This is the image we wish to extract the features it should be between 5 and 46

if img<5 || img>46
    error('The selected frame should be between 5 and 46');
end

% for boxing
BOXING_FEATURES=[];
for i=1:10
    BOXING=train_boxing(:,:,:,i);
    siftPoints=detectSIFTFeatures(BOXING(:,:,img));
    [~, idx] = sort(siftPoints.Metric, 'descend');
    FeaturePointsOut=siftPoints(idx(1:5));

    [Features] = extract_feature(BOXING, img, FeaturePointsOut);
    BOXING_FEATURES=[BOXING_FEATURES;Features];
end



% for clapping
CLAPPING_FEATURES=[];
for i=1:10
    CLAPPING=train_clapping(:,:,:,i);
    siftPoints=detectSIFTFeatures(CLAPPING(:,:,img));
    [~, idx] = sort(siftPoints.Metric, 'descend');
    FeaturePointsOut=siftPoints(idx(1:5));

    [Features] = extract_feature(CLAPPING, img, FeaturePointsOut);
    CLAPPING_FEATURES=[CLAPPING_FEATURES;Features];
end


% for walking
WALKING_FEATURES=[];
for i=1:10
    WALKING=train_walking(:,:,:,i);
    siftPoints=detectSIFTFeatures(WALKING(:,:,img));
    [~, idx] = sort(siftPoints.Metric, 'descend');
    FeaturePointsOut=siftPoints(idx(1:5));

    [Features] = extract_feature(WALKING, img, FeaturePointsOut);
    WALKING_FEATURES=[WALKING_FEATURES;Features];
end

% Now we have all the features of the train dataset we will prepare the
% label (Class) of the training dataset. And this is done by saving the
% labels in a variable called "class" which we will feed to the classifier model
% along with extracted features from the training dataset.

class=["B";"B";"B";"B";"B";"B";"B";"B";"B";"B";"C";"C";"C";"C";"C";"C";"C";"C";"C";"C";"w";"w";"w";"w";"w";"w";"w";"w";"w";"w"];
%class=["BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"BOXING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"CLAPPING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING";"WALKING"];

TRAINING_DATA=[BOXING_FEATURES;CLAPPING_FEATURES;WALKING_FEATURES]; % combine all the extracted features in one variable.
classificationLearner(TRAINING_DATA,class); % train  classifier model.
