%% Read data
fprintf('Updating training data.');
% datareadin();
fprintf('Training data updated.');

%% Initialization
clear;

%% Set up parameters
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   

%% Initialize parameters
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% Load data
load('data.mat');
dataLength = size(data,1); %data: Y, X: image
dataVeriLength = int16(dataLength * 0.3);
XVeri = X(1:dataVeriLength,:);
YVeri = data(1:dataVeriLength,:);
X = X(dataVeriLength + 1:end,:);
data = data(dataVeriLength + 1:end,:);


%% Train NN
options = optimset('MaxIter', 5000);
lambda = 1; %for regulaztion

costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, data, lambda);
                               
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
             
%% Save training result

save('weights.mat','Theta1','Theta2');
             
%% Prediction

pred = predict(Theta1, Theta2, XVeri);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == YVeri)) * 100);
