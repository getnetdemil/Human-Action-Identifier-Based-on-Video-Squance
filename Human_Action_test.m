% This is the test script which load the trained classifier model and the
% test data and give prediction output of the test data using the trained
% classifier model


% load the test data
load test_data

% load the trained model
load action_classifier

img=5; % This is the image we wish to extract the features it should be between 5 and 46
if img<5 || img>46
    error('The selected frame should be between 5 and 46');
end

for i=1:5 % iterate through all the test data
    test=test_data(:,:,:,i);
    
    siftPoints=detectSIFTFeatures(test(:,:,img));
    [~, idx] = sort(siftPoints.Metric, 'descend');
    FeaturePointsOut=siftPoints(idx(1:5));

    [Features] = extract_feature(test, img, FeaturePointsOut);
    
    ypredicted = trainedModel.predictFcn(Features);
    if ypredicted=="B"
        fprintf('Test Sequence %d: BOXING \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("BOXING")
        end
    elseif ypredicted=="C"
        fprintf('Test Sequence %d: CLAPPING \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("CLAPPING")
        end
    elseif ypredicted=="w"
        fprintf('Test Sequence %d: WALKING \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("WALKING")
        end
    end



end




