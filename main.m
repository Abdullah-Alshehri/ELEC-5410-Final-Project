% Main function to process the data and evaluate the classifier
function accuracy = main()
    % Load the data
    load('data.mat'); 

    % Extract aggregated connectivity features for each class
    features_class0 = extract_aggregated_connectivity_features(data_class0);
    features_class1 = extract_aggregated_connectivity_features(data_class1);
    features_class2 = extract_aggregated_connectivity_features(data_class2);

    % Combine features and labels
    features = [features_class0; features_class1; features_class2];
    labels = [zeros(size(features_class0, 1), 1); % Label 0 for class 0
              ones(size(features_class1, 1), 1);  % Label 1 for class 1
              2 * ones(size(features_class2, 1), 1)]; % Label 2 for class 2

    % Split data into training and testing sets
    cv = cvpartition(size(features, 1), 'HoldOut', 0.2); % Hold out 20% of the data for testing
    idx = cv.test;
    X_train = features(~idx, :);
    Y_train = labels(~idx, :);
    X_test = features(idx, :);
    Y_test = labels(idx, :);

    % Train a multiclass model using fitcecoc
    SVMModel = fitcecoc(X_train, Y_train);

    % Test the classifier and calculate accuracy
    predictions = predict(SVMModel, X_test);
    accuracy = sum(Y_test == predictions) / length(Y_test);
    % Convert accuracy to percentage
    accuracy_percentage = accuracy * 100;

% Display the accuracy
fprintf('Accuracy: %.2f%%\n', accuracy_percentage);
end

% Function to extract aggregated connectivity features for individual class
function features = extract_aggregated_connectivity_features(data_class)
    num_signals = numel(data_class);
    features = zeros(num_signals, 2); % 2 for mean and variance

    for i = 1:num_signals
        signal_matrix = data_class{i};
        connectivity_matrix = corr(signal_matrix');

        % Aggregate features
        mean_val = mean(connectivity_matrix, 'all');
        var_val = var(connectivity_matrix, 1, 'all');

        features(i, :) = [mean_val, var_val];
    end
end
