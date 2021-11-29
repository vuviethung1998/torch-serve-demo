#!/bin/bash

# Create densenet model archive
torch-model-archiver --model-name mnist --version 1.0 --model-file mnist.py --serialized-file mnist_cnn.pt --handler mnist_handler.py

# python /home/model-server/mnist.py
mv mnist.mar ./model_store/
# rm /home/model-server/mnist_cnn.pt


# Add model
curl -X POST "http://0.0.0.0:8081/models?initial_workers=1&synchronous=true&url=mnist.mar"

# Test model
curl -X POST "http://0.0.0.0:8080/predictions/mnist" -T 0.png