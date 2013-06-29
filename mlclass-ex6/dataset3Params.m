function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.1;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

steps = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
min_error = inf;

for c_step = steps
  for sigma_step = steps
    % Train SVM model using current C and sigma values
    model = svmTrain(X, y, c_step, @(x1, x2) gaussianKernel(x1, x2, sigma_step)); 
    
    % Get predicted values on cross-validation dataset
    predictions = svmPredict(model, Xval);

    % Calculate error
    error_step = mean(double(predictions ~= yval));

    % Check if error is smaller then all previous erros
    if (error_step < min_error)
      min_error = error_step;
      C = c_step;
      sigma = sigma_step;
    endif
  endfor  
endfor

% =========================================================================

end
