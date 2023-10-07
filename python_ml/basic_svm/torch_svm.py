import torch
import torch.optim as optim

# Generate some example data
X_train = torch.FloatTensor([[1, 1], [2, 2.5], [3, 1.2], [5.5, 6.3], [6, 9], [7, 6]])
y_train = torch.FloatTensor([0, 0, 0, 1, 1, 1])

# Initialize SVM parameters
W = torch.randn(1, 2, requires_grad=True)
b = torch.randn(1, requires_grad=True)
C = 1.0  # Regularization parameter

# Define optimizer
optimizer = optim.SGD([W, b], lr=0.01)

# Training loop
for epoch in range(100):
    for i in range(len(y_train)):
        x_i = X_train[i]
        y_i = y_train[i]
        
        # Forward pass: Compute predicted y by passing x to the model
        output = torch.matmul(W, x_i) + b
        
        # Compute the loss
        loss = 0.5 * torch.dot(W[0], W[0]) + C * torch.clamp(1 - y_i * output, min=0)
        
        # Zero gradients, perform a backward pass, and update the weights.
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

# Print the learned parameters
print("Weight:", W.data)
print("Bias:", b.data)
