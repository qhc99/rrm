function layers = net()
dropout = 0.2;
layers = [
    featureInputLayer(75,"Name","featureinput")
    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    dropoutLayer(dropout)

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    dropoutLayer(dropout)

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    dropoutLayer(dropout)

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    dropoutLayer(dropout)

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    dropoutLayer(dropout)

    fullyConnectedLayer(1024,"Name","fc")
    leakyReluLayer("Name","relu")

    fullyConnectedLayer(512,"Name","fc")
    leakyReluLayer("Name","relu")

    
    fullyConnectedLayer(15,"Name","fc_o")
    regressionLayer("Name","regressionoutput")];
end