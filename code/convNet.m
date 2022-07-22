function layers = convNet()
layers = [
    imageInputLayer([5 15 1],"Name","imageinput","Normalization","none")

    convolution2dLayer([5 5],128,"Name","conv_1","Padding","same")
    batchNormalizationLayer("Name","batchnorm_1")
    leakyReluLayer("Name","relu")

    convolution2dLayer([3 3],128,"Name","conv_3","Padding","same")
    batchNormalizationLayer("Name","batchnorm_3")
    leakyReluLayer("Name","relu")

    convolution2dLayer([3 3],128,"Name","conv_3","Padding","same")
    batchNormalizationLayer("Name","batchnorm_3")
    leakyReluLayer("Name","relu")


    fullyConnectedLayer(1024,"Name","fc_1")
    leakyReluLayer("Name","relu")

    dropoutLayer(0.3)

    fullyConnectedLayer(1024,"Name","fc_1")
    leakyReluLayer("Name","relu")

    dropoutLayer(0.3)

    fullyConnectedLayer(512,"Name","fc_4")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(15,"Name","fc_out")
    regressionLayer("Name","regressionoutput")];
end